// This example demonstrates function reference and closure usage
// Note: FFI extern "C" is not supported in wasm-gc backend

// Removed unsupported extern "C" FFI function for wasm-gc compatibility
// extern "C" fn ffi_qsort[T](
//   xs : Array[T], 
//   comp : (T, T) -> Int,
//   closure : Any
// ) : Unit = "ffi_qsort"

// Simple quicksort implementation as fallback
///|
fn[T] quicksort(arr : Array[T], compare : (T, T) -> Int) -> Unit {
  if arr.length() <= 1 {
    return
  }
  quicksort_range(arr, 0, arr.length() - 1, compare)
}

///|
fn[T] quicksort_range(
  arr : Array[T],
  low : Int,
  high : Int,
  compare : (T, T) -> Int,
) -> Unit {
  if low < high {
    let pi = partition(arr, low, high, compare)
    quicksort_range(arr, low, pi - 1, compare)
    quicksort_range(arr, pi + 1, high, compare)
  }
}

///|
fn[T] partition(
  arr : Array[T],
  low : Int,
  high : Int,
  compare : (T, T) -> Int,
) -> Int {
  let pivot = arr[high]
  let mut i = low - 1
  for j = low; j < high; j = j + 1 {
    if compare(arr[j], pivot) <= 0 {
      i = i + 1
      let temp = arr[i]
      arr[i] = arr[j]
      arr[j] = temp
    }
  }
  let temp = arr[i + 1]
  arr[i + 1] = arr[high]
  arr[high] = temp
  i + 1
}

// Convert main function to init function for proper main package syntax

///|
fn init {
  let arr = [3, 1, 4, 1, 5, 9, 2, 6]

  // Example of using function reference with closure
  let compare_closure = fn(a : Int, b : Int) -> Int { a - b }
  println("Original array:")
  for i = 0; i < arr.length(); i = i + 1 {
    println("@{arr[i]}")
  }

  // Use our quicksort implementation instead of FFI
  quicksort(arr, compare_closure)
  println("Sorted array:")
  for i = 0; i < arr.length(); i = i + 1 {
    println("@{arr[i]}")
  }
}
