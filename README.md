For some reason the workflow doesn't trigger GH Pages to publish any updates to the app's website when the `gh-pages` branch is updated via the workflow.

To get it to publish, when an update is made to the `main` branch, switch to the `build_release_tictactuple` branch, and select the 'update from main' option in GitHub Desktop. Once pushed, it will trigger the 'build and deploy' workflow.

- [View Workflow Runs](https://github.com/KDCinfo/dev-play/actions/workflows/tuple-web-release.yml)

When the workflow has completed:

1. Change the [Build and Deployment "source"](https://github.com/KDCinfo/dev-play/settings/pages) from `GitHub Actions` to `Deploy from a branch`.
2. Edit and commit this readme to the `gh-pages` branch --- this will trigger the publishing of the site.
3. Once published, set the trigger source back to `GitHub Actions`.

Timestamp: 2024-07-12 | 001
