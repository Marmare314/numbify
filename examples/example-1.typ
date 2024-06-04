#import "/src/lib.typ": concat-counter, override-counter, reset-counter-rule

// Unique value of metadata used to count sub-figures.
#let multi-figure-secret = "MULTI-FIGURE-SECRET"

// Reset the sub-figure counter for each multi-figure.
#show figure.where(kind: "multi-figure"): reset-counter-rule(metadata.where(value: multi-figure-secret))

#let multi-figure(..args, caption: none) = figure(
  kind: "multi-figure", supplement: "Figure", caption: caption,
  {
    // Increase the sub-figure counter to one.
    metadata(multi-figure-secret)

    // Concatenate the multi-figure counter with the sub-figure counter.
    let sub-counter = concat-counter(
      figure.where(kind: "multi-figure"),
      metadata.where(value: multi-figure-secret)
    )

    // Override counter of figures with the concatenated counter.
    set figure(numbering: override-counter(sub-counter, "1a"))

    // Step the sub-figure counter on each figure.
    show figure: it => {metadata(multi-figure-secret); it}

    table(..args)
  }
)

#multi-figure(caption: "Test", columns: 2,
  figure("A", caption: "A"),
  figure("B", caption: "B")
)

#multi-figure(caption: "Test", columns: 2,
  figure("A", caption: "A"),
  figure("B", caption: "B")
)
