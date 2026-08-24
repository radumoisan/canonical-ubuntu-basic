# 10. Software Management

!!! note
    This page is structured from the source material. Commands are pending validation.

!!! abstract
    Manage Debian packages with dpkg and apt, and manage software with snaps.

## :material-book-open-page-variant-outline: 10.1 Debian Package Management

Packages simplify software installation and removal, dependency management, conflict prevention, and inventory of installed and configured software.

Ubuntu archives provide two package forms: `deb` binary archives containing executables, configuration, copyright information, and documentation; and `dsc` packages containing original source code and details of changes to it.

`dpkg` installs, builds, removes, and manages Debian package files. It reads package instructions and packs or unpacks files as needed. Package management often requires administrator privileges.

Common `dpkg` commands are `dpkg -i packagename.deb` to install, `dpkg -r packagename.deb` to remove while retaining configuration, `dpkg -P packagename.deb` to purge including configuration, `dpkg -l` to list installed packages, `dpkg -l *name-pattern*` to list matches, `dpkg -L package-name` to list installed files, and `dpkg -S filename-search-pattern` to find an installed package owning a file.

## :material-book-open-page-variant-outline: 10.2 Advanced Package Tool (Apt)

`apt` adds automatic dependency management and easier upgrades to Debian package management. Repositories are listed in `/etc/apt/sources.list` and files in `/etc/apt/sources.list.d/`.

The main Ubuntu repositories are `main` for officially supported free software, `restricted` for officially supported software without a completely free license, `universe` for community-maintained software, and `multiverse` for community-maintained software without a completely free license.

Personal Package Archives (PPAs) on Launchpad can provide more frequent software updates than official repositories. Use apt commands rather than editing source lists directly.

```bash
# Add a repository.
apt-add-repository "https://pathtorepo.net main"
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Add a Personal Package Archive.
apt-add-repository ppa://shinysoft/devel
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Remove a Personal Package Archive.
apt-add-repository --remove ppa://shinysoft/devel
```
??? example "Expected result"
    Validation pending; no captured output is available.

Refresh the package list after adding or removing repositories, and before installing or upgrading packages.

```bash
# Refresh available package metadata.
apt update
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Install a package and its dependencies.
apt install packagename
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Remove a package while retaining configuration files.
apt remove packagename
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Remove unneeded dependencies.
apt autoremove
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Purge a package and its configuration files.
apt purge packagename
```
??? example "Expected result"
    Validation pending; no captured output is available.

`apt upgrade` installs newer versions of installed packages. `apt dist-upgrade` also handles changing dependencies, prioritizing important packages if needed. `apt full-upgrade` may remove installed packages when required to upgrade the system as a whole.

For a menu-driven package interface, use `aptitude`. It can also be used from the command line and automatically removes dependencies when removing a package; with apt, use `apt autoremove`.

## :material-book-open-page-variant-outline: 10.3 Snappy Package Management

Snap is an additional Ubuntu package format, not a replacement for deb packages. It helps developers package applications with their dependencies and deliver transactional updates. A snap includes its software and dependencies, provides app isolation, supports an app-store model, and avoids dependency changes in shared libraries.

```bash
# Install a snap package.
snap install packagename
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Find available snaps.
snap find
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Search available snaps.
snap find searchterm
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# List installed snaps.
snap list
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Refresh a snap to its latest release.
snap refresh packagename
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Remove an installed snap.
snap remove packagename
```
??? example "Expected result"
    Validation pending; no captured output is available.

### :material-application-edit-outline: Holding snap refreshes

`snap refresh --hold` postpones updates for individual snaps or all snaps, indefinitely or for a duration. Units may be seconds (`s`), minutes (`m`), hours (`h`), or a combination; `forever` is valid for an indefinite hold.

```bash
# Hold refreshes for named snaps.
snap refresh --hold=<duration> <snap1> <snap2>...
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Hold Firefox refreshes for 24 hours.
snap refresh --hold=24h firefox
```
??? example "Expected result"
    Validation pending; no captured output is available.

If no duration is specified, the hold defaults to `forever`. If no snaps are named, the hold applies to all installed snaps.

```bash
# Hold automatic refreshes for all snaps for 24 hours.
snap refresh --hold=24h
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# List installed snaps and their hold status.
snap list
```
??? example "Expected result"
    Validation pending; no captured output is available.

When snaps are named, the hold blocks their auto-refreshes and general `snap refresh` requests, but not a targeted refresh. This allows the rest of the system to refresh while a known-problematic snap is held. When no snaps are named, the hold applies to all installed snaps but blocks only auto-refreshes, not general or targeted refresh requests.

```bash
# Remove a hold from Firefox.
snap refresh --unhold firefox
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Remove the automatic refresh hold from all snaps.
snap refresh --unhold
```
??? example "Expected result"
    Validation pending; no captured output is available.

### :material-application-edit-outline: 10.3.1 Software Management Lab

```bash
# List active apt source entries.
cat /etc/apt/sources.list | grep -v "^#" | grep -v "^$"
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Show available MAAS package versions.
apt-cache policy maas
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Install repository management support.
sudo apt install -y software-properties-common
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Add the Audacious PPA.
sudo apt-add-repository ppa:ubuntuhandbook1/apps
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Refresh the package list.
sudo apt update
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Show available Audacious package versions.
apt-cache policy audacious
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Remove the Audacious PPA.
sudo apt-add-repository --remove ppa:ubuntuhandbook1/apps
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Refresh package metadata after removing the PPA.
sudo apt update
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Install nullmailer using default configuration values.
sudo apt install -y nullmailer
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Show the nullmailer package status.
dpkg -l nullmailer
```
??? example "Expected result"
    Validation pending; no captured output is available.

The first status character is the desired state: `u` unknown, `i` install, `r` remove, `p` purge, or `h` hold. The second is the current state: `n` not installed, `i` installed, `c` configuration files present, `u` unpacked, `f` failed configuration removal, `h` half-installed, `W` trigger awaiting, or `t` trigger pending.

```bash
# Remove nullmailer without purging its configuration.
sudo apt remove -y nullmailer
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Show the removed nullmailer package status.
dpkg -l nullmailer
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Purge nullmailer and its configuration.
sudo apt purge -y nullmailer
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Confirm nullmailer no longer has a package entry.
dpkg -l nullmailer
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Search available packages for lynx.
apt-cache search lynx
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Show information about the lynx package.
apt-cache show lynx
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Install snapd.
sudo apt install snapd -y
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# List installed snap applications.
snap list
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Find the hello-world snap.
snap find hello-world
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Install the hello-world snap.
sudo snap install hello-world
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Run the hello-world snap.
hello-world
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Refresh hello-world to the latest version.
sudo snap refresh hello-world
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Hold hello-world refreshes for 24 hours.
sudo snap refresh --hold=24h hello-world
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Remove the hello-world refresh hold.
sudo snap refresh --unhold hello-world
```
??? example "Expected result"
    Validation pending; no captured output is available.

```bash
# Remove the hello-world snap.
sudo snap remove hello-world
```
??? example "Expected result"
    Validation pending; no captured output is available.

> End of the lab. Do not continue to the next topic.
