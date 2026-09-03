# argvus-portal

Wayland, DBus and xdg-desktop-portal integration defaults for ARGVUS.

This package owns the extracted portal/environment layer from the larger
`argvus` desktop package:

- systemd `environment.d` defaults for Wayland, DBus activation, desktop
  identity and toolkit behavior
- xdg-desktop-portal backend preference for Hyprland sessions
- Arch packaging for the upstream portal dependencies

It deliberately does not ship `xdg-desktop-portal*.service` units. Those remain
owned by the upstream Arch packages and are activated through their normal
DBus/systemd user paths.

## Runtime

`argvus-session` remains the runtime owner. During login, `argvus-session`,
`argvus-start` and `argvus-sessionctl import-environment` export the active
Wayland/session variables into `systemd --user` and DBus activation.

`argvus-portal` only supplies defaults:

- `/etc/environment.d/argvus-portal.conf`
- `/usr/share/argvus/xdg-desktop-portal/hyprland-portals.conf`

`/usr/share/argvus` is placed first in `XDG_CONFIG_DIRS`, so
xdg-desktop-portal discovers the ARGVUS Hyprland preference without conflicting
with files shipped by `xdg-desktop-portal-hyprland`.

## Installation

```sh
make install
```

Use `DESTDIR` for packaging:

```sh
make DESTDIR="$pkgdir" PREFIX=/usr install
```

## Validation

```sh
make validate
```

The repository does not add user units, so `systemd-analyze --user verify` is
not required for this package.
