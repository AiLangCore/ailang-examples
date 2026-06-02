# HelloWorld (AiVectra)

Canonical baseline example for AiVectra app structure and runtime usage.

## Behavior
Displays `Hello, World!` using AiVectra public API and standardized runtime flow.

## Run
```bash
ailang package restore
ailang build .
ailang run .
```

## Notes
- Example code imports AiVectra through the `aivectra` package.
- The source app lives at `src/app.aos`.
