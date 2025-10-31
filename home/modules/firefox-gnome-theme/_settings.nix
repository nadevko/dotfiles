{
  hideSingleTab = ''
    Hide the tab bar when only one tab is open.

      **Note**: You should move the new tab button out of the tabbar or it will be hidden when there is only one tab. You can rearrange the toolbars doing a right-click on any toolbar and selecting "Customize Toolbar…".
  '';
  normalWidthTabs = "Use normal width tabs as default Firefox.";
  swapTabClose = "By default the tab close buttons follows the position of the window controls, this preference reverts that behavior.";
  bookmarksToolbarUnderTabs = "Move Bookmarks toolbar under tabs.";
  activeTabContrast = "Add more contrast to the active tab.";
  closeOnlySelectedTabs = "Show the close button on the selected tab only.";
  systemIcons = ''
    Use system theme icons instead of Adwaita icons included by theme.

    **Note**: This feature has a [known color bug](https://github.com/rafaelmardojai/firefox-gnome-theme#icons-color-broken-with-system-icons).
  '';
  noThemedIcons = "Use default Firefox icons instead of the included icons.";
  symbolicTabIcons = "Make all tab icons look kinda like symbolic icons.";
  hideWebrtcIndicator = "Hide redundant WebRTC indicator since GNOME provides their own privacy icons in the top right.";
  hideUnifiedExtensions = "Hide unified extensions button from the navbar, you can also use `extensions.unifiedExtensions.enabled` instead, which is only going to work till Firefox 111.";
  dragWindowHeaderbarButtons = ''
    Allow dragging the window from headerbar buttons.

      **Note**: This feature is BUGGED. It can activate the button with unpleasant behavior.
  '';
  tabsAsHeaderbar = ''
    Place the tabs on the top of the window, and use the tabs bar to hold the window controls, like Firefox's standard tab bar.

      **Note**: Enabling with `gnomeTheme.hideSingleTab` will replace the single tab with a title bar.
  '';
  oledBlack = "Change the dark theme into the black variant.";
  allTabsButtonOnOverflow = "Show the `List All Tabs` button when the tabs bar is overflowing (when you have too many tabs that the width of the tabs no longer shrinks when new tabs are added).";
  allTabsButton = "Show the `List All Tabs` button all the time, like stock Firefox.";
  tabAlignLeft = "Align the tab title and favicon to left of tab in place of center.";
  bookmarksOnFullscreen = "Show the bookmarks bar while in fullscreen.";
}
