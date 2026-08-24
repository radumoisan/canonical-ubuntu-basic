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
    The repository is added to the apt configuration.

```bash
# Add a Personal Package Archive.
apt-add-repository ppa://shinysoft/devel
```
??? example "Expected result"
    The PPA is added to the apt configuration.

```bash
# Remove a Personal Package Archive.
apt-add-repository --remove ppa://shinysoft/devel
```
??? example "Expected result"
    The PPA is removed from the apt configuration.

Refresh the package list after adding or removing repositories, and before installing or upgrading packages.

```bash
# Refresh available package metadata.
apt update
```
??? example "Expected result"
    Apt fetches package metadata from configured repositories.

```bash
# Install a package and its dependencies.
apt install packagename
```
??? example "Expected result"
    The package and required dependencies are installed.

```bash
# Remove a package while retaining configuration files.
apt remove packagename
```
??? example "Expected result"
    The package is removed; configuration files are retained.

```bash
# Remove unneeded dependencies.
apt autoremove
```
??? example "Expected result"
    Apt lists and removes dependencies no longer required by installed packages.

```bash
# Purge a package and its configuration files.
apt purge packagename
```
??? example "Expected result"
    The package and its configuration files are removed.

`apt upgrade` installs newer versions of installed packages. `apt dist-upgrade` also handles changing dependencies, prioritizing important packages if needed. `apt full-upgrade` may remove installed packages when required to upgrade the system as a whole.

For a menu-driven package interface, use `aptitude`. It can also be used from the command line and automatically removes dependencies when removing a package; with apt, use `apt autoremove`.

## :material-book-open-page-variant-outline: 10.3 Snappy Package Management

Snap is an additional Ubuntu package format, not a replacement for deb packages. It helps developers package applications with their dependencies and deliver transactional updates. A snap includes its software and dependencies, provides app isolation, supports an app-store model, and avoids dependency changes in shared libraries.

```bash
# Install a snap package.
snap install packagename
```
??? example "Expected result"
    The requested snap is installed.

```bash
# Find available snaps.
snap find
```
??? example "Expected result"
    Available snaps are listed.

```bash
# Search available snaps.
snap find searchterm
```
??? example "Expected result"
    Snaps matching `searchterm` are listed.

```bash
# List installed snaps.
snap list
```
??? example "Expected result"
    Installed snaps are listed.

```bash
# Refresh a snap to its latest release.
snap refresh packagename
```
??? example "Expected result"
    The requested snap is refreshed if an update is available.

```bash
# Remove an installed snap.
snap remove packagename
```
??? example "Expected result"
    The requested snap is removed.

### :material-application-edit-outline: Holding snap refreshes

`snap refresh --hold` postpones updates for individual snaps or all snaps, indefinitely or for a duration. Units may be seconds (`s`), minutes (`m`), hours (`h`), or a combination; `forever` is valid for an indefinite hold.

```bash
# Hold refreshes for named snaps.
snap refresh --hold=<duration> <snap1> <snap2>...
```
??? example "Expected result"
    Refreshes for the named snaps are held for the requested duration.

```bash
# Hold Firefox refreshes for 24 hours.
snap refresh --hold=24h firefox
```
??? example "Expected result"
    ```text
    General refreshes of "firefox" held until 2022-10-26T14:10:53+01:00
    ```
    The expiry time varies.

If no duration is specified, the hold defaults to `forever`. If no snaps are named, the hold applies to all installed snaps.

```bash
# Hold automatic refreshes for all snaps for 24 hours.
snap refresh --hold=24h
```
??? example "Expected result"
    ```text
    Auto-refresh of all snaps held until 2022-10-26T14:25:58+01:00
    ```
    The expiry time varies.

```bash
# List installed snaps and their hold status.
snap list
```
??? example "Expected result"
    ```text
    Name         Version  Rev   Tracking       Publisher          Notes
    alacritty    0.8.0    46    latest/stable  snapcrafters       classic
    vlc          3.0.18   3078  latest/stable  videolan           -
    yt-dlp       18       212   latest/edge    morrisong          held
    ```
    Installed snaps and versions vary.

When snaps are named, the hold blocks their auto-refreshes and general `snap refresh` requests, but not a targeted refresh. This allows the rest of the system to refresh while a known-problematic snap is held. When no snaps are named, the hold applies to all installed snaps but blocks only auto-refreshes, not general or targeted refresh requests.

```bash
# Remove a hold from Firefox.
snap refresh --unhold firefox
```
??? example "Expected result"
    ```text
    Removed general refresh hold of "firefox"
    ```

```bash
# Remove the automatic refresh hold from all snaps.
snap refresh --unhold
```
??? example "Expected result"
    ```text
    Removed auto-refresh hold on all snaps
    ```

### :material-application-edit-outline: 10.3.1 Software Management Lab

```bash
# List active apt source entries.
cat /etc/apt/sources.list | grep -v "^#" | grep -v "^$"
```
??? example "Expected result"
    Uncommented, non-empty repository entries are displayed.

```bash
# Show available MAAS package versions.
apt-cache policy maas
```
??? example "Expected result"
    The installed and candidate MAAS package versions are displayed.

```bash
# Install repository management support.
sudo apt install -y software-properties-common
```
??? example "Expected result"
    The package is installed or reported as already installed.

```bash
# Add the Audacious PPA.
sudo apt-add-repository ppa:ubuntuhandbook1/apps
```
??? example "Expected result"
    The PPA is added after confirmation when prompted.

```bash
# Refresh the package list.
sudo apt update
```
??? example "Expected result"
    Apt refreshes package metadata.

```bash
# Show available Audacious package versions.
apt-cache policy audacious
```
??? example "Expected result"
    The installed and candidate Audacious package versions are displayed.

```bash
# Remove the Audacious PPA.
sudo apt-add-repository --remove ppa:ubuntuhandbook1/apps
```
??? example "Expected result"
    The PPA is removed.

```bash
# Refresh package metadata after removing the PPA.
sudo apt update
```
??? example "Expected result"
    Apt refreshes package metadata.

```bash
# Install nullmailer using default configuration values.
sudo apt install -y nullmailer
```
??? example "Expected result"
    `nullmailer` is installed.

```bash
# Show the nullmailer package status.
dpkg -l nullmailer
```
??? example "Expected result"
    A status line beginning with `ii` indicates the package is selected for installation and installed.

The first status character is the desired state: `u` unknown, `i` install, `r` remove, `p` purge, or `h` hold. The second is the current state: `n` not installed, `i` installed, `c` configuration files present, `u` unpacked, `f` failed configuration removal, `h` half-installed, `W` trigger awaiting, or `t` trigger pending.

```bash
# Remove nullmailer without purging its configuration.
sudo apt remove -y nullmailer
```
??? example "Expected result"
    `nullmailer` is removed and configuration files remain.

```bash
# Show the removed nullmailer package status.
dpkg -l nullmailer
```
??? example "Expected result"
    A status line beginning with `rc` indicates the package is removed and configuration files remain.

```bash
# Purge nullmailer and its configuration.
sudo apt purge -y nullmailer
```
??? example "Expected result"
    `nullmailer` and its configuration files are removed.

```bash
# Confirm nullmailer no longer has a package entry.
dpkg -l nullmailer
```
??? example "Expected result"
    Apt reports that no packages match `nullmailer`.

```bash
# Search available packages for lynx.
apt-cache search lynx
```
??? example "Expected result"
    Packages matching `lynx` are listed.

```bash
# Show information about the lynx package.
apt-cache show lynx
```
??? example "Expected result"
    Package metadata for `lynx` is displayed.

```bash
# Install snapd.
sudo apt install snapd -y
```
??? example "Expected result"
    `snapd` is installed or reported as already installed.

```bash
# List installed snap applications.
snap list
```
??? example "Expected result"
    Installed snaps are listed.

```bash
# Find the hello-world snap.
snap find hello-world
```
??? example "Expected result"
    The `hello-world` snap is listed if available.

```bash
# Install the hello-world snap.
sudo snap install hello-world
```
??? example "Expected result"
    `hello-world` is installed.

```bash
# Run the hello-world snap.
hello-world
```
??? example "Expected result"
    The hello-world application displays its greeting.

```bash
# Refresh hello-world to the latest version.
sudo snap refresh hello-world
```
??? example "Expected result"
    `hello-world` is refreshed or reported as already current.

```bash
# Hold hello-world refreshes for 24 hours.
sudo snap refresh --hold=24h hello-world
```
??? example "Expected result"
    A message confirms a refresh hold for `hello-world`; the expiry time varies.

```bash
# Remove the hello-world refresh hold.
sudo snap refresh --unhold hello-world
```
??? example "Expected result"
    A message confirms the hold was removed.

```bash
# Remove the hello-world snap.
sudo snap remove hello-world
```
??? example "Expected result"
    `hello-world` is removed.

> End of the lab. Do not continue to the next topic.
