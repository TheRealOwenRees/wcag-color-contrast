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
        value: String.slice(~start=1, s),
      })
    } else {
      None
    }
  | Some(RGB) => None
  | Some(HSL) => None
  | Some(HSV) => None
  }
}
