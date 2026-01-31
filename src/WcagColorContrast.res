// Entrypoint

// get the type of color it is eg HEX, RGB, HSV, HSL
let format = (string: string): option<Types.colorFormat> => {
  ColorFormat.getColorFormat(string)
}

// get the values from inside the color string
let values = (string: string, format: option<Types.colorFormat>): option<Types.colorValueObj> => {
  ColorValues.extract(string, format)
}

// get the RGB equivalent -> convert to RGBA

// check 2 colours and compare for luminance figure

// check against font size to see if compliant
