type isCompliantObj = {"WCAG 2.x": {"AAA": bool, "AA": bool}}

let toRgba: string => option<Types.rgbaObj>
let getContrastRatio: (string, string) => float
let getAPCA: (string, string) => float
let isCompliant: (~ratio: float, ~fontSize: int=?, ~bold: bool=?) => isCompliantObj
