#import "util.typ": *

/// Concatenate two counter-like objects.
/// The state can be obtained using `counter-at()`.
///
/// - counter-1 (counter-like):
/// - counter-2 (counter-like):
/// -> numbify-counter
#let concat-counter(counter-1, counter-2) = {
  (
    id: NUMBIFY-OBJECT-ID,
    op: "concat",
    counter-1: from-counter-like(counter-1),
    counter-2: from-counter-like(counter-2)
  )
}

/// Slice a counter-like object.
/// The state can be obtained using `counter-at()`.
///
/// - end (integer, none): The end-level of the slice (inclusive). If none, the slice goes to the last level of the counter.
/// - start (integer): The start-level of the slice.
/// - counter (counter-like):
/// -> numbify-counter
#let slice-counter(counter, end, start: 1) = {
  assert(1 <= start, message: "the start level must be at least 1")
  if end != none {
    assert(start <= end, message: "the start level must be less than or equal to the end level")
  }

  (
    id: NUMBIFY-OBJECT-ID,
    op: "slice",
    counter: from-counter-like(counter),
    start: start,
    end: end
  )
}

/// Retrieves the value of the `counter-like` at the given location.
/// Behaves similar to #link("https://typst.app/docs/reference/introspection/counter/#definitions-at")[`counter.at()`].
/// For concatenated counters an array of both states is returned.
///
/// _This function is contextual._
///
/// - counter (counter-like):
/// - selector (label, selector, location, function): The place at which the counter's value should be retrieved.
/// -> array
#let counter-at(counter, selector) = {
  counter = from-counter-like(counter)

  if type(counter) == std.counter {
    counter.at(selector)
  } else if is-concat-counter(counter) {
    (counter-at(counter.counter-1, selector), counter-at(counter.counter-2, selector))
  } else if is-slice-counter(counter) {
    let numbers = counter-at(counter.counter, selector)

    if counter.end == none {
      counter-at(counter.counter, selector).slice(counter.start - 1)
    } else {
      let end = calc.min(counter.end, numbers.len())
      counter-at(counter.counter, selector).slice(counter.start - 1, end)
    }
  }
}

/// Retrieves the value of the counter at the current location.
///
/// This is equivalent to ```typ counter-at(counter, here())```.
///
/// _This function is contextual._
///
/// - counter (counter-like):
/// -> array
#let counter-get(counter) = {
  counter-at(counter, here())
}

/// Applies a numbering to the state of a numbify-counter.
/// Similar to #link("https://typst.app/docs/reference/model/numbering/")[`numbering()`].
///
/// - numbering (str, function, array): If a string or function is provided,
///   the numbering is applied to the combined state of all counters. If an array is provided,
///   the numbering is applied to each counter individually and then concatenated.
/// - seperator (content): In case of an array numbering, this seperator is used to join the individual numberings.
/// - ..numbers (array): The state of the numbify-counter.
/// -> function
#let numbify-numbering(numbering, seperator: ".", ..numbers) = {
  assert(numbers.named().len() == 0, message: "TODO")
  assert(numbers.pos().len() > 0, message: "TODO")
  numbers = numbers.pos()

  if type(numbering) == str or type(numbering) == function {
    (std.numbering)(numbering, ..numbers.flatten())
  } else if type(numbering) == array {
    assert(numbering.len() == 2, message: "TODO")
    assert(numbers.len() == 2, message: "TODO")

    numbering.zip(numbers).map(
      ((f, n)) => numbify-numbering(f, ..n)
    ).join(seperator)
  }
}

/// Creates a numbering function that replaces the usual counter
/// with the provided counter. The numbering is applied to the counter
/// using `numbify-numbering()`.
///
/// _The returned function is contextual._
///
/// - counter (counter-like): The new counter.
/// - numbering (str, function, array): The numbering that will be applied to the counter.
/// - seperator (content): The seperator that will be used to join the individual numberings.
/// -> function
#let override-counter(counter, numbering, seperator: ".") = {
  (..) => { numbify-numbering(numbering, seperator: seperator, ..counter-get(counter)) }
}

/// Returns a selector that selects a range of heading levels.
///
/// - end (integer): The end level (inclusive).
/// - start (integer): The start level (inclusive).
/// -> selector
#let heading-level-range(end, start: 1) = {
  assert(start <= end, message: "the start level must be less than or equal to the end level")

  let s = selector(heading.where(level: start))
  for i in range(start + 1, end + 1) {
    s = s.or(heading.where(level: i))
  }
  return s
}

/// Reset the counter.
/// The update only occurs if the resulting content is put into the document.
///
/// counter (counter, str, label, selector, location, function): TODO
/// -> content
#let reset-counter(counter) = {
  assert(not is-counter-operation(counter), message: "the counter must not be a counter operation")

  from-counter-like(counter).update(0)
}

/// Reset the counter.
/// This is a helper function that can be used in a show-rule.
///
/// - counter (counter, str, label, selector, location, function): TODO
/// -> function
#let reset-counter-rule(counter) = {
  it => {
    reset-counter(counter)
    it
  }
}
