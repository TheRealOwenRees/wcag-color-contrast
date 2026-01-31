open Vitest
open ColorValues

@scope("console") @val external log: string => unit = "log"

describe("HEX", () => {
  test("detect standard HEX 6 chars", () => {
    let result = extract("#ffffff", Some(HEX))

    switch result {
    | Some({format: HEX, value: "ffffff"}) => ()
    | _ => throw(Failure("Expected Some({format: HEX, value: \"ffffff\"}"))
    }
  })
})
