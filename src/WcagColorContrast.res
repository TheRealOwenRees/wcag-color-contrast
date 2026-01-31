// Entrypoint

// get the type of color it is eg HEX, RGB, HSV, HSL
let format = string => ColorFormat.getColorFormat(string)

// get the values from inside the color string
let values = (string, format) => ColorValues.extract(string, format)

let rgba = s => {
  switch format(s) {
  | None => None
  | Some(fmt) =>
    switch values(s, Some(fmt)) {
    | None => None
    | Some({format: HEX, value: HEX(hex)}) => HexToRgb.hexToRgb(hex)
    | Some({format: Types.RGBA, value: RGBA({r, g, b, a})}) => Some({r, g, b, a})
    }
  }
}

// check 2 colours and compare for luminance figure

// check against font size to see if compliant
