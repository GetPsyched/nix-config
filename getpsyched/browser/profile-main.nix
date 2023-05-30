{ pkgs, ff-addons }:
let
  nksss-gh-url = "https://github.com/NIT-KKR-Student-Support-System";
  dpy-docs-url = "https://discordpy.readthedocs.io/en/latest";
  # https://nixos.org/guides/nix-pills/functions-and-imports.html
  # nksss-gh = { name, project }: {
  #   name = name;
  #   url = "${nksss-gh-url}/${project}";
  #   toolbar = true;
  # };
in
{
  isDefault = true;
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
      bookmarks = [
        # nksss-gh { name = "gh-main"; project = ""; }
        # nksss-gh "gh-main" "atlas"
        # nksss-gh "gh-main" "breadboard"
        # nksss-gh "gh-main" "project-hyperlink"
        # nksss-gh "gh-main" "website"
        { name = "gh-main"; url = "${nksss-gh-url}"; }
        { name = "gh-atlas"; url = "${nksss-gh-url}/atlas"; }
        { name = "gh-breadboard"; url = "${nksss-gh-url}/breadboard"; }
        { name = "gh-project-hyperlink"; url = "${nksss-gh-url}/project-hyperlink"; }
        { name = "gh-website"; url = "${nksss-gh-url}/website"; }
        { }
        { name = "nkss-drive"; url = "https://drive.google.com/drive/folders/1U2taK5kEhOiUJi70ZkU2aBWY83uVuMmD"; }
        { name = "railway"; url = "https://railway.app/project/69531a0b-78b7-4a71-9df4-3a8db9703b69"; }
        { name = "design"; url = "https://www.figma.com/file/RbT3UiwKwbN71GwU8Zz5HS/NKSSS?node-id=321%3A154"; }
      ];
    }
    {
      name = "discord.py";
      bookmarks = [
        { name = "main"; url = "${dpy-docs-url}/api.html"; }
        { name = "interactions"; url = "${dpy-docs-url}/interactions/api.html"; }
        { name = "ext/commands"; url = "${dpy-docs-url}/ext/commands/api.html"; }
        { name = "ext/tasks"; url = "${dpy-docs-url}/ext/tasks/index.html"; }
        { }
        { name = "repo"; url = "https://github.com/Rapptz/discord.py"; }
        { name = "bot"; url = "https://github.com/Rapptz/RoboDanny"; }
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

    "browser.startup.page" = 3; # restore
    "distribution.searchplugins.defaultLocale" = "en-GB";
    "drm" = true;
    "general.useragent.locale" = "en-GB";
  };
}
