{pkgs, inputs, lib, ...}: {

  programs.firefox = {
    enable = true;
    package = pkgs.librewolf; 
    profiles.balint = {
      id = 0;
      isDefault = true;
      name = "balint";

      settings = {
        "general.smoothScroll" = true;
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true; 
        "privacy.clearOnShutdown.history" = false;
        "privacy.clearOnShutdown.downloads" = false;
        "browser.startup.page" = 3;
        "browser.search.suggest.enabled" = true;
        "browser.urlbar.suggest.searches" = true;
        "extensions.webextensions.ExtensionStorageIDB.migrated.keepassxc-browser@keepassxc.org" = true;
        "media.eme.enabled" = true;
        "privacy.clearOnShutdown.cache" = false;
        "privacy.clearOnShutdown.cookies" = false;
        "privacy.clearOnShutdown.offlineApps" = false;
        "privacy.sanitize.sanitizeOnShutdown" = false;
        "browser.newtabpage.activity-stream.feeds.topsites" = true;
        "trailhead.firstrun.didSeeAboutWelcome" = true;
        "app.update.auto" = false;
        "browser.aboutConfig.showWarning" = false;
        "devtools.chrome.enabled" = true;
        "devtools.debugger.remote-enabled" = true;
        "gfx.webrender.all" = true;
        "gfx.webrender.enabled" = true;
        "svg.context-properties.content.enabled" = true;
        "layers.acceleration.force-enabled" = true;
        "layout.css.backdrop-filter.enabled" = true;
        "layout.css.has-selector.enabled" = true;
        "layout.css.moz-document.content.enabled" = true;
        "layout.css.moz-document.url-prefix-hack.enabled" = true;
        "layout.css.color-mix.enabled" = true;
        "extensions.pocket.enabled" = false;
        "findbar.highlightAll" = true;
        "media.ffmpeg.vaapi.enabled" = true;
      };

      extensions = with inputs.firefox-addons.packages."x86_64-linux"; [
        translate-web-pages
        ublock-origin
        decentraleyes
        sponsorblock
        youtube-shorts-block
        consent-o-matic
        darkreader
        keepassxc-browser
        #keepass-helper
      ];

      userChrome = builtins.readFile ./userChrome.css;
      userContent = builtins.readFile ./userContent.css;

      search = {
        force = true;
        default = "DuckDuckGo";
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
                    name = "channel";
                    value = "unstable";
                  }
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = ["@n"];
          };
          "Flathub" = {
            urls = [{
              template = "https://flathub.org/apps/search";
              params = [{
                name = "q";
                value = "{searchTerms}";
              }];
            }];
            definedAliases = ["@flathub" "@fh"];
          };
          "Wikipedia (en)".metaData.hidden = true;
        };
      };
    };
  };
  
  home.activation = {
    librefoxActivation = lib.hm.dag.entryAfter ["writeBoundary"]
    ''
      #!/usr/bin/env bash
      #idk
    '';
  };
}
