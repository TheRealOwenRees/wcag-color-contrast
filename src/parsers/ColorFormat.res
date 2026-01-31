let getColorFormat = (colorString: string): option<Types.colorFormat> => {
  let s = colorString->String.trim

  if RegExp.test(ColorRegex.hex, s) {
    Some(Types.HEX)
  } else if RegExp.test(ColorRegex.rgba, s) {
    Some(Types.RGBA)
  } else {
    None
  }
}
