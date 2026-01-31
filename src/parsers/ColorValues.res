let extract = (colorString: string, format: option<Types.colorFormat>): option<
  Types.colorValueObj,
> => {
  let s = colorString->String.trim

  switch format {
  | Some(HEX) =>
    if String.length(s) >= 4 && String.startsWith(s, "#") {
      let hexObj: Types.colorValueObj = {
        format: HEX,
        value: String.slice(~start=1, s),
      }
      Some(hexObj)
    } else {
      None
    }
  | Some(RGB) => None
  | Some(HSL) => None
  | Some(HSV) => None
  | None => None
  }
}
