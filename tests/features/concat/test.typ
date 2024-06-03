#import "/src/lib.typ": concat-counter, counter-get

#let counter-1 = counter("counter-1")
#let counter-2 = counter("counter-2")
#let counter = concat-counter(counter-1, counter-2)

#context counter-get(counter)

#counter-1.step()

#context counter-get(counter)

#counter-2.step()

#context counter-get(counter)
