// MoonBit function reference map in-place implementation
// Converting from main function to init function for proper main package syntax

///|
fn init {
  // Initialize the module
}

// Removed extern "C" declaration as it's unsupported in wasm-gc backend
// Original function with borrow annotation converted to regular function

///|
pub fn[T] map_inplace(xs : Array[T], call : (T) -> T) -> Unit {
  for i = 0; i < xs.length(); i = i + 1 {
    xs[i] = call(xs[i])
  }
}
