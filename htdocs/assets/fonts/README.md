# Fonts

VedaVerse self-hosts three typefaces. **The files are not in this repository**
and you need to fetch them once. It takes about five minutes.

Until you do, the site falls back to the system font stack declared in
`tokens.css` and looks perfectly reasonable — a downgrade, not a breakage. The
one thing that genuinely suffers is the shloka, which needs a proper Devanagari
serif to render conjuncts correctly.

---

## Why they are not committed

Not a licensing problem — all three are under the SIL Open Font License, which
permits redistribution. Two practical reasons instead.

The subsetted `woff2` files are around 400 KB in total, and a git repository
that carries binary assets grows forever, because every future version of a
binary is stored whole rather than as a diff.

More importantly, subsetting is a decision that should be made deliberately
rather than inherited. The right character coverage depends on how much
Devanagari Extended the seed content actually uses, and that is not known until
Step 6 writes the 108 verses. Fetching them yourself means you can re-subset
later without fighting a committed file.

---

## What to download

All three are on Google Fonts under the Open Font License.

| Save as | Family | Where |
|---|---|---|
| `baloo2-latin.woff2` | Baloo 2 | [fonts.google.com/specimen/Baloo+2](https://fonts.google.com/specimen/Baloo+2) |
| `baloo2-devanagari.woff2` | Baloo 2 (Devanagari subset) | same |
| `mukta-regular.woff2` | Mukta 400 | [fonts.google.com/specimen/Mukta](https://fonts.google.com/specimen/Mukta) |
| `mukta-bold.woff2` | Mukta 700 | same |
| `noto-serif-devanagari.woff2` | Noto Serif Devanagari | [fonts.google.com/noto/specimen/Noto+Serif+Devanagari](https://fonts.google.com/noto/specimen/Noto+Serif+Devanagari) |

Put all five in this folder. The filenames must match exactly — they are what
`assets/css/fonts.css` asks for.

---

## The easy way

`google-webfonts-helper` produces ready-made `woff2` subsets without you having
to run a conversion tool:

1. Open [gwfh.mranftl.com](https://gwfh.mranftl.com/fonts)
2. Search for the family.
3. Under **Select charsets**, tick `latin` for Baloo 2 and Mukta, and
   `devanagari` for the Devanagari cuts.
4. Under **Select styles**, tick 400 and 700 (Baloo 2 is variable, so one
   file covers the range).
5. Download, unzip, rename to the filenames in the table above.

---

## The thorough way

If you want control over exactly which characters are included — worth doing
once the seed content exists and you know what it uses:

```bash
pip install fonttools brotli

# Download the .ttf from Google Fonts first, then:
pyftsubset NotoSerifDevanagari-Regular.ttf \
  --unicodes="U+0900-097F,U+1CD0-1CF9,U+200C-200D,U+20A8,U+20B9,U+A830-A839" \
  --layout-features="*" \
  --flavor=woff2 \
  --output-file=noto-serif-devanagari.woff2
```

**`--layout-features="*"` is not optional for Devanagari.** It keeps the
OpenType shaping tables, which are what join consonants into conjuncts. Strip
them to save a few kilobytes and क् + ष renders as two separate letters instead
of क्ष — which is not a cosmetic difference, it is a different word.

---

## Checking it worked

Open `/styleguide` and look at the shloka. Compare against this, which is
Bhagavad Gita 2.47:

> कर्मण्येवाधिकारस्ते मा फलेषु कदाचन

If the conjuncts render as single joined forms, the font and its shaping tables
are both present. If you see separate letters with visible halant marks between
them, the font loaded but its layout features were stripped. If you see
rectangles, no Devanagari font is available at all.

---

## Licence

All three are under the SIL Open Font License 1.1, which permits self-hosting
and redistribution in a product, commercial or not. Keep the `OFL.txt` that
comes in each download alongside the font files. When you settle the project's
own licence, note these as bundled third-party fonts.
