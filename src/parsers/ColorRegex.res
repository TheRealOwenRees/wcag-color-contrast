let hex = RegExp.fromString("^#(?:[0-9a-fA-F]{3}|[0-9a-fA-F]{4}|[0-9a-fA-F]{6}|[0-9a-fA-F]{8})$")

let rgba = // rgb(255, 255, 255) or rgba(255,255,255,0.5)
RegExp.fromString(
  "^rgba?\\(\\s*\\d{1,3}\\s*,\\s*\\d{1,3}\\s*,\\s*\\d{1,3}(?:\\s*,\\s*(?:\\d*\\.?\\d+|\\.?\\d+))?\\s*\\)$",
  ~flags="i",
)
