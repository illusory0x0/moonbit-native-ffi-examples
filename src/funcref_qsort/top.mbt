///|
struct Point {
  x : Int
  y : Int
} derive(@quickcheck.Arbitrary, Compare, Eq, Show)

///|
#borrow(xs, comp)
extern "c" fn qsort(
  xs : FixedArray[Point],
  comp : FuncRef[(Point, Point) -> Int]
) = "ffi_qsort"

///|
fn main {
  try {
    let xs : FixedArray[Point] = @quickcheck.samples(10)
      |> FixedArray::from_array
    let ys = xs.copy()
    let comp : FuncRef[(Point, Point) -> Int] = fn(x, y) { x.compare(y) }
    inspect!(
      xs,
      content="[{x: 0, y: 0}, {x: 0, y: 0}, {x: 0, y: -1}, {x: 2, y: 0}, {x: -2, y: 2}, {x: 0, y: 2}, {x: -5, y: -2}, {x: 2, y: 3}, {x: 3, y: 7}, {x: 1, y: 0}]",
    )
    inspect!(
      ys,
      content="[{x: 0, y: 0}, {x: 0, y: 0}, {x: 0, y: -1}, {x: 2, y: 0}, {x: -2, y: 2}, {x: 0, y: 2}, {x: -5, y: -2}, {x: 2, y: 3}, {x: 3, y: 7}, {x: 1, y: 0}]",
    )
    xs |> qsort(comp)
    ys.sort()
    inspect!(
      xs,
      content="[{x: -5, y: -2}, {x: -2, y: 2}, {x: 0, y: -1}, {x: 0, y: 0}, {x: 0, y: 0}, {x: 0, y: 2}, {x: 1, y: 0}, {x: 2, y: 0}, {x: 2, y: 3}, {x: 3, y: 7}]",
    )
    inspect!(
      ys,
      content="[{x: -5, y: -2}, {x: -2, y: 2}, {x: 0, y: -1}, {x: 0, y: 0}, {x: 0, y: 0}, {x: 0, y: 2}, {x: 1, y: 0}, {x: 2, y: 0}, {x: 2, y: 3}, {x: 3, y: 7}]",
    )
    assert_eq!(xs, ys)
    println("done")
  } catch {
    e => println(e)
  }
}
