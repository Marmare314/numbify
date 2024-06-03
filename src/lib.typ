#import "util.typ": *

/// Concatenate two counters.
/// The state of the resulting counter, obtained by `counter-at()`,
/// is an array of both states.
///
/// - counter-1 (counter-like, numbify-counter):
/// - counter-2 (counter-like, numbify-counter):
/// -> numbify-counter
#let concat-counter(counter-1, counter-2) = {
  (
    id: NUMBIFY-OBJECT-ID,
    op: "concat",
    counter-1: from-counter-like-or-numbify(counter-1),
    counter-2: from-counter-like-or-numbify(counter-2)
  )
}

/// Slices a range of levels from a counter.
/// The state of the resulting counter can be obtained using `counter-at()`.
///
/// - end (integer, none): The end-level of the slice (inclusive).
///   If `none`, the slice goes to the last level of the counter.
/// - start (integer): The start-level of the slice.
/// - counter (counter-like):
/// -> numbify-counter
#let slice-counter(counter, end, start: 1) = {
  assert(1 <= start, message: "start must be at least 1")
  if end != none {
    assert(start <= end, message: "start must be less than or equal to end")
  }

  (
    id: NUMBIFY-OBJECT-ID,
    op: "slice",
    counter: from-counter-like(counter),
    start: start,
    end: end
  )
}

/// Retrieves the value of a `counter-like` or `numbify-counter` at the given location.
/// Behaves similar to #link("https://typst.app/docs/reference/introspection/counter/#definitions-at")[`counter.at()`].
///
/// _This function is contextual._
///
/// - counter (counter-like, numbify-counter):
/// - selector (label, selector, location, function): The place at which the counter's value should be retrieved.
/// -> array
#let counter-at(counter, selector) = {
  counter = from-counter-like-or-numbify(counter)

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
/// - counter (counter-like, numbify-counter):
/// -> array
#let counter-get(counter) = {
  counter-at(counter, here())
}

/// Applies a numbering to a sequence of integers or two arrays of integers.
/// It behaves like #link("https://typst.app/docs/reference/model/numbering/")[`numbering()`]
/// for a sequence of integers. The rest of the documentation for this function
/// therefore only describes the behaviour when two arrays of integers are provided.
///
/// - numbering (str, function, array): If the numbering is a string or a function,
///   the numbering will be applied to the concatenation of the two arrays.
///   If the numbering is an array of two numberings, each numbering will be applied
///   to the corresponding array and the results will be joined using the separator.
/// - separator (content): In case of an array-numbering, this separator is used to join the individual numberings.
/// - ..numbers (array): Either a sequence of integers or two arrays of integers.
/// -> function
#let numbify-numbering(numbering, separator: ".", ..numbers) = {
  // TODO: make the logic easier and safer
  assert(numbers.named().len() == 0, message: "TODO")
  assert(numbers.pos().len() > 0, message: "TODO")
  numbers = numbers.pos()

  if type(numbering) == str or type(numbering) == function {
    (std.numbering)(numbering, ..numbers.flatten())
  } else if type(numbering) == array {
    assert(numbering.len() == 2, message: "TODO")
    assert(numbers.len() == 2, message: "TODO")
    // TODO: make sure that numbers is an array of arrays

    numbering.zip(numbers).map(
      ((f, n)) => numbify-numbering(f, ..n)
    ).join(separator)
  }
}

/// Creates a numbering function that replaces the usual counter
/// with the provided counter. The numbering is applied to the counter
/// using `numbify-numbering()`.
///
/// _The returned function is contextual._
///
/// - counter (counter-like, numbify-counter): The new counter.
/// - numbering (str, function, array): The numbering that will be applied to the counter.
/// - separator (content): The separator that will be used to join the individual numberings
///   in case of an array-numbering.
/// -> function
#let override-counter(counter, numbering, separator: ".") = {
  (..) => { numbify-numbering(numbering, separator: separator, ..counter-get(counter)) }
}

/// Returns a selector that selects a range of heading levels.
///
/// - end (integer): The end-level (inclusive).
/// - start (integer): The start-level (inclusive).
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
/// counter (counter-like):
/// -> content
#let reset-counter(counter) = {
  from-counter-like(counter).update(0)
}

/// Reset the counter.
/// This is a helper function that can be used in a show-rule.
///
/// - counter (counter-like):
/// -> function
#let reset-counter-rule(counter) = {
  it => {
    reset-counter(counter)
    it
  }
}
