#import "/src/lib.typ": numbify-numbering

#let f(..nums) = { numbering("(1.1)", ..nums) }

#numbify-numbering("(1.1)", (1, 2, 3, 4))
#numbify-numbering(f, (1, 2, 3, 4))

#numbify-numbering("(1.1)", (1, (2, 3, 4)))
#numbify-numbering("(1.1)", (1, (2, (3, 4))))

#numbify-numbering(("(1.1)", "(I.I)"), ((1, 2), (3, 4)))
#numbify-numbering(("(1.1)", ("(I.I)", "(a.a)")), ((1, 2), ((3, 4), (5, 6))))
#numbify-numbering((f, "(I.I)"), ((1, 2), (3, 4)))
#numbify-numbering(("(1.1)", "(I.I)"), separator: text(red)[-], ((1, 2), (3, 4)))
