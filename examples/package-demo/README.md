# Package Demo

Demonstrates the public package restore flow.

## Run

```bash
ailang package restore
ailang package list
ailang build .
ailang run .
```

This example restores `std-json` from the curated registry, imports AiLang core
from the selected SDK, and runs through the normal build pipeline. The app
itself is intentionally simple so the package workflow is the focus.
