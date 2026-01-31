open Vitest
open HexToRgb

@scope("console") @val external log: string => unit = "log"

describe("Hex to Int", () => {
  test("ff", () => {
    switch hexToInt("ff") {
    | Some(255) => ()
    | _ => throw(Failure("Expected ff to be 255"))
    }
  })
  test("00", () => {
    switch hexToInt("00") {
    | Some(0) => ()
    | _ => throw(Failure("Expected ff to be 255"))
    }
  })
})

describe("HEX to RGB", () => {
  test("White", () => {
    switch hexToRgb("ffffff") {
    | Some({r: 255, g: 255, b: 255, a: 1.0}) => ()
    | _ => throw(Failure("Expected #ffffff to be HEX"))
    }
  })
})
