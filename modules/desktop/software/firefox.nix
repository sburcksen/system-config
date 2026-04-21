{
  pkgs,
  inputs,
  config,
  lib,
  ...
}:

{
  options.desktop.firefox.enable = lib.mkSubOption config.desktop.enable "Firefox";

  config = lib.mkIf config.desktop.firefox.enable {
    home = {
      xdg.mimeApps.defaultApplications = {
        "text/html" = [ "firefox.desktop" ];
        "text/xml" = [ "firefox.desktop" ];
        "x-scheme-handler/http" = [ "firefox.desktop" ];
        "x-scheme-handler/https" = [ "firefox.desktop" ];
      };

      programs.firefox = {
        enable = true;
        profiles.default = {
          id = 0;
          settings = {
            "ui.systemUsesDarkTheme" = 1;

            "browser.startup.homepage" = "about:home";
            "browser.search.defaultenginename" = "ddg";
            "browser.search.order.1" = "ddg";
            "browser.newtabpage.pinned" = "";
            "browser.newtabpage.activity-stream.showSponsored" = false;
            "browser.newtabpage.activity-stream.system.showSponsored" = false;
            "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
            "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
            "browser.newtabpage.activity-stream.feeds.snippets" = false;

            # Disable telemetry
            "app.shield.optoutstudies.enabled" = false;
            "browser.discovery.enabled" = false;
            "browser.newtabpage.activity-stream.feeds.telemetry" = false;
            "browser.newtabpage.activity-stream.telemetry" = false;
            "browser.ping-centre.telemetry" = false;
            "datareporting.healthreport.service.enabled" = false;
            "datareporting.healthreport.uploadEnabled" = false;
            "datareporting.policy.dataSubmissionEnabled" = false;
            "datareporting.sessions.current.clean" = true;
            "devtools.onboarding.telemetry.logged" = false;
            "toolkit.telemetry.enabled" = false;
            "toolkit.telemetry.unified" = false;

            # Resist fingerprinting
            "privacy.resistFingerprinting" = true;
            "privacy.trackingprotection.enabled" = true;
            "privacy.trackingprotection.fingerprinting.enabled" = true;
            "privacy.trackingprotection.cryptomining.enabled" = true;

            # Https Only
            "dom.security.https_only_mode" = true;

            # Enable hardware acceleration (if supported)
            "gfx.webrender.all" = true;

            # Restore session on startup
            "browser.startup.page" = 3;

            # Show full URLs
            "browser.urlbar.trimURLs" = false;
            # Disable search suggestions in URL bar
            "browser.urlbar.suggest.searches" = false;
            "browser.search.suggest.enabled" = false;

            # Disable update checking
            "app.update.enabled" = false;
            # Disable "What's New" page after updates
            "browser.startup.homepage_override.mstone" = "ignore";

            # Disable "save password" prompt
            "signon.rememberSignons" = false;
          };

          extensions.packages = with inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system}; [
            ublock-origin
            bitwarden
          ];

          search = {
            force = true;
            default = "ddg";
            order = [
              "ddg"
              "google"
            ];
            engines = {
              "Nix Packages" = {
                urls = [
                  {
                    template = "https://search.nixos.org/packages";
                    params = [
                      {
                        name = "type";
                        value = "packages";
                      }
                      {
                        name = "query";
                        value = "{searchTerms}";
                      }
                    ];
                  }
                ];
                icon = "''${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                definedAliases = [ "@np" ];
              };
              "Nix Options" = {
                urls = [
                  {
                    template = "https://search.nixos.org/options";
                    params = [
                      {
                        name = "type";
                        value = "options";
                      }
                      {
                        name = "query";
                        value = "{searchTerms}";
                      }
                    ];
                  }
                ];
                icon = "''${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                definedAliases = [ "@no" ];
              };
              "Home-manager Options" = {
                urls = [
                  {
                    template = "https://home-manager-options.extranix.com/";
                    params = [
                      {
                        name = "type";
                        value = "options";
                      }
                      {
                        name = "query";
                        value = "{searchTerms}";
                      }
                    ];
                  }
                ];
                icon = "''${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                definedAliases = [ "@hm" ];
              };
              "google".metaData.alias = "@g";
              "bing".metaData.hidden = true;
              "ecosia".metaData.hidden = true;
            };
          };
        };
      };
    };
  };
}
