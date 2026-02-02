type isCompliantObj = {"AAA": bool, "AA": bool}

let toRgba: string => option<Types.rgbaObj>
let getContrastRatio: (string, string) => float
let isCompliant: (float, int, bool) => isCompliantObj
