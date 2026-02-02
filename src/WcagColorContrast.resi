type isCompliantObj = {"WCAG 2.x": {"AAA": bool, "AA": bool}}

let toRgba: string => option<Types.rgbaObj>
let getContrastRatio: (string, string) => float
let isCompliant: (float, int, bool) => isCompliantObj
