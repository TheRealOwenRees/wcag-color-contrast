let extract = (colorString: string, format: option<Types.colorFormat>): option<Types.colorValue> => {
  let s = colorString->String.trim

  switch format {
  | Some(HEX) => {
    if String.length(s) >= 4 && String.startsWith("#", s) {
      let hex = String.slice(~start=1, s)
      Some(HEX(hex))
  } else {
    None
  }
  }
  }
}