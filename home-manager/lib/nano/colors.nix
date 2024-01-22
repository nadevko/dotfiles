{
  errorcolor = ''
    Use this color combination for the status bar when an error message is
    displayed. The default value is bold,white,red. See set titlecolor for valid
    color names.
  '';
  functioncolor = ''
    Use this color combination for the concise function descriptions in the two
    help lines at the bottom of the screen. See set titlecolor for more details.
  '';
  keycolor = ''
    Use this color combination for the shortcut key combos in the two help lines
    at the bottom of the screen. See set titlecolor for more details.
  '';
  minicolor = ''
    Use this color combination for the minibar. (When this option is not
    specified, the colors of the title bar are used)See set titlecolor for more
    details.
  '';
  numbercolor = ''
    Use this color combination for line numbers. See set titlecolor for more
    details.
  '';
  promptcolor = ''
    Use this color combination for the prompt bar. (When this option is not
    specified, the colors of the title bar are used)See set titlecolor for more
    details.
  '';
  scrollercolor = ''
    Use this color combination for the indicator alias "scrollbar". (On terminal
    emulators that link to a libvte older than version 0. 55, using a background
    color here does not work correctly)See set titlecolor for more
    details.
  '';
  selectedcolor = ''
    Use this color combination for selected text. See set titlecolor for more
    details.
  '';
  spotlightcolor = ''
    Use this color combination for highlighting a search match. The default
    value is black,lightyellow. See set titlecolor for valid color names.
  '';
  statuscolor = ''
    Use this color combination for the status bar. See set titlecolor for more
    details.
  '';
  stripecolor = ''
    Use this color combination for the vertical guiding stripe. See set
    titlecolor for more details.
  '';
  titlecolor = ''
    Use this color combination for the title bar. Valid names for the foreground
    and background colors are: red, green, blue, magenta, yellow, cyan, white,
    and black. Each of these eight names may be prefixed with the word light to
    get a brighter version of that color. The word grey or gray may be used as a
    synonym for lightblack. On terminal emulators that can do at least 256
    colors, other valid (but unprefixable) color names are: pink, purple, mauve,
    lagoon, mint, lime, peach, orange, latte, rosy, beet, plum, sea, sky, slate,
    teal, sage, brown, ocher, sand, tawny, brick, crimson, and normal -- where
    normal means the default foreground or background color. On such emulators,
    the color may also be specified as a three-digit hexadecimal number prefixed
    with #, with the digits representing the amounts of red, green, and blue,
    respectively. This tells nano to select from the available palette the color
    that approximates the given values.

    Either "fgcolor" or ",bgcolor" may be left out, and the pair may be preceded
    by bold and/or italic (separated by commas) to get a bold and/or slanting
    typeface, if your terminal can do those.
  '';
}
