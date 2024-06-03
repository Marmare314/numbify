#import "/src/lib.typ": counter-at

#let counter = counter("counter")

#counter.step()
<l1>
#counter.step()
<l2>
#counter.step()

#context counter-at(counter, <l1>)
#context counter-at(counter, <l2>)
#context counter-at(counter, here())
