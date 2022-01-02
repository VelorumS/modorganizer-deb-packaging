# Build and packaging scripts for the Mod Organizer 2

Mod Organizer2 (MO2) is a tool for managing game mod collections of arbitrary size. It is specifically designed for people who like to experiment with game mods and thus need an easy and reliable way to install and uninstall them.

This repository is for building and packaging MO2 for Ubuntu 22.04 LTS.

Builds native Linux binary executables, libraries and plugins.

# Usage

Prepare upstream source tarball:

```bash
./download--upstream-tarball.sh
```

(it should download MO2 sources and create a file like `modorganizer_2.4.3.orig.tar.gz`)

Install a tool that's needed to find "build dependencies" (or just look at `modorganizer/debian/control` and install what's needed):

```bash
sudo apt install equivs
```

Install "build dependencies" (or just look at `modorganizer/debian/control` and install what's needed):

```bash
mk-build-deps --install modorganizer/debian/control
```

Build the MO2 package:

```bash
cd modorganizer
debuild -us -uc
```

# How it builds

Sources of all MO2 parts are cloned into `modorganizer/modorganizer_super` directory.

Projects are then built with CMake.
When invoking CMake the `ADDITIONAL_LINK_DIRECTORIES` variable that contains paths to the directories where the libraries are built is passed to CMake.

The complete build script is in the `modorganizer/debian/rules` file (standard location for the deb paackaging).
