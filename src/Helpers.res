let getFlatNrgb = (rgbaObj, ~backgroundColorObj=?) => {
  rgbaObj->RGB.rgbaToNormalized->RGB.flattenAlpha(~backgroundColorObj?)
}

let getRelativeLuminance = (flatNrgb, ~mode=?) => {
  flatNrgb->RGB.toLinearRGB(~mode?)->RGB.relativeLuminance
}
