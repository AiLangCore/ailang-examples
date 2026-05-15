# Hello AiVectra

Minimal package-based AiVectra app.

This example is intended for demos where the SDK restores AiVectra as a package
instead of relying on sibling source checkouts.

## Run

```bash
ailang package restore
ailang build .
ailang run .
```

Expected behavior: a small AiVectra window or runtime frame is created by the
installed SDK/runtime. During alpha, platform UI behavior may vary by host.
