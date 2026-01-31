// Entrypoint

// get the type of color it is eg HEX, RGB, HSV, HSL
let format = string => ColorFormat.getColorFormat(string)

// get the values from inside the color string
let values = (string, format) => ColorValues.extract(string, format)

// return an rgba color object for passed in colour data
let rgba = s => {
  switch format(s) {
  | None => None
  | Some(fmt) =>
    switch values(s, Some(fmt)) {
    | Some({format: HEX, value: HEX(hex)}) => HexToRgb.hexToRgb(hex)
    | Some({format: Types.RGBA, value: RGBA({r, g, b, a})}) => Some({r, g, b, a})
    | None => None
    | _ => None
    }
  }
}

let backgroundColorFlattenedAlpha = s => {
  s
  ->rgba
  ->RGB.rgbaToNormalized
  ->RGB.flattenAlpha
}

let backgroundColor = flattenedAlpha => flattenedAlpha->RGB.toLinearRGB

let foregroundColor = (s, bgObj: option<Types.normalizedRgbObj>) => {
  s
  ->RGB.rgbaToNormalized
  ->RGB.flattenAlpha(~backgroundColor=?bgObj)
  ->RGB.toLinearRGB
}

// calculate luminance
let result = (s1, s2) => {
  let bgFlatAlpha = backgroundColorFlattenedAlpha(s1)
  let bgLinearRGB = backgroundColor(bgFlatAlpha)
  let fgLinearRGB = foregroundColor(s2, bgFlatAlpha)

  let bgRelativeLuminance = RGB.relativeLuminance(bgLinearRGB)
  let fgRelativeLuminance = RGB.relativeLuminance(fgLinearRGB)
  (bgRelativeLuminance, fgRelativeLuminance)
}

Console.log(result)

// check 2 colours and compare for luminance figure

// check against font size to see if compliant
