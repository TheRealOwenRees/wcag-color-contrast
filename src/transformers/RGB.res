let rgbaToNormalized = (rgba: option<Types.rgbaObj>): option<Types.normalizedRgbaObj> => {
  let rgbaObj = rgba->Option.getOr({r: 0, g: 0, b: 0, a: 1.0})

  Some({
    r: Int.toFloat(rgbaObj.r) /. 255.0,
    g: Int.toFloat(rgbaObj.g) /. 255.0,
    b: Int.toFloat(rgbaObj.b) /. 255.0,
    a: rgbaObj.a,
  })
}

// Flatten alpha against background color (already alpha flattened)
let flattenAlpha = (
  rgba: option<Types.normalizedRgbaObj>,
  ~backgroundColor: option<Types.normalizedRgbObj>=?,
): option<Types.normalizedRgbObj> => {
  let rgbaObj = rgba->Option.getOr({r: 0.0, g: 0.0, b: 0.0, a: 1.0})
  let backgroundColorObj = backgroundColor->Option.getOr({r: 1.0, g: 1.0, b: 1.0})

  Some({
    r: rgbaObj.r *. rgbaObj.a +. backgroundColorObj.r *. (1.0 - rgbaObj.a),
    g: rgbaObj.g *. rgbaObj.a +. backgroundColorObj.g *. (1.0 - rgbaObj.a),
    b: rgbaObj.b *. rgbaObj.a +. backgroundColorObj.b *. (1.0 - rgbaObj.a),
  })
}

// flattened alpha normalized RGB to linear lRGB
let toLinearRGB = (rgb: option<Types.normalizedRgbObj>): option<Types.normalizedRgbObj> => {
  let calculateLinearPart = (c: float) => {
    if c <= 0.04045 {
      c /. 12.92
    } else {
      ((c + 0.055) /. 1.055) ** 2.4
    }
  }

  let rgbObj = rgb->Option.getOr({r: 0.0, g: 0.0, b: 0.0})

  Some({
    r: calculateLinearPart(rgbObj.r),
    g: calculateLinearPart(rgbObj.g),
    b: calculateLinearPart(rgbObj.b),
  })
}

// lRGB to relative luminance
let relativeLuminance = (rgb: option<Types.normalizedRgbObj>) => {
  let rgbObj = rgb->Option.getOr({r: 1.0, g: 1.0, b: 1.0})

  let rWeight = 0.2126729
  let gWeight = 0.7151522
  let bWeight = 0.0721750

  let r = rWeight * rgbObj.r
  let g = gWeight * rgbObj.g
  let b = bWeight * rgbObj.b

  r + g + b
}
