#import "/src/lib.typ": override-counter, concat-counter, slice-counter, reset-counter-rule

#set heading(numbering: "1.1")
#set math.equation(numbering: override-counter(concat-counter(slice-counter(heading, 2), math.equation), "(1.1)"))
#show heading.where(level: 1): reset-counter-rule(math.equation)

#outline(target: math.equation)

= A
$ A $
== B
$ B $
=== C
$ C $
= D
$ D $
== E
$ E $
=== F
$ F $

#outline(target: math.equation)
