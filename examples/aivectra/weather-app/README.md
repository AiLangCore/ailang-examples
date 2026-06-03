# WeatherApp (AiVectra)

Experimental network-backed AiVectra example.

## Run

```bash
ailang package restore
ailang build .
ailang run .
```

## Notes

- Imports AiVectra through the `aivectra` package.
- Imports HTTP helpers through the `std-http` package.
- Uses Open-Meteo APIs when run interactively.
- This remains experimental until the HTTP/package/runtime boundaries are stable
  enough for primary demos.
