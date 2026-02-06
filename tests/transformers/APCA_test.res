open Vitest
open APCA

@scope("console") @val external log: string => unit = "log"

describe("Y - Relative Luminance", () => {
  test("Black", () => {
    let result = "#000000"->WcagColorContrast.toRgba->getYbg
    switch result {
    | result if Math.abs(result -. 0.) < 0.0001 => ()
    | _ => throw(Failure("Expected black to be " ++ Float.toString(result)))
    }
  })

  test("White", () => {
    let result = "#ffffff"->WcagColorContrast.toRgba->getYbg
    switch result {
    | result if Math.abs(result -. 1.) < 0.0001 => ()
    | _ => throw(Failure("Expected white to be " ++ Float.toString(result)))
    }
  })
})

describe("Soft clamp Y black levels", () => {
  test("Below threshold", () => {
    let result = getClampY(0.0211)
    switch result {
    | result if Math.abs(result -. 0.0211) < 0.01 => ()
    | _ => throw(Failure("Expected " ++ Float.toString(result)))
    }
  })

  test("Over threshold", () => {
    switch getClampY(0.0231) {
    | 0.0231 => ()
    | _ => throw(Failure("Expected 0.0231"))
    }
  })
})
