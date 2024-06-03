#import "@preview/tidy:0.3.0"

#set heading(numbering: "1.1")
#show link: it => underline(text(blue, it), offset: 0.1em)

= Function Documentation
#set heading(numbering: none)

#let colors = (
  ..tidy.styles.default.colors,
  counter-like: rgb(0, 255, 255, 50),
  numbify-counter: rgb(255, 255, 0, 50),
)

#let docs-lib = tidy.parse-module(read("/src/lib.typ"))
#tidy.show-module(docs-lib, style: tidy.styles.default, colors: colors, show-outline: false, sort-functions: none, first-heading-level: 1)

#let docs-util = tidy.parse-module(read("/src/util.typ"))
#tidy.show-module(docs-util, style: tidy.styles.default, colors: colors, show-outline: false, sort-functions: none, first-heading-level: 1)
