# Base Services

Services relevant at the base app level (can be used as-is/out-of-the-box by other apps).

## Installation

Add `base_services` to your `pubspec.yaml`:

```yaml
dependencies:
  base_services:
    path: packages/base_services
```

Update the `analysis_options.yaml` file in the app's root folder:

```yaml
include: packages/base_services/analysis_options.yaml
```

## Optional - Update rules

- File: `packages\base_services\lib\src\analysis_options.yaml`

```yaml
linter:
  rules:
    # avoid_print: false  # Uncomment to disable the `avoid_print` rule
    # prefer_single_quotes: true  # Uncomment to enable the `prefer_single_quotes` rule
    lines_longer_than_80_chars: false
    public_member_api_docs: false
```

A couple notes on updating this package directly:

1. This is only a local package and will not be overriden via pub.dev.
2. It is currently not designed to accommodate rule overrides to avoid having to update the package.

## Optional - DCM

This is a subscription service.

At the bottom of that same `analysis_options.yaml` file:

```yaml
# This is for anyone using DCM.
#
# dart_code_metrics:
#   extends:
#     - recommended
#   rules:
#     - avoid-shadowing: false
#     - prefer-match-file-name: false
#     - prefer-single-widget-per-file: false
#     - no-empty-block: false
#     - unnecessary-trailing-comma: false
```
