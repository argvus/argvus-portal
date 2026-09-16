# argvus-portal

Wayland, DBus and xdg-desktop-portal integration defaults for ARGVUS.

This Arch package owns the portal/environment configuration layer extracted
from the larger `argvus` desktop package. It provides systemd `environment.d`
defaults and the Hyprland portal backend preference, without shipping portal
service units owned by upstream packages.

## Build and install

On Arch Linux or a compatible distribution:

```sh
sudo pacman -S --needed base-devel git shellcheck
make validate
make build
make install
```

`make build` creates a deterministic source archive in `build/artifacts/` and
one package in `build/dist/`. For package metadata only:

```sh
makepkg -p packaging/arch/ci/PKGBUILD --printsrcinfo
```

See [packaging/arch/README.md](packaging/arch/README.md) for local and release
build details.

## Installed files

- `/etc/environment.d/argvus-portal.conf`
- `/etc/environment.d/argvus.conf`
- `/etc/environment.d/wayland.conf`
- `/usr/share/argvus/portal/config/xdg-desktop-portal/hyprland-portals.conf`

`argvus-session` remains responsible for importing the active session
environment into systemd and DBus activation.

## License

SPDX: `GPL-3.0-only`. See [LICENSE](LICENSE).
