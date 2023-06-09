{ pkgs, ff-addons }:
{
  isDefault = true;
  userChrome = builtins.readFile ./userChrome.css;
  extensions = with ff-addons; [
    darkreader
    sidebery
    sponsorblock
    stylus
    tampermonkey
    temporary-containers
    ublock-origin
  ];
  search = {
    default = "DuckDuckGo";
    engines = {
      "Bing".metaData.hidden = true;
      "Google".metaData.alias = "@g";
      "DuckDuckGo".metaData.alias = "@ddg";

      "discord.py" = let version = "latest"; in {
        urls = [{
          template = "https://discordpy.readthedocs.io/en/${version}/search.html?q={searchTerms}";
        }];
        definedAliases = [ "@dpy" ];
      };

      "Library Genesis" = {
        urls = [
          { template = "https://libgen.rs/search.php?req={searchTerms}"; } # non-fiction
          { template = "https://libgen.rs/fiction/?q={searchTerms}"; } # fiction
          { template = "https://libgen.rs/scimag/?q={searchTerms}"; } # scientific articles
          { template = "https://magzdb.org/makelist?t={searchTerms}"; } # magazines
        ];
        definedAliases = [ "@libgen" ];
      };

      "Nix" = {
        urls = [{ template = "https://mynixos.com/search?q={searchTerms}"; }];
        iconUpdateURL = "https://mynixos.com/favicon.ico";
        definedAliases = [ "@nix" ];
      };

      "Nix Packages" = {
        urls = [{
          template = "https://search.nixos.org/packages";
          params = [
            { name = "channel"; value = "unstable"; }
            { name = "query"; value = "{searchTerms}"; }
            { name = "type"; value = "packages"; }
          ];
        }];

        icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
        definedAliases = [ "@np" ];
      };

      "NixOS Wiki" = {
        urls = [{ template = "https://nixos.wiki/index.php?search={searchTerms}"; }];
        iconUpdateURL = "https://nixos.wiki/favicon.png";
        updateInterval = 24 * 60 * 60 * 1000; # every day
        definedAliases = [ "@nw" ];
      };

      "Source Graph" = {
        urls = [{
          template = "https://sourcegraph.com/search";
          params = [
            { name = "q"; value = "context:@maan2003/nix {searchTerms}"; }
            { name = "groupBy"; value = "repo"; }
          ];
        }];
        definedAliases = [ "@sg" ];
      };
    };
    force = true;
    order = [
      "DuckDuckGo"
      "Google"
    ];
  };

  bookmarks = [
    {
      name = "profiles";
      bookmarks = [
        { name = "GitHub"; url = "https://github.com/GetPsyched"; }
        { name = "LeetCode"; url = "https://leetcode.com/GetPsyched"; }
        { name = "LinkedIn"; url = "https://www.linkedin.com/in/priyanshutr"; }
      ];
      toolbar = true;
    }
    {
      name = "nksss";
      bookmarks =
        let
          base-url = "https://github.com/NIT-KKR-Student-Support-System";
          github = name: project: {
            inherit name;
            url = "${base-url}/${project}";
          };
        in
        [
          (github "gh-main" "")
          (github "gh-atlas" "atlas")
          (github "gh-breadboard" "breadboard")
          (github "gh-project-hyperlink" "project-hyperlink")
          (github "gh-website" "website")
          { name = "nkss-drive"; url = "https://drive.google.com/drive/folders/1U2taK5kEhOiUJi70ZkU2aBWY83uVuMmD"; }
          { name = "railway"; url = "https://railway.app/project/69531a0b-78b7-4a71-9df4-3a8db9703b69"; }
          { name = "design"; url = "https://www.figma.com/file/RbT3UiwKwbN71GwU8Zz5HS/NKSSS?node-id=321%3A154"; }
        ];
      toolbar = true;
    }
    {
      name = "discord.py";
      bookmarks = [
        { name = "repo"; url = "https://github.com/Rapptz/discord.py"; }
        { name = "bot"; url = "https://github.com/Rapptz/RoboDanny"; }
        {
          name = "docs";
          bookmarks =
            let
              base-url = "https://discordpy.readthedocs.io/en/latest";
            in
            [
              { name = "main"; url = "${base-url}/api.html"; }
              { name = "interactions"; url = "${base-url}/interactions/api.html"; }
              { name = "ext/commands"; url = "${base-url}/ext/commands/api.html"; }
              { name = "ext/tasks"; url = "${base-url}/ext/tasks/index.html"; }
            ];
        }
      ];
    }
    {
      name = "image-utils";
      bookmarks = [
        { name = "color-picker"; url = "https://imagecolorpicker.com"; }
        { name = "free-svgs"; url = "https://www.svgrepo.com"; }
        { name = "palette"; url = "https://www.hexcolortool.com"; }
      ];
    }
  ];

  settings = {
    # Dark mode
    "browser.theme.content-theme" = 0;
    "browser.theme.toolbar-theme" = 0;
    "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
    "layout.css.prefers-color-scheme.content-override" = 0;

    "browser.startup.page" = 3; # restore
    "distribution.searchplugins.defaultLocale" = "en-GB";
    "drm" = true;
    "general.useragent.locale" = "en-GB";
    "toolkit.legacyUserProfileCustomizations.stylesheets" = true;

    "browser.uidensity" = 1;

    # sidebery
    "sidebar.position_start" = false; # sidebar on right side
  };
}
