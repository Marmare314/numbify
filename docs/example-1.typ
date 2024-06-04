#import "/src/lib.typ": concat-counter, override-counter, reset-counter-rule

#let subfigure(..args) = {
  // let subfigure-counter = concat-counter(query(figure).last().counter, "")
  // figure(..args, numbering: override-counter(subfigure-counter, "1.1"))
}

#figure(table(columns: 2,
  subfigure("A", caption: "A"),
  subfigure("B", caption: "B"),
  subfigure("C", caption: "C"),
  subfigure("D", caption: "D")
), caption: "T")

// #let multi-figure(..figures) = figure(kind: "multi-figure", supplement: "Figure", grid(gutter: 3em, ..figures), caption: "test", numbering: "1.1")
// #let multi-figure-counter = concat-counter(figure.where(kind: "multi-figure"), counter(figure))

// #show figure.where(kind: "multi-figure"): reset-counter-rule(figure)
// #show figure.where(kind: "multi-figure"): set figure(numbering: override-counter(multi-figure-counter, "1.1"))

// #multi-figure(columns: 2,
//   figure("A", caption: "Test"),
//   figure("B", caption: "Test")
// )

// #multi-figure(columns: 2,
//   [#figure("A", caption: "Test") <a2>],
//   figure("B", caption: "Test")
// )

// @a2

// #outline(target: figure)


// #let subfigure = figure.with(kind: "subfigure", supplement: "Figure")
// #let subfigure-counter = concat-counter(figure.where(kind: table), figure.where(kind: "subfigure"))

// #show figure.where(kind: "subfigure"): set figure(numbering: override-counter(subfigure-counter, "1.1"))
// #show figure.where(kind: table): reset-counter-rule(figure.where(kind: "subfigure"))

// #figure(table(columns: 2,
//   subfigure("A", caption: "A"),
//   subfigure("B", caption: "B"),
//   subfigure("C", caption: "C"),
//   subfigure("D", caption: "D")
// ), caption: "T")

// #figure(table(columns: 2,
//   subfigure("A", caption: "A"),
//   subfigure("B", caption: "B"),
//   subfigure("C", caption: "C"),
//   subfigure("D", caption: "D")
// ), caption: "T")
