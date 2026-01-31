let extract = (colorString: string, format: option<Types.colorFormat>): option<
  Types.colorValueObj,
> => {
  let s = colorString->String.trim

  switch format {
  | None => None
  | Some(HEX) =>
    if String.length(s) >= 4 && String.startsWith(s, "#") {
      Some({
        format: HEX,
        value: HEX(String.slice(~start=1, s)),
      })
    } else {
      None
    }
  | Some(RGBA) => {
      let matches = s->String.match(/\d+(\.\d+)?/g)->Option.getOr([])

      let r = matches[0]->Option.flatMap(b => Int.fromString(b->Option.getOr("0")))->Option.getOr(0)
      let g = matches[1]->Option.flatMap(b => Int.fromString(b->Option.getOr("0")))->Option.getOr(0)
      let b = matches[2]->Option.flatMap(b => Int.fromString(b->Option.getOr("0")))->Option.getOr(0)
      let a =
        matches[3]->Option.flatMap(b => Float.fromString(b->Option.getOr("0")))->Option.getOr(1.0)

      Some({
        format: RGBA,
        value: RGBA({r, g, b, a}),
      })
    }
  // | Some(HSL) => None
  // | Some(HSV) => None
  }
}
