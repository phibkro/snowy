# snowy ❄️

A Stylix-backed home-manager settings panel for NixOS. Browse icon themes,
cursors, fonts, and base16 colour schemes with live preview; apply
ephemerally to test, persist as a NixOS generation when satisfied.

**Status:** M0 — project skeleton + libadwaita hello-world. Four
empty `Adw.PreferencesWindow` pages. Functionality lands in M3–M6.

## Why

Documented at:

- Design: [`docs/DESIGN.md`](docs/DESIGN.md)
- Plan:   [`docs/PLAN.md`](docs/PLAN.md)

Short version: previous attempts at NixOS GUIs (nix-gui,
nixos-conf-editor, SnowflakeOS) hit walls at full-OS scope. snowy
narrows to home-manager / desktop theming where the walls dissolve, and
builds on the existing `just option / set / preview / rebuild` CLI
primitives.

## Develop

```sh
cd /srv/share/projects/snowy
just dev             # nix develop + cargo run — opens "Snowy — Preferences"

# or, manually:
nix develop          # drop into gtk4 + libadwaita + rust shell
cargo run
```

Other recipes: `just build`, `just watch`, `just check`, `just fmt`.

## Scope

Initial: Stylix users only. The `ConfigBackend` trait is designed to
extend to vanilla home-manager / KDE / etc. later, but those backends
are deliberately out of scope for v0.1.
