#import "/src/lib.typ": slice-counter, counter-get

#let counter = counter("counter")
#counter.update((1, 2, 3, 4, 5, 6, 7, 8, 9))

#context counter-get(slice-counter(counter, 2))

#context counter-get(slice-counter(counter, 4))

#context counter-get(slice-counter(counter, 6))

#context counter-get(slice-counter(counter, 8))

#context counter-get(slice-counter(counter, 2, start: 1))

#context counter-get(slice-counter(counter, 4, start: 2))

#context counter-get(slice-counter(counter, 6, start: 3))

#context counter-get(slice-counter(counter, 8, start: 4))

#context counter-get(slice-counter(counter, none))

#context counter-get(slice-counter(counter, none, start: 4))
