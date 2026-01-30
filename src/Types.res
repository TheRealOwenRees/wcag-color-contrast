type colorFormat =
  | RGB
  | HEX
  | HSL
  | HSV

type rgb = {r: int, g: int, b:int, a: float}

type colorValue =
  | HEX(string)
  | RGB(rgb)