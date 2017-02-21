// See noahgilmore.com/blog/2016/11/nsobject-equatable.html

import Foundation

class A: NSObject {
  let x: Int

  init(x: Int) {
    self.x = x
  }
}

func ==(left: A, right: A) -> Bool {
  return left.x == right.x
}

print(A(x: 1) == A(x: 1))       // prints "true"
print([A(x: 1)] == [A(x: 1)])   // prints "false" ??

/////////////////////////////////////////////////////////////////////////

class B: NSObject {
  let x: Int

  init(x: Int) {
    self.x = x
  }

  override func isEqual(_ object: Any?) -> Bool {
    print("isEqual for B")
    return super.isEqual(object)
  }
}

func ==(left: B, right: B) -> Bool {
  print("== for B")
  return left.x == right.x
}

print(B(x: 1) == B(x: 1))       // prints "== for B", "true"
print([B(x: 1)] == [B(x: 1)])   // prints "isEqual for B", "false"

/////////////////////////////////////////////////////////////////////////

class C: NSObject {
  let x: Int

  init(x: Int) {
    self.x = x
  }

  override func isEqual(_ object: Any?) -> Bool {
    guard let object = object as? C else { return false }
    return object == self
  }
}

func ==(left: C, right: C) -> Bool {
  print("== for C")
  return left.x == right.x
}

print(C(x: 1) == C(x: 1))       // prints "== for C", "true"
print([C(x: 1)] == [C(x: 1)])   // prints "== for C", "true"
