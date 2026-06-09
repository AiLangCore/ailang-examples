# WeatherApp (AiVectra)

Production-style AiVectra example backed by the Open-Meteo geocoding and
forecast APIs.

## Run

```bash
ailang package restore
ailang build .
ailang run .
```

The app opens an AiVectra window, accepts a city or ZIP-style query, fetches
matching locations from Open-Meteo, and loads the selected forecast from live
Open-Meteo data.

## Structure

```text
src/app.aos            # entry point, UI rendering, event flow
src/weather/ui.aos     # Weather-specific layout using vectra-ui controls
src/weather/text.aos   # focused string/search helpers
src/weather/http.aos   # Open-Meteo request paths and HTTP boundary
src/weather/parse.aos  # geocode and forecast response parsing
Assets/icons/          # standard AiVectra app icon metadata
Targets/               # target-specific app metadata
```

## Dependencies

- Imports AiVectra through the `aivectra` package.
- Imports standard controls through the `vectra-ui` package.
- Imports HTTP helpers through the `std-http` package.
- Uses real Open-Meteo responses; no canned weather payloads are embedded in the
  application source.
