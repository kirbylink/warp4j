# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [v1.2.0] - 2024-06-01
### Added
- Additional modules that aren't fetched by jdeps can be added with `--add-modules module_1,...,module_n`

## [v1.1.0] - 2024-05-31
### Changed
- Improved macOS runnable execution in the tar.gz file. The executable file is now placed inside a folder named `application.app`, allowing it to be launched with a double-click.

## [v1.0.0] - 2024-05-20
### Changed
- Script warp4j improved to support running on aarch64 architecture
- Install script improved to run with /bin/sh
- Dockerfile changed to use install.sh script (Works on x64 and aarch64 architecture)

### Added
- Dockerfile_x64 with old build script for tests

## [origin warp4j] - 2019-02-28
- See origin repository: https://github.com/guziks/warp4j

[unreleased]: https://github.com/kirbylink/warp4j/compare/master...HEAD
[v1.2.0]: https://github.com/kirbylink/warp4j/compare/v1.1.0...v1.2.0
[v1.1.0]: https://github.com/kirbylink/warp4j/compare/v1.0.0...v1.1.0
[v1.0.0]: https://github.com/kirbylink/warp4j/compare/stable...v1.0.0
[origin warp4j]: https://github.com/guziks/warp4j