// Entrypoint
type isCompliantObj = {"AAA": bool, "AA": bool}

// get the type of color it is eg HEX, RGB, HSV, HSL
let format = string => ColorFormat.getColorFormat(string)

// get the values from inside the color string
let values = (string, format) => ColorValues.extract(string, format)

// return an rgba color object for passed in colour data
let toRgba = s => {
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

// check 2 colours and compare for luminance figure
let getContrastRatio = (l1, l2) => {
  let max = Math.max(l1, l2) +. 0.05
  let min = Math.min(l1, l2) +. 0.05
  max /. min
}

// return an object of bools showing AAA and AA compliance
let isCompliant = (ratio, fontSize, bold) => {
  let largeText = fontSize >= 24 || (fontSize >= 18 && bold)

  let aaa = ratio >= 7.0 || (ratio >= 4.5 && largeText)
  let aa = ratio >= 4.5 || (ratio >= 3.0 && largeText)

  {"AAA": aaa, "AA": aa}
}
