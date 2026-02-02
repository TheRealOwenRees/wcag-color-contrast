# WCAG Color Constrast

## A zero dependency library to check for WCAG compliant color contrasts.

## Usage

### Installation

```sh
npm install wcag-color-contrast
# or
pnpm add wcag-color-contrast
```

### Basic example

```js
import * as WCAG from "wcag-color-contrast";

// Get the raw contrast ratio
const ratio = WCAG.getContrastRatio("#ffffff", "#000000");
console.log(ratio); // 21.0

// Check compliance for normal text
const report = WCAG.isCompliant(ratio);
console.log(report);
/*
 { "WCAG 2.x": 
    {
        "AA": true,
        "AAA": true
    }
}
*/
```

### Advanced Usage

```js
// isCompliant(ratio, fontSize, bold)
const results = WCAG.isCompliant(3.5, 18, true);

/*
 { "WCAG 2.x": 
    {
        "AA": true,
        "AAA": true
    }
}
*/
```

### Utility functions

```js
WCAG.toRgba("#f00"); // "rgba(255, 0, 0, 1)"
WCAG.toRgba("#00000080"); // "rgba(0, 0, 0, 0.5)"
```

## API Reference

| Function           | Parameters                       | Returns | Description                                   |
| ------------------ | -------------------------------- | ------- | --------------------------------------------- |
| `getContrastRatio` | (color1: string, color2: string) | number  | Calculates ratio between 1.0 and 21.0         |
| `isCompliant`      | (ratio: number, isLarge?: bool)  | object  | Returns { WCAG 2.x: { AAA: bool, AA: bool } } |
| `toRgba`           | (hex: string)                    | string  | Converts hex to rgba() format.                |

## Development Installation

```sh
pnpm install
```

## Build

It is recommended to use the build and test on change scripts in two separate terminal windows.

- Build on change: `npm run res:dev`
- Test on change: `npm run test:watch`
- Build: `npm run res:build`

## Smoke Test
