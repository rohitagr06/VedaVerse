<?php
/**
 * VedaVerse — app/core/Router.php
 * ---------------------------------------------------------------------
 * WHAT IT DOES
 *   Holds the list of URLs the site answers to, matches an incoming
 *   request against it, runs the middleware, and calls the controller.
 *
 * WHAT DEPENDS ON IT
 *   index.php, which registers every route and then calls dispatch().
 *
 * HOW A ROUTE LOOKS
 *
 *   $router->get('/chapter/{chapter}/verse/{verse}',
 *                array('VedaVerse\Controllers\VerseController', 'show'))
 *          ->where('chapter', '[0-9]{1,2}')
 *          ->where('verse', '[0-9]{1,3}')
 *          ->name('verse.show');
 *
 *   {chapter} matches one path segment and arrives in the controller as
 *   $request->param('chapter'). where() narrows what it will match, which
 *   is worth doing on anything numeric: it turns a whole class of bad
 *   input into a clean 404 before any code runs.
 *
 * NAMED ROUTES
 *   name() lets a view build a URL with Router::url('verse.show', ...)
 *   instead of writing the path by hand. When a URL changes, one line
 *   changes instead of forty templates, and a typo becomes an exception
 *   rather than a silent dead link.
 *
 * MIDDLEWARE
 *   Runs outside the controller, in the order registered, as an onion:
 *   each one may inspect the request, hand it on, and then adjust the
 *   response on the way back out. A middleware may also stop the request
 *   dead by returning a Response instead of calling $next — which is how
 *   CsrfMiddleware refuses a forged form before any business logic sees it.
 *
 *   The middleware classes themselves arrive in Step 2 of the build order.
 *   The mechanism is here so the routes can name them.
 *
 * PHP 7.4 COMPATIBLE.
 */

namespace VedaVerse\Core;

use Exception;

class Router
{
    /** @var array<int,array> Registered routes. */
    private $routes = array();

    /** @var array<string,int> Route name => index into $routes */
    private $named = array();

    /** @var array<int,mixed> Middleware applied to every route. */
    private $globalMiddleware = array();

    /** @var array<string,string> Short name => middleware class. */
    private $aliases = array();

    /** @var array{prefix:string,middleware:array} Current group() context. */
    private $group = array('prefix' => '', 'middleware' => array());

    /** @var int|null Index of the route registered last, for the fluent helpers. */
    private $last = null;

    /** @var callable|null */
    private $notFound = null;

    /** @var callable|null */
    private $notAllowed = null;

    /** @var self|null The instance url() reaches for. */
    private static $instance = null;

    public function __construct()
    {
        self::$instance = $this;
    }

    // -----------------------------------------------------------------
    // Registration
    // -----------------------------------------------------------------

    /**
     * @param string $path
     * @param mixed  $action array(ClassName, 'method') or a closure.
     * @return self
     */
    public function get($path, $action)
    {
        return $this->add(array('GET', 'HEAD'), $path, $action);
    }

    /** @return self */
    public function post($path, $action)
    {
        return $this->add(array('POST'), $path, $action);
    }

    /** @return self */
    public function put($path, $action)
    {
        return $this->add(array('PUT'), $path, $action);
    }

    /** @return self */
    public function delete($path, $action)
    {
        return $this->add(array('DELETE'), $path, $action);
    }

    /** @return self */
    public function any($path, $action)
    {
        return $this->add(array('GET', 'HEAD', 'POST', 'PUT', 'PATCH', 'DELETE'), $path, $action);
    }

    /**
     * Register a route.
     *
     * @param array  $methods
     * @param string $path
     * @param mixed  $action
     * @return self
     */
    public function add(array $methods, $path, $action)
    {
        $path = $this->group['prefix'] . '/' . ltrim((string) $path, '/');
        $path = '/' . trim(preg_replace('#/+#', '/', $path), '/');
        if ($path === '/') {
            $path = '/';
        }

        $this->routes[] = array(
            'methods'     => $methods,
            'path'        => $path,
            'action'      => $action,
            'constraints' => array(),
            'middleware'  => $this->group['middleware'],
            'name'        => null,
        );

        $this->last = count($this->routes) - 1;
        return $this;
    }

    /**
     * Narrow what a placeholder will match.
     *
     * @param string $param
     * @param string $pattern A regular expression fragment, no delimiters.
     * @return self
     */
    public function where($param, $pattern)
    {
        if ($this->last !== null) {
            $this->routes[$this->last]['constraints'][$param] = $pattern;
        }
        return $this;
    }

    /**
     * Give the last route a name, for URL generation.
     *
     * @param string $name
     * @return self
     */
    public function name($name)
    {
        if ($this->last !== null) {
            $this->routes[$this->last]['name'] = $name;
            $this->named[$name] = $this->last;
        }
        return $this;
    }

    /**
     * Attach middleware to the last route.
     *
     * @param string|array $middleware Alias or class name, or a list.
     * @return self
     */
    public function middleware($middleware)
    {
        if ($this->last !== null) {
            $list = is_array($middleware) ? $middleware : array($middleware);
            $this->routes[$this->last]['middleware'] = array_merge(
                $this->routes[$this->last]['middleware'],
                $list
            );
        }
        return $this;
    }

    /**
     * Middleware that runs on every request. Security headers, session
     * handling, maintenance mode.
     *
     * @param string|array $middleware
     * @return self
     */
    public function globalMiddleware($middleware)
    {
        $list = is_array($middleware) ? $middleware : array($middleware);
        $this->globalMiddleware = array_merge($this->globalMiddleware, $list);
        return $this;
    }

    /**
     * Map a short name to a middleware class, so routes read as
     * ->middleware('auth') rather than a fully-qualified class name.
     *
     * @param array<string,string> $aliases
     * @return self
     */
    public function aliases(array $aliases)
    {
        $this->aliases = array_merge($this->aliases, $aliases);
        return $this;
    }

    /**
     * Register several routes sharing a prefix and middleware.
     *
     *   $router->group('/admin', array('auth', 'admin'), function ($r) {
     *       $r->get('/users', array(AdminController::class, 'users'));
     *   });
     *
     * @param string   $prefix
     * @param array    $middleware
     * @param callable $routes Receives this router.
     * @return self
     */
    public function group($prefix, array $middleware, $routes)
    {
        $previous = $this->group;

        $this->group = array(
            'prefix'     => rtrim($previous['prefix'] . '/' . trim((string) $prefix, '/'), '/'),
            'middleware' => array_merge($previous['middleware'], $middleware),
        );

        call_user_func($routes, $this);

        $this->group = $previous;
        return $this;
    }

    /**
     * What to do when nothing matched.
     *
     * @param callable $handler Receives the Request, returns a Response.
     * @return self
     */
    public function onNotFound($handler)
    {
        $this->notFound = $handler;
        return $this;
    }

    /**
     * What to do when the path matched but the method did not. Answering
     * 405 rather than 404 here is worth the extra branch: it tells you the
     * route exists and the form is posting to the wrong verb, which is
     * otherwise a confusing hour of debugging.
     *
     * @param callable $handler
     * @return self
     */
    public function onMethodNotAllowed($handler)
    {
        $this->notAllowed = $handler;
        return $this;
    }

    // -----------------------------------------------------------------
    // Dispatch
    // -----------------------------------------------------------------

    /**
     * Match the request and produce a response.
     *
     * @param Request $request
     * @return Response
     */
    public function dispatch(Request $request)
    {
        $path          = $request->path();
        $method        = $request->method();
        $pathMatched   = false;
        $allowed       = array();

        foreach ($this->routes as $route) {
            $params = $this->match($route, $path);
            if ($params === null) {
                continue;
            }

            $pathMatched = true;
            $allowed     = array_merge($allowed, $route['methods']);

            if (!in_array($method, $route['methods'], true)) {
                continue;
            }

            $request->setParams($params);
            return $this->runPipeline($route, $request);
        }

        if ($pathMatched) {
            $response = $this->notAllowed !== null
                ? call_user_func($this->notAllowed, $request)
                : new Response('Method not allowed', 405);
            // A 405 must say which methods would have worked. Some clients
            // rely on it and it costs one header.
            return $response->header('Allow', implode(', ', array_unique($allowed)));
        }

        if ($this->notFound !== null) {
            return call_user_func($this->notFound, $request);
        }
        return new Response('Not found', 404);
    }

    /**
     * Test one route against a path.
     *
     * @param array  $route
     * @param string $path
     * @return array<string,string>|null Parameters, or null for no match.
     */
    private function match(array $route, $path)
    {
        $pattern = $route['path'];

        // A route with no placeholders is a plain string comparison, which
        // is a great deal cheaper than a regular expression and covers most
        // of the route table.
        if (strpos($pattern, '{') === false) {
            return $pattern === $path ? array() : null;
        }

        $names = array();

        // Build a regex from the route, escaping everything except the
        // placeholders so a dot in a path stays a literal dot.
        $regex = preg_replace_callback(
            '#\{([a-zA-Z_][a-zA-Z0-9_]*)\}#',
            function ($m) use (&$names, $route) {
                $names[] = $m[1];
                $constraint = isset($route['constraints'][$m[1]])
                    ? $route['constraints'][$m[1]]
                    : '[^/]+'; // one segment, never crossing a slash
                return '(' . $constraint . ')';
            },
            // preg_quote first would also escape our braces, so quote the
            // literal parts only.
            preg_replace('#([\.\+\?\[\]\^\$\(\)\|\\\\])#', '\\\\$1', $pattern)
        );

        if (preg_match('#^' . $regex . '$#u', $path, $matches) !== 1) {
            return null;
        }

        array_shift($matches);

        $params = array();
        foreach ($names as $i => $name) {
            $params[$name] = isset($matches[$i]) ? $matches[$i] : null;
        }
        return $params;
    }

    /**
     * Wrap the controller in its middleware and run the result.
     *
     * Built from the inside out: the controller becomes the innermost
     * function, then each middleware wraps what came before, so the first
     * one registered is the outermost and sees the request first and the
     * response last.
     *
     * @param array   $route
     * @param Request $request
     * @return Response
     */
    private function runPipeline(array $route, Request $request)
    {
        $router = $this;
        $action = $route['action'];

        $core = function (Request $req) use ($router, $action) {
            return $router->callAction($action, $req);
        };

        $stack = array_merge($this->globalMiddleware, $route['middleware']);

        // array_reverse so that after all the wrapping, the first entry in
        // $stack ends up outermost.
        foreach (array_reverse($stack) as $middleware) {
            $next = $core;
            $core = function (Request $req) use ($middleware, $next, $router) {
                return $router->callMiddleware($middleware, $req, $next);
            };
        }

        $response = call_user_func($core, $request);

        return $response instanceof Response
            ? $response
            : new Response((string) $response, 200, array('Content-Type' => 'text/html; charset=utf-8'));
    }

    /**
     * Instantiate the controller and call the method.
     *
     * Public because the closure above needs it. Not part of the API you
     * should call from anywhere else.
     *
     * @param mixed   $action
     * @param Request $request
     * @return mixed
     * @throws Exception
     */
    public function callAction($action, Request $request)
    {
        if (is_callable($action) && !is_array($action)) {
            return call_user_func($action, $request);
        }

        if (is_array($action) && count($action) === 2) {
            list($class, $method) = $action;

            if (!class_exists($class)) {
                throw new Exception('Route points at a controller that does not exist: ' . $class);
            }
            $controller = new $class();

            if (!method_exists($controller, $method)) {
                throw new Exception('Route points at a missing method: ' . $class . '::' . $method);
            }
            return $controller->$method($request);
        }

        throw new Exception('This route has no usable action.');
    }

    /**
     * Resolve a middleware alias to a class and run it.
     *
     * @param mixed    $middleware
     * @param Request  $request
     * @param callable $next
     * @return mixed
     * @throws Exception
     */
    public function callMiddleware($middleware, Request $request, $next)
    {
        if (is_callable($middleware) && !is_string($middleware)) {
            return call_user_func($middleware, $request, $next);
        }

        $class = isset($this->aliases[$middleware]) ? $this->aliases[$middleware] : $middleware;

        if (!class_exists($class)) {
            // A named middleware that does not exist means a route is
            // unprotected. Fail the request rather than quietly skipping
            // it: a missing AuthMiddleware must never mean "allow".
            Logger::critical('Missing middleware, refusing the request', array('middleware' => $class));
            throw new Exception('A required middleware is missing.');
        }

        $instance = new $class();
        if (!method_exists($instance, 'handle')) {
            throw new Exception('Middleware has no handle() method: ' . $class);
        }

        return $instance->handle($request, $next);
    }

    // -----------------------------------------------------------------
    // URL generation
    // -----------------------------------------------------------------

    /**
     * Build the path for a named route.
     *
     *   Router::url('verse.show', array('chapter' => 2, 'verse' => 47))
     *   -> /chapter/2/verse/47
     *
     * @param string $name
     * @param array  $params
     * @return string
     */
    public static function url($name, array $params = array())
    {
        if (self::$instance === null || !isset(self::$instance->named[$name])) {
            Logger::warning('Unknown route name', array('name' => $name));
            return '/';
        }

        $route = self::$instance->routes[self::$instance->named[$name]];
        $path  = $route['path'];

        foreach ($params as $key => $value) {
            $path = str_replace('{' . $key . '}', rawurlencode((string) $value), $path);
        }

        // A leftover placeholder means the caller forgot an argument. Say
        // so in the log rather than emitting a link containing {verse}.
        if (strpos($path, '{') !== false) {
            Logger::warning('Route URL is missing a parameter', array('name' => $name, 'path' => $path));
        }

        return $path;
    }

    /**
     * Every registered route. Used by sitemap.php and by the admin route
     * list.
     *
     * @return array<int,array>
     */
    public function routes()
    {
        return $this->routes;
    }
}
