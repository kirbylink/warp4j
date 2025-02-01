# Warp4j

Turn JAR (java archive) into self-contained executable in a single command.

## Features

- Downloads Java runtimes automatically
- Makes runtimes optimized for your application
- Creates self-contained binaries for Linux, macOS, and Windows using [warp-packer](https://git.phoenix.ipv64.de/public/warp)
- Works on Linux, macOS, and Windows (with Windows Subsystem for Linux)
- Supports cross "compilation"
- Does not require either JDK or JRE installed

## TL;DR

Just put both `warp4j` and `warp-packer` somewhere in your PATH and run `warp4j app.jar`.

## Install

Curl one-liner installs the latest versions of both `warp4j` and `warp-packer`:

```
bash -c "$(curl -fsSL https://github.com/kirbylink/warp4j/raw/refs/heads/master/install.sh)"
```

This script will show missing dependencies (if there are any); they must be installed with your package manager.

See more install methods [here](INSTALL.md).

## Usage

```sh
$ ls
my-app.jar

$ warp4j my-app.jar
...
...
...

$ ls -1
my-app.jar
warped

$ ls warped
my-app-linux-x64
my-app-linux-x64.tar.gz
my-app-macos-x64
my-app-macos-x64.tar.gz
my-app-windows-x64.exe
my-app-windows-x64.zip
```

See help:

```sh
$ warp4j --help

Usage: warp4j [options] <app.jar>

Turn JAR (java archive) into a self-contained executable

Options:
  -j, --java-version   <version>
                       Override JDK/JRE version
                       Examples: "17", "17.0", "17.0.2", "17.0.2+9"
                       (default: 17)
  -cp, --class-path    <classpath>
                       Adds additional classpaths to the jdeps call
  --auto-class-path    Extract and get class-path values from jar file
                       Ignored when -cp, --class-path is set
  --spring-boot        Extract and get class-path values from
                       Spring-Boot application jar file
                       Ignored when -cp, --class-path is set
  -o, --output         <directory>
                       Override output directory;
                       This is relative to current PWD
                       (default: ./warped)
  -p, --prefix         <prefix>
                       If set, warp-packer will use the prefix
                       as target folder in which the
                       application should be extracted
  --list               Show available java releases;
                       Takes into consideration other options:
                       "--java-version", "--no-optimize", "--jvm-impl";
                       The output may be used to specify concrete
                       "--java-version"
  --add-modules        A list of additional java modules that should
                       be added to the optimized JDK. Separate each
                       module with commas and no spaces
  --no-optimize        Use JRE instead of optimized JDK;
                       By default jdeps and jlink are used to create
                       optimized JDK for the particular jar;
                       JRE is always used for java 8
  --pull               Check if more recent JDK/JRE distro is available;
                       By default latest cached version that matches
                       "--java-version" is used
  --linux              Create binary for Linux
  --macos              Create binary for macOS
  --windows            Create binary for Windows
                       If no targets are specified then binaries for
                       all targets are created
  --jvm-options        <options>
                       Passed to java like this:
                       "java <options> -jar <jar file>";
                       Use quotes when passing multiple options
                       Example: '-Xms512m -Xmx1024m'
  -s, --silent         Using javaw instead of java for windows
  -h, --help           Show this message
```

### Running on macOS

For macOS, the executable is placed inside a folder with the `.app` extension within the tar.gz file. This allows the application to be launched with a double-click.

To run the application:

1. **From the Executable**:
   - Navigate to the `warped` folder.
   - Find the `my-app-macos-x64` executable.
   - Note: Double-clicking on “my-app-macos-x64” does not work directly because macOS does not know which program to use to open the application.
   - To run it, open the terminal and navigate to the `warped` folder:
     ```sh
     cd /path/to/warped
     ```
   - Run the executable from the terminal:
     ```sh
     ./my-app-macos-x64
     ```

2. **From the tar.gz File**:
   - Extract the `my-app-macos-x64.tar.gz` file.
   - Navigate to the extracted folder: `my-app-macos-x64`.
   - You will find a folder named `my-app.app`. For macOS this is now an executable file.
   - Double-click on `my-app.app` to run the application.

## Compatibility

Tested on the following operating systems:

- Debian 12.5

## Cache Location

Downloaded runtimes and prepared bundles are here:

- Linux: `$HOME/.local/share/warp4j`
- macOS: `$HOME/Library/Application Support/warp4j`

To override cache path, set `WARP4J_CACHE` environment variable.
