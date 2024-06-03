#import "/src/lib.typ": concat-counter, override-counter, reset-counter-rule

#let subfigure = figure.with(kind: "subfigure", supplement: "Figure")
#let subfigure-counter = concat-counter(figure.where(kind: table), figure.where(kind: "subfigure"))

#show figure.where(kind: "subfigure"): set figure(numbering: override-counter(subfigure-counter, "1.1"))
#show figure.where(kind: table): reset-counter-rule(figure.where(kind: "subfigure"))

#figure(table(columns: 2,
  subfigure("A", caption: "A"),
  subfigure("B", caption: "B"),
  subfigure("C", caption: "C"),
  subfigure("D", caption: "D")
), caption: "T")

#figure(table(columns: 2,
  subfigure("A", caption: "A"),
  subfigure("B", caption: "B"),
  subfigure("C", caption: "C"),
  subfigure("D", caption: "D")
), caption: "T")
