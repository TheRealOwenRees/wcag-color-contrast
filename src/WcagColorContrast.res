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

// RGB values normalized on 0-1 scale
let normalizedRgba = s => RGB.rgbaToNormalized(rgba(s))

// flatten alpha
let flattenedRgb = s => RGB.flattenAlpha(normalizedRgba(s))

// linearize to lRGB
let linearRGB = s => RGB.toLinearRGB(flattenedRgb(s))

// calculate luminance

// check 2 colours and compare for luminance figure

// check against font size to see if compliant
