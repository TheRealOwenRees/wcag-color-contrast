type colorFormat =
  | RGBA
  | HEX

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

type wcag3Conformance = {
  bronze: bool,
  silver: bool,
  gold: bool,
}

type wcag3Result = {
  lc: float,
  levels: wcag3Conformance,
  category: string,
}

type isCompliantObj = {"WCAG 2.x": {"AAA": bool, "AA": bool}}
