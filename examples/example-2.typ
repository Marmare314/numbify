#import "/src/lib.typ": concat-counter, slice-counter, override-counter, reset-counter-rule, heading-level-range

#set heading(numbering: "1.1")

// Create new equation counter.
#let equation-counter = concat-counter(slice-counter(heading, 2), math.equation)

// Override equation counter with new counter.
#set math.equation(numbering: override-counter(equation-counter, "(1.1)"))

// Reset equation counter for each heading level up to 2.
#show heading-level-range(2): reset-counter-rule(math.equation)

= Mathematics
This document presents some famous mathematical equations.

== Euler's Identity
Euler's identity combines five fundamental mathematical constants into a single equation:

$ e^(i pi) + 1 = 0. $

=== Alternative Form
Euler's identity can also be expressed in the following form:

$ e^(i pi) = -1. $

== Pythagoras' Theorem
Pythagoras' theorem describes the relationship between the sides of a right triangle:

$ a^2 + b^2 = c^2 $

where $a$ and $b$ are the lengths of the triangle's two shorter sides,
and $c$ is the length of the hypotenuse.

=== Alternative Form
Pythagoras' theorem can also be expressed in the following form:

$ c = sqrt(a^2 + b^2). $

#outline(target: math.equation)
