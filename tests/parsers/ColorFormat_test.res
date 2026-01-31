open Vitest
open ColorFormat

@scope("console") @val external log: string => unit = "log"

describe("RGB(A) format detection", () => {
  test("detect standard RGB", () => {
    switch getColorFormat("rgb(255, 255, 255)") {
    | Some(RGBA) => ()
    | _ => throw(Failure("Expected #ffffff to be HEX"))
    }
  })
  test("detect standard RGBA", () => {
    switch getColorFormat("rgba(255, 255, 255, 1)") {
    | Some(RGBA) => ()
    | _ => throw(Failure("Expected #ffffff to be HEX"))
    }
  })
})

describe("HEX format detection", () => {
  test("detect standard HEX 6 chars", () => {
    switch getColorFormat("#ffffff") {
    | Some(HEX) => ()
    | _ => throw(Failure("Expected #ffffff to be HEX"))
    }
  })

  test("detect standard HEX 3 chars", () => {
    switch getColorFormat("#fff") {
    | Some(HEX) => ()
    | _ => throw(Failure("Expected #fff to be HEX"))
    }
  })

  test("detect HEX with alpha 4 and 8 chars", () => {
    switch getColorFormat("#f0f8") {
    | Some(HEX) => ()
    | _ => throw(Failure("Expected #f0f8 to be HEX"))
    }
  })

  test("detect full HEX with alpha", () => {
    switch getColorFormat("#12345678") {
    | Some(HEX) => ()
    | _ => throw(Failure("Expected #12345678 to be HEX"))
    }
  })

  test("detect invalid HEX", () => {
    switch getColorFormat("ffffff") {
    | None => ()
    | _ => throw(Failure("Expected ffffff to be None"))
    }
  })
})
