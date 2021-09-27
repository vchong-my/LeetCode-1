# Maximum Number of Events That Can Be Attended II
import algorithm

func solution(events: ptr UncheckedArray[ptr UncheckedArray[cint]], eventSize: int, k: int): int {.exportc.} =
  type E = tuple[start,stop,value: int]
  var
    a = newSeq[E](eventSize)
    dp0: seq[int] = newSeq[int](eventSize+1)
    dp1: seq[int] = newSeq[int](eventSize+1)
  for i in 0..<eventSize:
    a[i] = (cast[int](events[i][0]), cast[int](events[i][1]), cast[int](events[i][2]))
  a.sort(proc (x, y: E): int = x.stop - y.stop)
  for _ in 0..<k:
    for i in 0..<eventSize:
      let j = a.lowerBound(a[i].start, proc (x: E, y: int): int = x.stop - y)
      dp1[i+1] = max(dp1[i], dp0[j]+a[i].value)
    swap(dp0, dp1)
  result = dp0[eventSize]

{.emit: """
int maxValue(int** events, int eventsSize, int* eventsColSize, int k) {
  return solution(events, eventsSize, k);
}
""".}
