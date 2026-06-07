// snowy — Stylix-backed HM/desktop settings panel.
//
// M0 — hello-libadwaita: prove the stack compiles, renders, and themes
// correctly under the current Stylix install. No config reading yet,
// no commit flow, no real cards. Just an Adw.PreferencesWindow with
// four empty pages — the skeleton the rest of slice 1 fleshes out.
//
// `PreferencesWindow` is deprecated since libadwaita 1.6 in favour of
// `PreferencesDialog`. M2 will restructure around a proper
// `ApplicationWindow` + `ViewStack` shape; M0 keeps the deprecated API
// because it's the shortest path to a window-on-screen.
#![allow(deprecated)]

use gtk4::prelude::*;
use gtk4::{glib, Application};
use libadwaita as adw;
use libadwaita::prelude::*;

const APP_ID: &str = "lan.nori.snowy";

fn main() -> glib::ExitCode {
    let app = Application::builder().application_id(APP_ID).build();
    app.connect_activate(build_window);
    app.run()
}

fn build_window(app: &Application) {
    let window = adw::PreferencesWindow::builder()
        .application(app)
        .title("Snowy — Preferences")
        .default_width(900)
        .default_height(600)
        .build();

    // Four pages, all empty — wired in M3–M6.
    window.add(&page("icon-page", "Icon Theme", "image-x-generic-symbolic"));
    window.add(&page("cursor-page", "Cursor", "input-mouse-symbolic"));
    window.add(&page("font-page", "Font", "font-x-generic-symbolic"));
    window.add(&page("scheme-page", "Colour Scheme", "applications-graphics-symbolic"));

    window.present();
}

/// Stub PreferencesPage — replaced per-card in M3–M6. Helper here so M0
/// stays terse and the four-page shell is visible at a glance.
fn page(name: &str, title: &str, icon: &str) -> adw::PreferencesPage {
    let page = adw::PreferencesPage::builder()
        .name(name)
        .title(title)
        .icon_name(icon)
        .build();

    let group = adw::PreferencesGroup::builder()
        .title(title)
        .description("Not yet implemented — see docs/superpowers/plans/2026-06-07-snowy-implementation-plan.md")
        .build();

    page.add(&group);
    page
}
