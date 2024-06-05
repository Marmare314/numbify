#import "/src/lib.typ": concat-counter, override-counter
#set page(width: 350pt, height: auto, margin: 10pt)

#set heading(numbering: "I.I")

// Create new figure counter.
// The new figure counter is a combination of the heading counter and the figure counter.
#let figure-counter = concat-counter(heading, figure.where(kind: image))

// Override figure counter with new counter.
// Use the numbering "I.I" for the heading part and "1" for the figure part.
#show figure.where(kind: image): set figure(numbering: override-counter(figure-counter, ("I.I", "1")))

= The Mona Lisa and Starry Night

#align(center, grid(columns: 2, column-gutter: 20pt,
  figure(
    image("/assets/mona-lisa-wikimedia.jpeg", width: 50pt),
    caption: "The Mona Lisa"
  ),
  align(horizon, figure(
    image("/assets/starry-night-wikimedia.jpeg", width: 70pt),
    caption: "Starry Night"
  ))
))

= The Scream

#figure(
  image("/assets/the-scream-wikimedia.jpeg", width: 80pt),
  caption: "The Scream"
)
