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
src/weather/ui.aos     # Weather-specific layout using vectra-ui controls
src/weather/text.aos   # focused string/search helpers
src/weather/http.aos   # Open-Meteo request paths and HTTP boundary
src/weather/parse.aos  # geocode and forecast response parsing
Views/                 # declarative AiSVG view source
Assets/icons/          # standard AiVectra app icon metadata
Targets/               # target-specific app metadata
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
