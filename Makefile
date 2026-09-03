PREFIX ?= /usr
DESTDIR ?=

.DEFAULT_GOAL := help

.PHONY: help install uninstall validate

help:
	@echo "Available targets:"
	@echo "  make build"
	@echo "  make install"
	@echo "  make uninstall"
	@echo "  make validate"

install:
	install -dm755 "$(DESTDIR)/etc/environment.d"
	cp -a config/environment.d/. "$(DESTDIR)/etc/environment.d/"
	install -Dm644 config/xdg-desktop-portal/hyprland-portals.conf \
		"$(DESTDIR)$(PREFIX)/share/argvus/xdg-desktop-portal/hyprland-portals.conf"
	install -Dm644 LICENSE "$(DESTDIR)$(PREFIX)/share/licenses/argvus-portal/LICENSE"

uninstall:
	rm -f "$(DESTDIR)/etc/environment.d/argvus-portal.conf"
	rm -f "$(DESTDIR)/etc/environment.d/argvus.conf"
	rm -f "$(DESTDIR)/etc/environment.d/wayland.conf"
	rm -f "$(DESTDIR)$(PREFIX)/share/argvus/xdg-desktop-portal/hyprland-portals.conf"
	rm -f "$(DESTDIR)$(PREFIX)/share/licenses/argvus-portal/LICENSE"

validate:
	@test -f config/environment.d/argvus-portal.conf
	@test -f config/environment.d/argvus.conf
	@test -f config/environment.d/wayland.conf
	@test -f config/xdg-desktop-portal/hyprland-portals.conf
	@awk ' \
		/^[[:space:]]*($$|#)/ { next } \
		/^[A-Za-z_][A-Za-z0-9_]*=/ { next } \
		{ print "invalid environment.d line " FNR ": " $$0; ok=1 } \
		END { exit ok }' config/environment.d/*.conf
	@awk ' \
		/^[[:space:]]*($$|#)/ { next } \
		/^\[[A-Za-z0-9_.-]+\]$$/ { next } \
		/^[A-Za-z0-9_.-]+=[^=]*$$/ { next } \
		{ print "invalid portals.conf line " FNR ": " $$0; ok=1 } \
		END { exit ok }' config/xdg-desktop-portal/hyprland-portals.conf
	@! find . -path './pkg' -prune -o -path './src' -prune -o -name '*.service' -print | grep -q . || \
		{ echo "argvus-portal must not ship duplicate portal user services"; exit 1; }
	@echo "argvus-portal config ok"

.PHONY: build

build:
	@tools/build-local-package.sh
