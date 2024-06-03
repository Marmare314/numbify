#import "std.typ"

// Unique ID for identifying "objects" created by numbify.
#let NUMBIFY-OBJECT-ID = "NUMBIFY-OBJECT-ID"

/// Checks if the argument was constructed by one of the counter-operations.
///
/// - arg (any):
/// -> boolean
#let is-counter-operation(arg) = {
  type(arg) == dictionary and "id" in arg.keys() and arg.id == NUMBIFY-OBJECT-ID
}

/// Checks if the argument was constructed by the `concat-counter` operation.
///
/// - arg (any):
/// -> boolean
#let is-concat-counter(arg) = {
  is-counter-operation(arg) and arg.op == "concat"
}

/// Checks if the argument was constructed by the `slice-counter` operation.
///
/// - arg (any):
/// -> boolean
#let is-slice-counter(arg) = {
  is-counter-operation(arg) and arg.op == "slice"
}

/// Checks if the argument is either a `counter` or the result of a counter-operation.
///
/// - arg (any):
/// -> boolean
#let is-numbify-counter(arg) = {
  type(arg) == counter or is-counter-operation(arg)
}

/// Turns a `counter-like` into a `numbify-counter` by constructing the counter from the argument if necessary.
/// A `counter-like` is a `counter`, something that a `counter` can be constructed from or the result of a counter-operation.
///
/// - counter (counter-like):
/// -> numbify-counter
#let from-counter-like(counter) = {
  if is-numbify-counter(counter) {
    counter
  } else {
    (std.counter)(counter)
  }
}
