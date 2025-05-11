# Warp4j

### 🛠️ Looking for a modern alternative?

> ⚠️ **This project is no longer actively maintained.**  
> A modern, cross-platform, and type-safe implementation is now available:
>
> 👉 **[java-warp4j](https://github.com/kirbylink/java-warp4j)** — a Java-based rewrite with:
>
> - ✅ Native support for Windows, Linux, and macOS
> - ✅ No shell scripting: portable and maintainable
> - ✅ JDK download & runtime minimization via `jlink`
> - ✅ Works offline with local cache
> - ✅ Fully testable and actively maintained
>
> If you previously relied on this shell script version of Warp4J, consider migrating to [`java-warp4j`](https://github.com/kirbylink/java-warp4j) for improved reliability and future-proof builds.

---

## Turn JAR files into self-contained executables — in a single command

## Features

- Downloads Java runtimes automatically
- Creates minimized runtimes optimized for your application
- Creates platform-specific executables using [warp-packer](https://github.com/kirbylink/warp)
- Supports Linux, macOS, and Windows (via WSL)
- Cross-compilation for other platforms
- No system-wide JDK or JRE required

## TL;DR

Put both `warp4j` and `warp-packer` in your `$PATH`, then run:

```sh
warp4j app.jar
````

## Installation

To install both `warp4j` and `warp-packer`:

```sh
bash -c "$(curl -fsSL https://raw.githubusercontent.com/kirbylink/warp4j/refs/heads/master/install.sh)"
```

This will download and place the tools in `~/.local/bin`.
For other installation methods, see [INSTALL.md](./INSTALL.md).

## Usage

```sh
$ ls
my-app.jar

$ warp4j my-app.jar
...
...

$ ls warped/
my-app-linux-x64
my-app-linux-x64.tar.gz
my-app-macos-x64
my-app-macos-x64.tar.gz
my-app-windows-x64.exe
my-app-windows-x64.zip
```

Run with `--help` to see all options:

```sh
warp4j --help
```

<details>
<summary>Click to view full usage output</summary>

```text
Usage: warp4j [options] <app.jar>

Turn JAR (java archive) into a self-contained executable

Options:
  -j, --java-version <version>     Override JDK/JRE version (default: 17)
                                   Examples: "17", "17.0.2", "17.0.2+9"
  -cp, --class-path <classpath>    Add additional classpaths to jdeps
  --auto-class-path                Extract class-path from JAR manifest
  --spring-boot                    Extract Spring-Boot dependencies from BOOT-INF/lib
  -o, --output <directory>         Output folder (default: ./warped)
  -p, --prefix <prefix>            Folder name for extracted bundle
  --list                           List available Java releases
  --add-modules                    Comma-separated list of additional modules
  --no-optimize                    Use full JRE instead of optimized runtime
  --pull                           Force re-download of latest runtime
  --linux                          Build for Linux
  --macos                          Build for macOS
  --windows                        Build for Windows
  --jvm-options <opts>            JVM args like '-Xmx512m -Xms256m'
  -s, --silent                     Use `javaw.exe` on Windows
  -h, --help                       Show help message
```

</details>

## Notes for macOS Users

For macOS, the generated `.app` is stored inside the `.tar.gz` file:

1. Extract `my-app-macos-x64.tar.gz`
2. Inside you'll find `my-app.app` — double-click to launch

## Cache Location

Downloaded JDKs and generated bundles are stored in:

* **Linux:** `~/.local/share/warp4j`
* **macOS:** `~/Library/Application Support/warp4j`

To override this path, set the `WARP4J_CACHE` environment variable.

---

> 📝 **Tip:** If you're using this tool in CI/CD or want Docker integration, consider switching to [java-warp4j](https://github.com/kirbylink/java-warp4j), which supports container-based builds out of the box.