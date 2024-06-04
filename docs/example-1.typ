#import "/src/lib.typ": concat-counter, override-counter, reset-counter-rule

#let multi-figure-secret = "MULTI-FIGURE-SECRET"
#let multi-figure(..args, caption: none) = figure(
  kind: "multi-figure", supplement: "Figure", caption: caption,
  {
    metadata(multi-figure-secret)
    let sub-counter = concat-counter(
      figure.where(kind: "multi-figure"),
      metadata.where(value: multi-figure-secret)
    )
    set figure(numbering: override-counter(sub-counter, "1a"))
    show figure: it => {metadata(multi-figure-secret); it}
    table(..args)
  }
)

#multi-figure(caption: "Test", columns: 2,
  figure("A", caption: "A"),
  figure("B", caption: "B")
)
