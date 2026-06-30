# WeatherApp (AiVectra)

Production-style AiVectra example backed by the Open-Meteo geocoding and
forecast APIs.

## Run

```bash
ailang run .
```

The app opens an AiVectra window, accepts a city or ZIP-style query, fetches
matching locations from Open-Meteo, and loads the selected forecast from live
Open-Meteo data. Celsius and Fahrenheit radio controls request the selected
temperature unit directly from Open-Meteo.

The project manifest declares `runTool="aivectra"`, so `ailang run .`
restores packages when needed and delegates to the installed `aivectra` tool.
Use `ailang aivectra ...` only for explicit AiVectra tool commands.

## Structure

```text
src/app.aos            # entry point, UI rendering, event flow
src/Views/             # declarative AiSVG view source and code-behind
src/Assets/icons/      # standard AiVectra app icon metadata
src/Targets/           # target-specific app metadata
src/weather/ui.aos     # Weather-specific layout using vectra-ui controls
src/weather/text.aos   # focused string/search helpers
src/weather/http.aos   # Open-Meteo request paths and HTTP boundary
src/weather/parse.aos  # geocode and forecast response parsing
```

The current beta lowers the AiSVG view intent through `src/weather/ui.aos` and
`src/weather/forecast.aos` using the `aivectra.aisvg` scene-record API. The
`.aisvg` files are the declarative view source for the example; the companion
`.aos` modules own model, update, HTTP, and rendering glue until the AiSVG file
compiler is available.

## Dependencies

- Imports AiVectra through the `aivectra` package.
- Imports standard controls through the `vectra-ui` package.
- Imports HTTP helpers through the `std-http` package.
- Uses real Open-Meteo responses; no canned weather payloads are embedded in the
  application source.

## AiOS QEMU

The weather app declares the AiOS GUI target package so it can publish and run
as a shell-less AiOS GUI image.

```bash
ailang package restore
ailang publish . \
  --target aios-gui \
  --target-option arch=aarch64 \
  --target-option feature=network \
  --target-option display-backend=drm \
  --out dist-aios
```

To run the published image in QEMU:

```bash
ailang run . \
  --target aios-gui \
  --target-option arch=aarch64 \
  --target-option feature=network \
  --target-option debug-console=stdio \
  --target-option display-backend=drm \
  -- \
  -m 2048 \
  -device virtio-gpu-pci \
  -device qemu-xhci,id=xhci \
  -device usb-kbd,bus=xhci.0 \
  -device usb-tablet,bus=xhci.0 \
  -display cocoa
```

AiOS Buildroot base creation requires a Linux build host. macOS can run and
publish against an already cached or imported base image. The current
`target-aios-gui` package uses the compatible base image
`0.0.1-alpha.1` by default; override it only when testing a different base:

```bash
ailang run . \
  --target aios-gui \
  --target-option arch=aarch64 \
  --target-option base-version=0.0.1-alpha.1
```
