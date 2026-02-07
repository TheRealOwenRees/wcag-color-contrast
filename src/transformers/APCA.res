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

// camp noise and then scale
let clampNoise = (ybg, ytxt, s) => {
  if Math.abs(ybg -. ytxt) <= pIn {
    0.0
  } else {
    s *. rScale
  }
}

let getSapc = c => {
  if Math.abs(c) < pOut {
    0.0
  } else if c > 0.0 {
    c -. wOffset
  } else {
    c +. wOffset
  }
}

let getWcag3Level = (~lc: float, ~threshold: float): Types.wcag3Conformance => {
  let absLc = Math.abs(lc)
  {
    bronze: absLc >= threshold,
    silver: absLc >= threshold +. 15.0,
    gold: absLc >= threshold +. 30.0,
  }
}

let evaluateContrast = (~lc: float, ~fontSize: int, ~fontWeight: int): Types.wcag3Result => {
  let absLc = Math.abs(lc)

  // TODO qualified font contrast

  if (
    absLc >= 90.0 &&
      ((fontSize >= 18 && fontWeight >= 300) || (fontSize >= 14 && fontWeight >= 400))
  ) {
    {lc, levels: getWcag3Level(~lc, ~threshold=90.0), category: "Preferred Body Text"}
  } else if (
    absLc >= 75.0 &&
      ((fontSize >= 18 && fontWeight >= 400) || (fontSize >= 14 && fontWeight >= 700))
  ) {
    {lc, levels: getWcag3Level(~lc, ~threshold=75.0), category: "Minimum Body Text"}
  } else if absLc >= 60.0 && fontSize >= 24 {
    {lc, levels: getWcag3Level(~lc, ~threshold=60.0), category: "Content Text"}
  } else if absLc >= 45.0 && (fontSize >= 36 || (fontSize >= 24 && fontWeight >= 700)) {
    {lc, levels: getWcag3Level(~lc, ~threshold=45.0), category: "Large / Headline Text"}
  } else if absLc >= 30.0 {
    {lc, levels: getWcag3Level(~lc, ~threshold=30.0), category: "Spot / Non-Content Text"}
  } else {
    {lc, levels: {bronze: false, silver: false, gold: false}, category: "Fail"}
  }
}
