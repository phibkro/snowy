{
  description = "snowy — Stylix-backed home-manager settings panel";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, rust-overlay, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ rust-overlay.overlays.default ];
        };
        rust = pkgs.rust-bin.stable.latest.default.override {
          extensions = [ "rust-src" "rust-analyzer" "clippy" ];
        };
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            rust
            pkg-config

            # GTK4 + libadwaita stack — gtk4-rs / libadwaita-rs link
            # against these via pkg-config.
            gtk4
            libadwaita
            glib
            cairo
            pango
            gdk-pixbuf
            graphene

            # Tools the milestone plan reaches for.
            # nix-editor is NOT in nixpkgs (snowfallorg only); M7 will
            # shell out to `nix run github:snowfallorg/nix-editor` —
            # cached after first use.
            cargo-watch # iteration
          ];

          # Wayland-first: gtk4 picks WAYLAND_DISPLAY automatically when
          # the env is set (Hyprland sets it). Fallback to X11 via XWayland
          # if needed.
          shellHook = ''
            echo "snowy dev shell — gtk4 $(pkg-config --modversion gtk4), libadwaita $(pkg-config --modversion libadwaita-1)"
          '';
        };

        # Default package — `nix run` opens snowy. Wired in M9.
        # packages.default = ...

        formatter = pkgs.nixfmt;
      });
}
