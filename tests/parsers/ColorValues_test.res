open Vitest
open ColorValues

@scope("console") @val external log: string => unit = "log"

describe("RGB", () => {
  test("detect standard RGB", () => {
    let result = extract("rgb(255, 255, 255)", Some(RGBA))

    switch result {
    | Some({format: RGBA, value: RGBA({r: 255, g: 255, b: 255, a: 1.0})}) => ()
    | _ => throw(Failure("Expected Some({format: RGB, value: \"ffffff\"}"))
    }
  })
})

describe("HEX", () => {
  test("detect standard HEX 6 chars", () => {
    let result = extract("#ffffff", Some(HEX))

    switch result {
    | Some({format: HEX, value: HEX("ffffff")}) => ()
    | _ => throw(Failure("Expected Some({format: HEX, value: \"ffffff\"}"))
    }
  })
})
