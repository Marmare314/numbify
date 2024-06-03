#import "/src/lib.typ": heading-level-range

#show heading: it => it.body

#let x = [
  = A
  == B
  === C
  ==== D
  ===== E
  ====== F
  = G
  == H
  === I
  ==== J
  ===== K
  ====== L
]

#x

#{
  show heading-level-range(4): set text(red)
  x
}

#{
  show heading-level-range(4, start: 2): set text(red)
  x
}

#{
  show heading-level-range(4, start: 4): set text(red)
  x
}

