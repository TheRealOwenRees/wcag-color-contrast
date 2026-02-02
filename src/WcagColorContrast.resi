type isCompliantObj = {"AAA": bool, "AA": bool}

let format: string => option<Types.colorFormat>
let values: (string, option<Types.colorFormat>) => option<Types.colorValueObj>
let toRgba: string => option<Types.rgbaObj>
let getContrastRatio: (float, float) => float
let isCompliant: (float, int, bool) => isCompliantObj
