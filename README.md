JRuby Docker Image
===================

Builds jruby docker images.

To update the images, specify the version in `<major>/VERSION`. This should be
the full version.

## Build

To build the images run

```bash
  ./run.sh --action build
```

You can set your own docker registry with the flag `--registry x.y.z/org`

You can exclude what images can be built with the flag `--exclude 1.7` or `--exclude 9000`

## Test

To test the images run

```bash
  ./run.sh --action test
```

## Push

To push the images run

```bash
  ./run.sh --action push
```
