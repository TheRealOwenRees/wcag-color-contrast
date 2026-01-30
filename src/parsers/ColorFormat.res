let getColorFormat = (colorString: string): option<Types.colorFormat> => {
  let s = colorString->String.trim

  // change to switch
  if RegExp.test(ColorRegex.hex, s) {
    Some(Types.HEX)
  } else {
    None
  }
}
