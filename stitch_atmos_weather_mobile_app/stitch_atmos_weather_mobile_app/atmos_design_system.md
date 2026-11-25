---
name: "Atmos Weather Design System"
description: "A clean, atmospheric Material Design 3 mobile design system built around deep navy, sky blue, and cyan for high-clarity weather forecasting."
---

## Overview

Atmos is a modern, commercial-grade Android weather application designed for effortless glanceability and calm precision. Built on a Material Design 3 foundation tailored for Flutter Material Widgets, the interface pairs a crisp, light blue-gray canvas with deep navy anchor surfaces and luminous sky-blue and cyan accents. Large geometric temperature numerals and disciplined card hierarchy ensure that current conditions, hourly/daily shifts, and location management read clearly in any lighting.

## Colors

The palette pairs a deep **Navy** primary (`#0F2942`) with **Sky Blue** (`#0EA5E9`) and **Cyan** (`#06B6D4`) accents over a cool, airy **Light Blue-Gray** surface (`#F7FAFD`) and crisp **White** content cards (`#FFFFFF`).

- **Primary (`#0F2942` / `#001428`):** Anchors navigation, primary actions, and the deep atmospheric gradient of the Current Weather Hero Card.
- **Secondary (`#006591`) & Sky Accent (`#0EA5E9`):** Highlights active navigation states, interactive search focus, and daytime weather metrics.
- **Tertiary (`#00687A`) & Cyan Accent (`#06B6D4`):** Marks precipitation probabilities, moisture metrics, and subtle atmospheric highlights.
- **Surfaces:** Cool off-white (`#F7FAFD`) ground with pure white (`#FFFFFF`) elevated cards and subtle blue-gray tonal containers (`#F1F4F7`, `#EBEEF1`).

```yaml
colors:
  sky-accent: "#0EA5E9"
  cyan-accent: "#06B6D4"
  navy-deep: "#0F2942"
  navy-mid: "#17426B"
  sky-glow: "#38BDF8"
  warning-sun: "#F59E0B"
  light:
    primary: "#0F2942"
    on-primary: "#FFFFFF"
    primary-container: "#D1E4FF"
    on-primary-container: "#001D35"
    secondary: "#006591"
    on-secondary: "#FFFFFF"
    secondary-container: "#E5F2FF"
    on-secondary-container: "#00344D"
    tertiary: "#00687A"
    on-tertiary: "#FFFFFF"
    tertiary-container: "#D8F6FF"
    on-tertiary-container: "#001F26"
    error: "#BA1A1A"
    on-error: "#FFFFFF"
    error-container: "#FFDAD6"
    on-error-container: "#410002"
    background: "#F7FAFD"
    on-background: "#181C1E"
    surface: "#F7FAFD"
    surface-dim: "#D7DADD"
    surface-bright: "#FFFFFF"
    surface-container-lowest: "#FFFFFF"
    surface-container-low: "#F1F4F7"
    surface-container: "#EBEEF1"
    surface-container-high: "#E5E8EB"
    surface-container-highest: "#E0E3E6"
    on-surface: "#181C1E"
    surface-variant: "#E0E2EA"
    on-surface-variant: "#43474D"
    outline: "#74777E"
    outline-variant: "#C3C6CE"
    inverse-surface: "#2D3133"
    inverse-on-surface: "#EEF1F4"
    inverse-primary: "#B0C9E8"
  dark:
    primary: "#B0C9E8"
    on-primary: "#19324B"
    primary-container: "#0F2942"
    on-primary-container: "#D1E4FF"
    secondary: "#89CEFF"
    on-secondary: "#00344D"
    secondary-container: "#004C6E"
    on-secondary-container: "#E5F2FF"
    tertiary: "#4CD7F6"
    on-tertiary: "#003640"
    tertiary-container: "#004E5C"
    on-tertiary-container: "#D8F6FF"
    error: "#FFB4AB"
    on-error: "#690005"
    error-container: "#93000A"
    on-error-container: "#FFDAD6"
    background: "#101416"
    on-background: "#E0E3E6"
    surface: "#101416"
    surface-dim: "#101416"
    surface-bright: "#363A3C"
    surface-container-lowest: "#0B0F11"
    surface-container-low: "#181C1E"
    surface-container: "#1C2023"
    surface-container-high: "#262B2D"
    surface-container-highest: "#313538"
    on-surface: "#E0E3E6"
    surface-variant: "#43474D"
    on-surface-variant: "#C3C6CE"
    outline: "#8D9198"
    outline-variant: "#43474D"
    inverse-surface: "#E0E3E6"
    inverse-on-surface: "#2D3133"
    inverse-primary: "#49607C"
```

## Typography

Atmos uses **Manrope** for display temperatures, screen titles, and section headings—taking advantage of its clean geometric numerals—paired with **Inter** for UI labels, weather metrics, and descriptive copy. **Source Code Pro** is reserved for coordinate or timestamp metadata if needed. All numeric weather values use `tabular-nums` so temperatures, wind speeds, and percentages align cleanly.

```yaml
typography:
  display-lg:
    fontFamily: "Manrope"
    fontSize: 64px
    fontWeight: 700
    lineHeight: 68px
    letterSpacing: -1.5px
  display-lg-mobile:
    fontFamily: "Manrope"
    fontSize: 32px
    fontWeight: 700
    lineHeight: 36px
    letterSpacing: -0.75px
  headline-lg:
    fontFamily: "Manrope"
    fontSize: 36px
    fontWeight: 700
    lineHeight: 42px
    letterSpacing: -0.5px
  headline-lg-mobile:
    fontFamily: "Manrope"
    fontSize: 24px
    fontWeight: 700
    lineHeight: 30px
    letterSpacing: -0.25px
  headline-md:
    fontFamily: "Manrope"
    fontSize: 20px
    fontWeight: 600
    lineHeight: 26px
    letterSpacing: -0.2px
  title-lg:
    fontFamily: "Manrope"
    fontSize: 18px
    fontWeight: 600
    lineHeight: 24px
    letterSpacing: 0px
  title-md:
    fontFamily: "Inter"
    fontSize: 16px
    fontWeight: 600
    lineHeight: 22px
    letterSpacing: 0px
  title-sm:
    fontFamily: "Inter"
    fontSize: 14px
    fontWeight: 600
    lineHeight: 20px
    letterSpacing: 0.1px
  body-lg:
    fontFamily: "Inter"
    fontSize: 16px
    fontWeight: 400
    lineHeight: 24px
    letterSpacing: 0px
  body-md:
    fontFamily: "Inter"
    fontSize: 14px
    fontWeight: 400
    lineHeight: 20px
    letterSpacing: 0px
  body-sm:
    fontFamily: "Inter"
    fontSize: 12px
    fontWeight: 400
    lineHeight: 16px
    letterSpacing: 0.1px
  label-lg:
    fontFamily: "Inter"
    fontSize: 14px
    fontWeight: 600
    lineHeight: 20px
    letterSpacing: 0.1px
  label-md:
    fontFamily: "Inter"
    fontSize: 12px
    fontWeight: 500
    lineHeight: 16px
    letterSpacing: 0.2px
  label-sm:
    fontFamily: "Inter"
    fontSize: 12px
    fontWeight: 500
    lineHeight: 16px
    letterSpacing: 0.3px
```

## Layout & Spacing

Atmos is built specifically for **Android mobile portrait** viewports (`390px` baseline width) using a fluid single-column vertical scroll layout with `16px` horizontal page margins and a strict `4px` / `8px` spacing grid. Related weather metrics sit in a 2-column CSS grid with `12px` gutters, while the 5-day forecast uses a horizontal snap-scrollable strip of compact cards.

```yaml
spacing:
  gutter-xs: 4px
  gutter-sm: 8px
  gutter-md: 12px
  gutter-lg: 16px
  gutter-xl: 24px
  section: 24px
  page-margin: 16px
```

## Elevation & Depth

Hierarchy relies on tonal surface stepping (`#F7FAFD` ground → `#FFFFFF` cards) paired with soft, low-opacity ambient shadows (`0 4px 16px -2px rgba(15, 41, 66, 0.06)`) and subtle `1px` hairline borders (`outline-variant` at low opacity). The Current Weather Hero Card uses a rich directional navy-to-sky-blue gradient to establish immediate focal dominance without heavy drop shadows.

## Shapes

Cards and containers follow a friendly, Material Design 3 rounded geometry: `24px` (`xl`) for the Hero Weather Card, `16px` (`lg`) for detail metric cards and location cards, `12px` (`md`) for compact forecast items and search inputs, and `9999px` (`full`) for pills, chips, and icon buttons.

```yaml
rounded:
  sm: 8px
  DEFAULT: 12px
  md: 12px
  lg: 16px
  xl: 24px
  full: 9999px
```

## Motion & Micro-interaction

Transitions are crisp and responsive, matching native Android Material motion. Interactive state changes (tab switches, favorite toggles, search focus) settle within `150ms`, while state transitions (skeleton shimmer fade-out, card entry) decelerate smoothly over `250ms`.

```yaml
motion:
  state-change:
    duration: 150ms
    delay: 0ms
    timingFunction: cubic-bezier(0.2, 0, 0, 1)
  surface-enter:
    duration: 250ms
    delay: 0ms
    timingFunction: cubic-bezier(0.2, 0, 0, 1)
  surface-exit:
    duration: 150ms
    delay: 0ms
    timingFunction: cubic-bezier(0.3, 0, 1, 1)
```

## Voice & Content Strategy

- **Tone:** Calm, clear, and informative—never alarmist or overly playful.
- **Capitalisation:** Sentence case for descriptions and state messages; Title Case for screen titles ("Explore Locations") and navigation labels ("Home", "Locations").
- **Numbers & Units:** Always use metric units (`°C`, `km/h`, `mm`, `%`) with `tabular-nums`. Temperatures display as whole integers (`18°C`); wind speed as `14 km/h`; precipitation as `0.4 mm`; probability as `20%`.
- **Empty & Error States:** Direct, helpful, and action-oriented ("No locations found — try searching a different city or region", "Unable to load weather data" with a clear "Retry" button).

## Components

Component implementations live as individual HTML sticker sheet files in
`components/`. Each file contains the canonical, styled HTML components with
`<!-- COMPONENT: name -->` comment markers. Read each file before use.

- **Button** → `@components/button.html` — `button-primary`, `button-icon`, `button-with-icon`
- **Card** → `@components/card.html` — `card-elevated`, `card-action`, `card-interactive`, `card-interactive-2`
- **List** → `@components/list.html` — `list-single`, `list-two-line`, `list-leading-icon`, `list-trailing-action`, `list-interactive`, `list-interactive-2`
- **Searchbar** → `@components/searchbar.html` — `searchbar-standard`, `searchbar-with-suggestions`
- **Typography** → `@components/typography.html` — `typography-display`, `typography-body`, `typography-label`
