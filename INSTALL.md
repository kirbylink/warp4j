# Install

Here are several more ways to install `warp4j`.

## Install script
Run the [install.sh](./install.sh) script from source or use the following command:
```sh
curl -s https://github.com/kirbylink/warp4j/raw/branch/master/install.sh | /bin/sh -s
```


## Manual

First install [warp-packer](https://github.com/kirbylink/warp/releases) and ensure other common tools available: `awk`, `curl`, `file`, `grep`, `sed`, `sort`, `tar`, `unzip`, optional: `zip`. Then install `warp4j` like this:

```
$ LOCATION=/usr/local/bin \
LINK=https://github.com/kirbylink/warp4j/raw/branch/master/warp4j \
TEMP_LOCATION=/tmp/warp4j \
bash -c 'curl -fsSL -o $TEMP_LOCATION $LINK && \
sudo install -D \
  --mode=755 \
  --owner=root \
  --group=root \
  "$TEMP_LOCATION" "$LOCATION"'
```

Previous command can be also used to upgrade to the latest version.

## Docker

See [Dockerfile](./Dockerfile)