let toRgba: string => option<Types.rgbaObj>
let getContrastRatio: (string, string) => float
let getLc: (string, string) => float
let isCompliant: (
  ~ratio: float,
  ~fontSize: int=?,
  ~isBold: bool=?,
  ~fontWeight: int=?,
) => Types.isCompliantObj
