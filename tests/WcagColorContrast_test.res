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

describe("APCA Lightness Contrast", () => {
  let isClose = (a, b) => Math.abs(a -. b) < 1.

  test("White bg / Black text", () => {
    let white = "#ffffff"
    let black = "#000000"
    let result = getAPCA(white, black)

    switch result {
    | result if isClose(result, 106.) => ()
    | _ => throw(Failure("Expected 106.0 contrast ratio, got " ++ Float.toString(result)))
    }
  })

  test("Black bg / White text", () => {
    let white = "#ffffff"
    let black = "#000000"
    let result = getAPCA(black, white)

    switch result {
    | result if isClose(result, -107.) => ()
    | _ => throw(Failure("Expected -107.0 contrast ratio, got " ++ Float.toString(result)))
    }
  })

  test("White bg / Blue text", () => {
    let white = "#ffffff"
    let blue = "#0000ff"
    let result = getAPCA(white, blue)

    switch result {
    | result if isClose(result, 85.8) => ()
    | _ => throw(Failure("Expected 85.8 contrast ratio, got " ++ Float.toString(result)))
    }
  })
})
