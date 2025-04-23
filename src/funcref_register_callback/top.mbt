///|
#borrow(call, closure)
extern "c" fn ffi_register_callback(
  call : FuncRef[(() -> Unit) -> Unit],
  closure : () -> Unit
) = "register_callback"

///|
fn register_callback(closure : () -> Unit) -> Unit {
  ffi_register_callback(
    fn(f) { f() }, // moonc know how to consume `closure`
    closure,
  )
}

///|
fn main {
  let s1 = "moonbit"
  register_callback(fn() {
    println(s1) // capture free variables
  })
  println("done")
}
