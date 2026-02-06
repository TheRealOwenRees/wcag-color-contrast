// https://raw.githubusercontent.com/Myndex/apca-w3/master/images/APCAw3_0.1.17_APCA0.0.98G.svg

let rScale = 1.14
let wOffset = 0.027
let bExp = 1.414
let bThresh = 0.022
let pIn = 0.0005
let pOut = 0.1

// soft clamp black levels
let clampY = yc => {
  if yc >= bThresh {
    yc
  } else {
    yc + (bThresh -. yc) ** bExp
  }
}

// y = relative luminance
let getFlattenedBackground = rgbaObj => rgbaObj->Helpers.getFlatNrgb

let getFlattenedText = (rgbaObj, bgRgbOgj) =>
  rgbaObj->Helpers.getFlatNrgb(~backgroundColorObj=bgRgbOgj)

let getYbg = (rgbaObj, ~mode=RGB.Precision) =>
  rgbaObj->getFlattenedBackground->Helpers.getRelativeLuminance(~mode)

let getYtxt = (rgbaObj, bgRgbObj, ~mode=RGB.Precision) =>
  rgbaObj->getFlattenedText(bgRgbObj)->Helpers.getRelativeLuminance(~mode)

// sNorm / sRev
let getPerceptualLightnessDifference = (ybg, ytxt) => {
  if ybg > ytxt {
    ybg ** 0.56 -. ytxt ** 0.57
  } else {
    ybg ** 0.65 -. ytxt ** 0.62
  }
}
