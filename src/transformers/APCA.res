// https://raw.githubusercontent.com/Myndex/apca-w3/master/images/APCAw3_0.1.17_APCA0.0.98G.svg

let rScale = 1.14
let wOffset = 0.027
let bExp = 1.414
let bThresh = 0.022
let pIn = 0.0005
let pOut = 0.1

// y = relative luminance
let getFlattenedBackground = rgbaObj => rgbaObj->Helpers.getFlatNrgb

let getFlattenedText = (rgbaObj, bgRgbOgj) =>
  rgbaObj->Helpers.getFlatNrgb(~backgroundColorObj=bgRgbOgj)

let getYbg = (rgbaObj, ~mode=RGB.Precision) =>
  rgbaObj->getFlattenedBackground->Helpers.getRelativeLuminance(~mode)

let getYtxt = (rgbaObj, bgRgbObj, ~mode=RGB.Precision) =>
  rgbaObj->getFlattenedText(bgRgbObj)->Helpers.getRelativeLuminance(~mode)

// soft clamp black levels
let getClampY = yc => {
  if yc >= bThresh {
    yc
  } else {
    yc + (bThresh -. yc) ** bExp
  }
}
