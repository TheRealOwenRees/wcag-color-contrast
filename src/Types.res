type colorFormat =
  | RGBA // sRGBA
  | HEX
// | HSL
// | HSV

type rgbaObj = {
  r: int,
  g: int,
  b: int,
  a: float,
}

type normalizedRgbaObj = {
  r: float,
  g: float,
  b: float,
  a: float,
}

type normalizedRgbObj = {
  r: float,
  g: float,
  b: float,
}

type colorValue =
  | HEX(string)
  | RGBA(rgbaObj)

type colorValueObj = {
  format: colorFormat,
  value: colorValue,
}
