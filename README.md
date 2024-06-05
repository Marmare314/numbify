# numbify

Numbify is a typst-library providing utilities for modifying
counters, which allows creating more complicated numberings.

## Examples

![](/assets/example-figures.png)
```typ
#import "@preview/numbify:0.1.0": concat-counter, override-counter

#set heading(numbering: "I.I")

// Create new figure counter.
// The new figure counter is a combination
// of the heading counter and the figure counter.
#let figure-counter = concat-counter(heading, figure.where(kind: image))

// Override figure counter with new counter.
// Use the numbering "I.I" for the heading part
// and "1" for the figure part.
#show figure.where(kind: image): set figure(numbering: override-counter(figure-counter, ("I.I", "1")))

= The Mona Lisa and Starry Night

#figure(
  image("/assets/mona-lisa-wikimedia.jpeg", width: 50pt),
  caption: "The Mona Lisa"
)
#figure(
  image("/assets/starry-night-wikimedia.jpeg", width: 70pt),
  caption: "Starry Night"
)

= The Scream

#figure(
  image("/assets/the-scream-wikimedia.jpeg", width: 80pt),
  caption: "The Scream"
)
```

See the [tests](/tests/examples/) for more examples.

## Documentation

A short overview of the most important functions is given here.
For more details, please refer to the [pdf-documentation](docs/docs.pdf).

- `concat-counter(counter-1, counter-2)`: Concatenate two counters.
- `slice-counter(counter, end, start: 1)`: Slice a range of levels from a counter.
- `override-counter(counter, numbering, separator: ".")`: Creates a numbering function that replaces the usual counter with the provided counter.
- `heading-level-range(end, start: 1)`: Returns a selector that selects a range of heading levels.
- `reset-counter-rule(counter)`: Reset a counter. This is a helper function that can be used in a show-rule.
