#import "/src/lib.typ": reset-counter, reset-counter-rule

#let counter = counter("counter")

#show "b": reset-counter-rule(counter)

#counter.step()

#context counter.get()
#reset-counter(counter)
#context counter.get()

#counter.step()

#context counter.get()
#reset-counter("counter")
#context counter.get()

#counter.step()

#context counter.get()
a
#context counter.get()
b
#context counter.get()
