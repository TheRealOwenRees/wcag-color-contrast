let hexToInt = (hex: string) => Int.fromString(hex, ~radix=16)

let hexToRgb = (value: string): option<Types.rgbaObj> => {
  let hex = if String.startsWith(value, "#") {
    String.slice(~start=1, value)->String.trim
  } else {
    String.trim(value)
  }

  let len = String.length(hex)

  let normalized = if len == 3 {
    // abc->aabbccff
    let r = String.get(hex, 0)->Option.getOr("0")
    let g = String.get(hex, 1)->Option.getOr("0")
    let b = String.get(hex, 2)->Option.getOr("0")
    r ++ r ++ g ++ g ++ b ++ b ++ "ff"
  } else if len == 4 {
    // abcd -> aabbccdd
    let r = String.get(hex, 0)->Option.getOr("0")
    let g = String.get(hex, 1)->Option.getOr("0")
    let b = String.get(hex, 2)->Option.getOr("0")
    let a = String.get(hex, 3)->Option.getOr("0")
    r ++ r ++ g ++ g ++ b ++ b ++ a ++ a
  } else if len == 6 {
    hex ++ "ff"
  } else {
    hex
  }

  if String.length(normalized) == 8 {
    let r = hexToInt(String.substring(~start=0, ~end=2, normalized))->Option.getOr(0)
    let g = hexToInt(String.substring(~start=2, ~end=4, normalized))->Option.getOr(0)
    let b = hexToInt(String.substring(~start=4, ~end=6, normalized))->Option.getOr(0)
    let aVal = hexToInt(String.substring(~start=6, ~end=8, normalized))->Option.getOr(1)
    let a = Int.toFloat(aVal) /. 255.0 // Normalize hex alpha to 0-1
    Some({r, g, b, a})
  } else {
    None
  }
}
