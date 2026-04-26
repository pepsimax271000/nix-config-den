{ config, inputs, pkgs, host, ...}:
{
  imports = [
    inputs.zen-browser.homeModules.beta
  ];

  programs.zen-browser = {
    enable = true;
    nativeMessagingHosts = [pkgs.firefoxpwa];
    profiles.default = {
      settings = {
        zen = {
          zen.view.compact.enable-at-startup =	true;
          zen.view.compact.hide-tabbar =	false;
          zen.view.compact.hide-toolbar =	true;
          zen.view.compact.should-enable-at-startup =	false;
          zen.view.sidebar-expanded =	false;
          zen.view.use-single-toolbar =	false;
          zen.welcome-screen.seen = true;
        };
      };
      search = {
        force = true;
        default = "searx";
        engines = {
          searx = {
            name = "Searx Tiekoetter";
            urls = [
              {
                template = "https://searx.tiekoetter.com/search?q={searchTerms}";
                params = [
                  {
                    name = "query";
                    value = "searchTerms";
                  }
                ];
              }
            ];
          };
        };
      };
      mods = [
        "c6813222-6571-4ba6-8faf-58f3343324f6"
      ];
      extensions.packages = 
        with inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system}; [
          ublock-origin
          bitwarden
          tridactyl
          stylus
          sponsorblock
        ];
      };
    policies = {
      AutofillAddressEnabled = true;
      AutofillCreditCardEnabled = false;
      DisableAppUpdate = true;
      DisableFeedbackCommands = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DisableTelemetry = true;
      DontCheckDefaultBrowser = true;
      NoDefaultBookmarks = true;
      OfferToSaveLogins = false;
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };
    };
  };
  stylix.targets.zen-browser.profileNames = [ "default" ];
}
