// Entrypoint
type isCompliantObj = {"WCAG 2.x": {"AAA": bool, "AA": bool}}

// return an rgba color object for passed in colour data
let toRgba = s => {
  let format = string => ColorFormat.getColorFormat(string)
  let values = (string, format) => ColorValues.extract(string, format)

  switch format(s) {
  | None => None
  | Some(fmt) =>
    switch values(s, Some(fmt)) {
    | Some({format: HEX, value: HEX(hex)}) => HexToRgb.hexToRgb(hex)
    | Some({format: RGBA, value: RGBA({r, g, b, a})}) => Some({r, g, b, a})
    | None => None
    | _ => None
    }
  }
}

// check 2 colours and compare for luminance figure
let getContrastRatio = (background, foreground) => {
  let bgFlattened = background->toRgba->Helpers.getFlatNrgb
  let fgFlattened = foreground->toRgba->Helpers.getFlatNrgb(~backgroundColorObj=bgFlattened)

  let l1 = Helpers.getRelativeLuminance(bgFlattened)
  let l2 = Helpers.getRelativeLuminance(fgFlattened)

  let max = Math.max(l1, l2) +. 0.05
  let min = Math.min(l1, l2) +. 0.05
  max /. min
}

let getAPCA = (background, foreground) => {
  let bgRgbaObj = background->toRgba
  let fgRgbaObj = foreground->toRgba

  let ybg = APCA.getYbg(bgRgbaObj)->APCA.clampY
  let ytxt = APCA.getYtxt(fgRgbaObj, bgRgbaObj->APCA.getFlattenedBackground)->APCA.clampY

  let perceptualLightnessDifference = APCA.getPerceptualLightnessDifference(ybg, ytxt)
  perceptualLightnessDifference
}

// return an object of bools showing AAA and AA compliance
let isCompliant = (~ratio, ~fontSize=16, ~bold=false) => {
  let largeText = fontSize >= 24 || (fontSize >= 18 && bold)

  let aaa = ratio >= 7.0 || (ratio >= 4.5 && largeText)
  let aa = ratio >= 4.5 || (ratio >= 3.0 && largeText)

  {"WCAG 2.x": {"AAA": aaa, "AA": aa}}
}
