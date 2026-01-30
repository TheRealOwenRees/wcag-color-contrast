open Vitest
open WcagColorContrast

@scope("console") @val external log: string => unit = "log"

describe("Colour format", () => {
  test("detect standard HEX 6 chars", () => {
    switch format("#ffffff") {
    | Some(HEX) => ()
    | _ => throw(Failure("Expected #ffffff to be HEX"))
    }
  })
})