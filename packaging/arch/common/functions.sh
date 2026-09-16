#!/usr/bin/env bash
# shellcheck shell=bash
# shellcheck disable=SC2154

arch_normalize_source_tree() {
	local expected="${srcdir}/${pkgname}-${pkgver}"
	local -a roots=()
	while IFS= read -r -d '' root; do roots+=("$root"); done < <(
		find "$srcdir" -mindepth 1 -maxdepth 1 -type d -print0
	)
	if (( ${#roots[@]} != 1 )); then
		printf 'error: expected exactly one extracted source directory in %s\n' "$srcdir" >&2
		return 1
	fi
	if [[ "${roots[0]}" != "$expected" ]]; then
		[[ ! -e "$expected" ]] || return 1
		mv -- "${roots[0]}" "$expected"
	fi
}

arch_check_portal_payload() {
	local source_root="${srcdir}/${pkgname}-${pkgver}"
	local config_root="$source_root/src/usr/share/argvus/portal/config"
	test -f "$source_root/LICENSE"
	test -f "$config_root/environment.d/argvus-portal.conf"
	test -f "$config_root/environment.d/argvus.conf"
	test -f "$config_root/environment.d/wayland.conf"
	test -f "$config_root/xdg-desktop-portal/hyprland-portals.conf"
	! find "$source_root" -name '*.service' -print -quit | grep -q .
}

arch_package_portal_payload() {
	local source_root="${srcdir}/${pkgname}-${pkgver}"
	local config_root="$source_root/src/usr/share/argvus/portal/config"
	install -Dm644 "$source_root/LICENSE" "${pkgdir}/usr/share/licenses/${pkgname}/LICENSE"
	install -Dm644 "$config_root/environment.d/argvus-portal.conf" "${pkgdir}/etc/environment.d/argvus-portal.conf"
	install -Dm644 "$config_root/environment.d/argvus.conf" "${pkgdir}/etc/environment.d/argvus.conf"
	install -Dm644 "$config_root/environment.d/wayland.conf" "${pkgdir}/etc/environment.d/wayland.conf"
	install -Dm644 "$config_root/xdg-desktop-portal/hyprland-portals.conf" "${pkgdir}/usr/share/argvus/portal/config/xdg-desktop-portal/hyprland-portals.conf"
}
