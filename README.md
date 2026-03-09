# mnstrv2

A new adventure begins!

## Getting Started

1. Copy `.env.yaml.example` to `.env.yaml`.
1. Fill in the environment details

Run the launchers or tasks to launch, debug, or compile app.

## Integration tests

To run the integration tests to run, you'll need to find a device id to run them on. You can get this with `flutter devices`. For example, it may look like this:

```ascii
Found 2 connected devices:
  Linux (desktop) • linux  • linux-x64      • Manjaro Linux 6.12.73-1-MANJARO
  Chrome (web)    • chrome • web-javascript • Google Chrome 145.0.7632.159

Run "flutter emulators" to list and start any available device emulators.
```

The device id is the word in the second column of the list. Such as `linux` or `chrome` in the above example.

**Note:** You cannot run the integration tests in Chrome yet; Flutter does not support it.

Here's the command to kick off the tests:

```shell
flutter test integration_test/all_tests.dart --device-id=linux
```

Replace the `--device-id=` value with the device id you selected previously.

**Observation:** The tests pause at a certain point, because the terminal no longer has focus. We found that clicking back on the terminal solved. If that's the case with you:

1. Run the tests in the terminal
1. After the application has loaded, click back on the terminal
