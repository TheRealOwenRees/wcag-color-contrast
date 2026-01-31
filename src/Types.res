type colorFormat =
  | RGBA
  | HEX
  | HSL
  | HSV

type rgbaObj = {
  r: int,
  g: int,
  b: int,
  a: float,
}

type colorValue =
  | HEX(string)
  | RGBA(rgbaObj)

type colorValueObj = {
  format: colorFormat,
  value: colorValue,
}
