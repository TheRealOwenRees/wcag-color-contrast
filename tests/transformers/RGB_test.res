open Vitest
open RGB

@scope("console") @val external log: string => unit = "log"

let isClose = (a, b) => Math.abs(a -. b) < 0.00001

describe("Normalzed RGBA", () => {
  test("Black", () => {
    switch rgbaToNormalized(Some({r: 255, g: 255, b: 255, a: 1.0})) {
    | Some({r: 1.0, g: 1.0, b: 1.0, a: 1.0}) => ()
    | _ => throw(Failure("Expected #ffffff to be HEX"))
    }
  })
  test("White", () => {
    switch rgbaToNormalized(Some({r: 0, g: 0, b: 0, a: 1.0})) {
    | Some({r: 0.0, g: 0.0, b: 0.0, a: 1.0}) => ()
    | _ => throw(Failure("Expected #ffffff to be HEX"))
    }
  })
})

describe("Flattened Alpha", () => {
  test("Black", () => {
    switch flattenAlpha(Some({r: 1.0, g: 1.0, b: 1.0, a: 1.0})) {
    | Some({r: 1.0, g: 1.0, b: 1.0}) => ()
    | _ => throw(Failure("Expected #ffffff to be HEX"))
    }
  })
  test("Black half alpha", () => {
    switch flattenAlpha(Some({r: 1.0, g: 1.0, b: 1.0, a: 0.5})) {
    | Some({r: 1.0, g: 1.0, b: 1.0}) => ()
    | _ => throw(Failure("Expected #ffffff to be HEX"))
    }
  })
  test("Black with green background reduced alpha", () => {
    switch flattenAlpha(
      Some({r: 1.0, g: 1.0, b: 1.0, a: 0.8}),
      ~backgroundColor=?Some({r: 0.0, g: 1.0, b: 0.0}),
    ) {
    | Some({r: 0.8, g: 1.0, b: 0.8}) => ()
    | _ => throw(Failure("Expected #ffffff to be HEX"))
    }
  })
})

describe("Luminance", () => {
  test("Green", () => {
    let result = relativeLuminance(Some({r: 0.6038, g: 1.0, b: 0.6038}))

    switch result {
    | result if Math.abs(result -. 0.8872) < 0.0001 => ()
    | _ => throw(Failure("Expected #ffffff to be HEX"))
    }
  })
})
