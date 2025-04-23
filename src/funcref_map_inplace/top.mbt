///|
struct Point {
  x : Int
  y : Int
} derive(Show, Eq, Compare, @quickcheck.Arbitrary)

///|
#borrow(xs, call, closure)
extern "c" fn ffi_map_inplace(
  xs : FixedArray[Point],
  call : FuncRef[((Point) -> Point, Point) -> Point],
  closure : (Point) -> Point
) = "ffi_map_inplace"

///|
fn map_inplace(xs : FixedArray[Point], closure : (Point) -> Point) -> Unit {
  ffi_map_inplace(xs, fn(f, x) { f(x) }, closure)
}

///|
fn main {
  let xs : FixedArray[Point] = @quickcheck.samples(4) |> FixedArray::from_array
  let mut i = 0
  fn f(x) {
    println(i)
    i += 1
    x
  }
  map_inplace(xs, f)
  println(xs)
  map_inplace(xs, f)
  println(xs)
  map_inplace(xs, f)
  println(xs)
}
