#import "/src/lib.typ": override-counter, concat-counter

#let counter = counter("counter")

#set heading(numbering: override-counter(counter, "1.1"))

= A
#counter.step()
== B
=== C
#counter.step()
= D
== E
#counter.update((1, 2, 3))
=== F

#set heading(numbering: override-counter(concat-counter(counter, counter), ("1.1", "I.I"), seperator: "-"))

= G
