let getColorFormat = (colorString: string): option<WcagColorContrast.colorFormat> => {
  let s = colorString->String.trim

  // change to switch
  if RegExp.test(ColorRegex.hex, s) {
    Some(WcagColorContrast.HEX)
  } else {
    None
  }
}
