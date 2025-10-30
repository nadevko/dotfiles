{ inputs, pkgs, ... }:
let
  gnomeTheme = inputs.self.packages.${pkgs.system}.firefox-gnome-theme.override {
    hideSingleTab = true;
    bookmarksToolbarUnderTabs = true;
    allTabsButtonOnOverflow = true;
  };
in
{
  programs.firefox.profiles.master = {
    userChrome = ''
      @import "${gnomeTheme}/lib/firefox/chrome/userChrome.css";
    '';
    userContent = ''
      @import "${gnomeTheme}/lib/firefox/chrome/userContent.css";
    '';
    extraConfig =
      builtins.readFile "${gnomeTheme}/lib/firefox/user.js"
      + builtins.readFile "${gnomeTheme.userjs}/lib/firefox/user.js";
  };
}
