open Vitest
open WcagColorContrast

@scope("console") @val external log: string => unit = "log"

describe("HEX to RGBA", () => {
  test("detect white HEX 6 chars", () => {
    switch rgb("#ffffff") {
    | Some({r: 255, g: 255, b: 255, a: 1.0}) => ()
    | _ => throw(Failure("Expected #ffffff to be HEX"))
    }
  })
  test("detect black HEX 6 chars", () => {
    switch rgb("#000000") {
    | Some({r: 0, g: 0, b: 0, a: 1.0}) => ()
    | _ => throw(Failure("Expected #ffffff to be HEX"))
    }
  })
})
