#import "std.typ"

// Unique ID for identifying "objects" created by numbify.
#let NUMBIFY-OBJECT-ID = "NUMBIFY-OBJECT-ID"

/// Checks if the argument was constructed by one of the counter-operations.
///
/// - arg (any):
/// -> boolean
#let is-numbify-counter(arg) = {
  type(arg) == dictionary and "id" in arg.keys() and arg.id == NUMBIFY-OBJECT-ID
}

/// Checks if the argument was constructed by the `concat-counter` operation.
///
/// - arg (any):
/// -> boolean
#let is-concat-counter(arg) = {
  is-numbify-counter(arg) and arg.op == "concat"
}

/// Checks if the argument was constructed by the `slice-counter` operation.
///
/// - arg (any):
/// -> boolean
#let is-slice-counter(arg) = {
  is-numbify-counter(arg) and arg.op == "slice"
}

/// Turns a `counter-like` into a `counter` by constructing the counter from the argument if necessary.
/// A `counter-like` is a `counter` or something that a `counter` can be constructed from.
///
/// - counter (counter-like):
/// -> counter
#let from-counter-like(counter) = {
  if type(counter) == std.counter {
    counter
  } else {
    (std.counter)(counter)
  }
}

/// Convert argument into `counter` or `numbify-counter`.
/// If the argument is a `numbify-counter`, it is returned as is.
/// Otherwise, the argument is converted into a `counter` if necessary.
///
/// - counter (counter-like, numbify-counter):
#let from-counter-like-or-numbify(counter) = {
  if is-numbify-counter(counter) {
    counter
  } else {
    from-counter-like(counter)
  }
}
