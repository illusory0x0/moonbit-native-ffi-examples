// Converted from main function to init function for proper main package syntax
///|
fn init {
  // Quick sort implementation using function references
  let xs = [3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5]

  // Instead of extern "C" FFI (unsupported in wasm-gc), use MoonBit quicksort
  let sorted = qsort(xs, fn(a, b) { a.compare(b) })
  println(sorted)
}

// MoonBit implementation of quicksort using function references

///|
fn[T] qsort(arr : Array[T], comp : (T, T) -> Int) -> Array[T] {
  if arr.length() <= 1 {
    return arr
  }
  let pivot = arr[arr.length() / 2]
  let less = []
  let equal = []
  let greater = []
  for i = 0; i < arr.length(); i = i + 1 {
    let elem = arr[i]
    let cmp_result = comp(elem, pivot)
    if cmp_result < 0 {
      less.push(elem)
    } else if cmp_result > 0 {
      greater.push(elem)
    } else {
      equal.push(elem)
    }
  }
  let sorted_less = qsort(less, comp)
  let sorted_greater = qsort(greater, comp)

  // Concatenate arrays
  let result = []
  for elem in sorted_less {
    result.push(elem)
  }
  for elem in equal {
    result.push(elem)
  }
  for elem in sorted_greater {
    result.push(elem)
  }
  return result
}
