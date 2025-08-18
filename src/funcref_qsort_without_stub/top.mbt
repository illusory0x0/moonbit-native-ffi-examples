///|
struct ConstPtr[T](Int)

///|
struct MutPtr[T](Int)

///|
fn[T] ConstPtr::add(self : ConstPtr[T], index : Int) -> ConstPtr[T] {
  // Simplified implementation without size_of
  ConstPtr(self.0 + index)
}

// Commented out: extern "C" is unsupported in wasm-gc backend
// extern "c" fn ConstPtr::read_int(self : ConstPtr[Int], index : Int) -> Int = "ffi_read_int"

///|
fn ConstPtr::read_int(self : ConstPtr[Int], index : Int) -> Int {
  // Placeholder implementation - actual FFI reading logic needs to be implemented
  // for wasm-gc backend  
  abort("ConstPtr::read_int not implemented for wasm-gc")
}

// Commented out: extern "C" is unsupported in wasm-gc backend
// extern "c" fn qsort(
//   #borrow(xs, count, elem_size, comp)
//   xs : MutPtr[Unit],
//   count : Int,
//   elem_size : Int,
//   comp : (ConstPtr[Unit], ConstPtr[Unit]) -> Int
// ) = "qsort"

///|
fn qsort(
  xs : MutPtr[Unit],
  count : Int,
  elem_size : Int,
  comp : (ConstPtr[Unit], ConstPtr[Unit]) -> Int,
) -> Unit {
  // Placeholder implementation - actual qsort logic needs to be implemented
  // for wasm-gc backend
  abort("qsort not implemented for wasm-gc")
}

///|
fn init {
  println("Hello, world!")
}
