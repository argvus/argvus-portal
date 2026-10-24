# argvus-portal

<div align="center">

[![CI](https://github.com/argvus/argvus-portal/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/argvus/argvus-portal/actions/workflows/ci.yml)
[![License](https://img.shields.io/github/license/argvus/argvus-portal)](./LICENSE)
[![Language: Shell](https://img.shields.io/badge/Shell-POSIX-4EAA25?logo=gnubash&logoColor=white)](https://www.gnu.org/software/bash/)
[![Platform: Arch Linux | Wayland](https://img.shields.io/badge/platform-Arch%20Linux%20%7C%20Wayland-1793D1?logo=archlinux&logoColor=white)](https://archlinux.org/)
[![Pull requests](https://img.shields.io/github/issues-pr/argvus/argvus-portal)](https://github.com/argvus/argvus-portal/pulls)
[![Issues](https://img.shields.io/github/issues/argvus/argvus-portal)](https://github.com/argvus/argvus-portal/issues)
[![Last commit](https://img.shields.io/github/last-commit/argvus/argvus-portal)](https://github.com/argvus/argvus-portal/commits/main)
[![Docs](https://img.shields.io/badge/docs-project-blue)](./docs/)

</div>

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
makepkg -p packaging/arch/remote/PKGBUILD --printsrcinfo
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

## Contributing and policies

- [CONTRIBUTING.md](https://github.com/argvus/.github/blob/main/CONTRIBUTING.md) — contribution workflow
- [SECURITY.md](https://github.com/argvus/.github/blob/main/SECURITY.md) — private vulnerability reports
- [Code of Conduct](https://github.com/argvus/.github/blob/main/policies/CODE_OF_CONDUCT.md) — community standards
- [AI usage policy](https://github.com/argvus/.github/blob/main/policies/IA_USAGE.md) — rules for AI-assisted contributions

## License

SPDX: `GPL-3.0-only`. See [LICENSE](LICENSE).
