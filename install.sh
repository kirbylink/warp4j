#!/usr/bin/env bash

# install location
LOCATION=/usr/local/bin

# exit top level program from subshell
trap "exit 1" TERM
export TOP_PID=$$
fail() {
   kill -s TERM $TOP_PID
}

# platform IDs
LIN=linux
MAC=macos
WIN=windows

# Urls
LIN_X64_URL=https://github.com/kirbylink/warp/releases/download/1.0.0/linux-x64.warp-packer
LIN_AARCH64_URL=https://github.com/kirbylink/warp/releases/download/1.0.0/linux-aarch64.warp-packer
MAC_URL=https://github.com/kirbylink/warp/releases/download/1.0.0/macos-x64.warp-packer

# platform architecture
X64=x64
AARCH64=aarch64

# returns this platform ID
get_this_platform() {
    local this_platform="$(uname -s)"
    case $this_platform in
        Linux*) echo $LIN ;;
        Darwin*) echo $MAC ;;
        *)
            echo "Error: Unsupported platform $this_platform" >&2
            fail
        ;;
    esac
}

# returns this platform architecture
get_this_architecture() {
    local this_machine="$(uname -m)"
    case $this_machine in
        x86_64) echo $X64 ;;
        aarch64) echo $AARCH64 ;;
        *)
            echo "Error: Unsupported machine $this_machine" >&2
            fail
        ;;
    esac
}

# actually sets this platform
THIS_PLATFORM=$(get_this_platform)

# actually sets this architecture
THIS_ARCHITECTURE=$(get_this_architecture)

# fetches latest release download link for the platform
get_warp_link() {
    local this_platform=$1
    local this_architecture=$2
    
    if [ "$this_platform" = "$LIN" ]; then
        echo "$LIN_URL"
            if [ "$this_architecture" = "$X64" ]; then
            echo "$LIN_X64_URL"
        else
            echo "$LIN_AARCH64_URL"
        fi
    else
        echo "$MAC_URL"
    fi
}

# downloads and installs single binary
install() {
    local name=$1
    local link=$2
    local temp_location="/tmp/$name"
    echo "Downloading $name..."
    curl -fsSL -o $temp_location $link
    if [ $? != 0 ]; then
        echo "Error: Failed to download $name" >&2
        fail
    fi
    echo "Creating $LOCATION/$name..."
    su -c "install -D \
        --mode=755 \
        --owner=root \
        --group=root \
        '$temp_location' '$LOCATION'"
    if [ $? != 0 ]; then
        echo "Error: Failed to install $name" >&2
        fail
    fi
    rm $temp_location
}

# returns missing dependencies
get_missing_deps() {
    if ! command -v awk > /dev/null 2<&1; then
        echo -n "awk "
    fi
    if ! command -v curl > /dev/null 2<&1; then
        echo -n "curl "
    fi
    if ! command -v file > /dev/null 2<&1; then
        echo -n "file "
    fi
    if ! command -v grep > /dev/null 2<&1; then
        echo -n "grep "
    fi
    if ! command -v sed > /dev/null 2<&1; then
        echo -n "sed "
    fi
    if ! command -v sort > /dev/null 2<&1; then
        echo -n "sort "
    fi
    if ! command -v tar > /dev/null 2<&1; then
        echo -n "tar "
    fi
    if ! command -v unzip > /dev/null 2<&1; then
        echo -n "unzip "
    fi
    if ! command -v zip > /dev/null 2<&1; then
        echo -n "zip"
    fi
}

WARP4J_LINK="https://github.com/kirbylink/warp4j/raw/refs/heads/master/warp4j"

echo "Getting information about warp-packer releases..."
WARP_LINK=$(get_warp_link $THIS_PLATFORM $THIS_ARCHITECTURE)

MISSING_DEPS=$(get_missing_deps)

install "warp-packer" "$WARP_LINK" && \
install "warp4j" "$WARP4J_LINK"

if [ -z "$MISSING_DEPS" ]; then
    echo "Successfully installed"
else
    echo "Main tools successfully installed"
    echo "Please install following with your package manager:"
    echo $MISSING_DEPS
    exit 1
fi
