open Vitest
open WcagColorContrast

@scope("console") @val external log: string => unit = "log"

describe("HEX to RGBA", () => {
  test("detect white HEX 6 chars", () => {
    switch toRgba("#ffffff") {
    | Some({r: 255, g: 255, b: 255, a: 1.0}) => ()
    | _ => throw(Failure("Expected #ffffff to be HEX"))
    }
  })
  test("detect black HEX 6 chars", () => {
    switch toRgba("#000000") {
    | Some({r: 0, g: 0, b: 0, a: 1.0}) => ()
    | _ => throw(Failure("Expected #ffffff to be HEX"))
    }
  })
})

describe("Color ratio", () => {
  test("Black and white", () => {
    let black = "#000000"
    let white = "#ffffff"

    let contrastRatio = getContrastRatio(black, white)

    switch contrastRatio {
    | contrastRatio if Math.abs(contrastRatio -. 21.0) < 0.01 => ()
    | _ => throw(Failure("Expected 21.0 contrast ratio, got " ++ Float.toString(contrastRatio)))
    }
  })

  test("Blue and white", () => {
    let black = "#0000ff"
    let white = "#ffffff"

    let contrastRatio = getContrastRatio(black, white)

    switch contrastRatio {
    | contrastRatio if Math.abs(contrastRatio -. 8.59) < 0.01 => ()
    | _ => throw(Failure("Expected 8.59 contrast ratio, got " ++ Float.toString(contrastRatio)))
    }
  })
})
