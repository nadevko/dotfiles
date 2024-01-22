{
  afterends = ''
    Make Ctrl+Right and Ctrl+Delete stop at word ends instead of beginnings.
  '';
  allow_insecure_backup = ''
    When backing up files, allow the backup to succeed even if its permissions
    can't be (re)set due to special OS considerations. You should NOT enable
    this option unless you are sure you need it.
  '';
  atblanks = ''
    When soft line wrapping is enabled, make it wrap lines at blank characters
    (tabs and spaces) instead of always at the edge of the screen.
  '';
  autoindent = ''
    Automatically indent a newly created line to the same number of tabs and/or
    spaces as the previous line (or as the next line if the previous line is the
    beginning of a paragraph).
  '';
  backup = ''
    When saving a file, create a backup file by adding a tilde (~) to the file's
    name.
  '';
  boldtext = ''
    Use bold instead of reverse video for the title bar, status bar, key combos,
    function tags, line numbers, and selected text. This can be overridden by
    setting the options titlecolor, statuscolor, keycolor, functioncolor,
    numbercolor, and selectedcolor.
  '';
  bookstyle = ''
    When justifying, treat any line that starts with whitespace as the beginning
    of a paragraph (unless auto-indenting is on).
  '';
  breaklonglines = ''
    Automatically hard-wrap the current line when it becomes overlong.
  '';
  casesensitive = ''
    Do case-sensitive searches by default.
  '';
  constantshow = ''
    Constantly display the cursor position in the status bar. This overrides the
    option quickblank.
  '';
  cutfromcursor = ''
    Use cut-from-cursor-to-end-of-line by default, instead of cutting the whole
    line.
  '';
  emptyline = ''
    Do not use the line below the title bar, leaving it entirely blank.
  '';
  historylog = ''
    Save the last hundred search strings and replacement strings and executed
    commands, so they can be easily reused in later sessions.
  '';
  indicator = ''
    Display a "scrollbar" on the righthand side of the edit window. It shows the
    position of the viewport in the buffer and how much of the buffer is covered
    by the viewport.
  '';
  jumpyscrolling = ''
    Scroll the buffer contents per half-screen instead of per line.
  '';
  linenumbers = ''
    Display line numbers to the left of the text area. (Any line with an anchor
    additionally gets a mark in the margin)
  '';
  locking = ''
    Enable vim-style lock-files for when editing files.
  '';
  magic = ''
    When neither the file's name nor its first line give a clue, try using
    libmagic to determine the applicable syntax. (Calling libmagic can be
    relatively time consuming. It is therefore not done by default)
  '';
  minibar = ''
    Suppress the titlebar and instead show information about the current buffer
    at the bottom of the screen, in the space for the status bar. In this
    "minibar" the filename is shown on the left, followed by an asterisk if the
    buffer has been modified. On the right are displayed the current line and
    column number, the code of the character under the cursor (in Unicode
    format: U+xxxx), the same flags as are shown by set state flags, and a
    percentage that expresses how far the cursor is into the file (linewise).
    When a file is loaded or saved, and also when switching between buffers, the
    number of lines in the buffer is displayed after the filename. This number
    is cleared upon the next keystroke, or replaced with an [i/n] counter when
    multiple buffers are open. The line plus column numbers and the character
    code are displayed only when set constantshow is used, and can be toggled on
    and off with M-C. The state flags are displayed only when set stateflags is
    used.
  '';
  mouse = ''
    Enable mouse support, if available for your system. When enabled, mouse
    clicks can be used to place the cursor, set the mark (with a double click),
    and execute shortcuts. The mouse will work in the X WindowSystem, and on the
    console when gpm is running. Text can still be selected through dragging by
    holding down the Shift key.
  '';
  multibuffer = ''
    When reading in a file with ^R, insert it into a new buffer by default.
  '';
  noconvert = ''
    Don't convert files from DOS/Mac format.
  '';
  nohelp = ''
    Don't display the two help lines at the bottom of the screen.
  '';
  nonewlines = ''
    Don't automatically add a newline when a text does not end with one. (This
    can cause you to save non-POSIX text files)
  '';
  positionlog = ''
    Save the cursor position of files between editing sessions. The cursor
    position is remembered for the 200 most-recently edited files.
  '';
  preserve = ''
    Preserve the XON and XOFF keys (^Q and ^S).
  '';
  quickblank = ''
    Make status-bar messages disappear after 1 keystroke instead of after 20.
    Note that option constantshow overrides this. When option minibar or zero is
    in effect, quickblank makes a message disappear after 0.8 seconds instead
    of after the default 1.5 seconds.
  '';
  rawsequences = ''
    Interpret escape sequences directly, instead of asking ncurses to translate
    them. (If you need this option to get some keys to work properly, it means
    that the terminfo terminal description that is used does not fully match the
    actual behavior of your terminal. This can happen when you ssh into a BSD
    machine, for example) Using this option disables nano's mouse support.
  '';
  rebinddelete = ''
    Interpret the Delete and Backspace keys differently so that both Backspace
    and Delete work properly. You should only use this option when on your
    system either Backspace acts like Delete or Delete acts like Backspace.
  '';
  regexp = ''
    Do regular-expression searches by default. Regular expressions in nano are
    of the extended type (ERE).
  '';
  saveonexit = ''
    Save a changed buffer automatically on exit (^X); don't prompt.
  '';
  showcursor = ''
    Put the cursor on the highlighted item in the file browser, and show the
    cursor in the help viewer, to aid braille users and people with poor vision.
  '';
  smarthome = ''
    Make the Home key smarter. When Home is pressed anywhere but at the very
    beginning of non-whitespace characters on a line, the cursor will jump to
    that beginning (either forwards or backwards). If the cursor is already at
    that position, it will jump to the true beginning of the line.
  '';
  softwrap = ''
    Display lines that exceed the screen's width over multiple screen lines.
    (You can make this soft-wrapping occur at whitespace instead of rudely at
    the screen's edge, by using also set atblanks)
  '';
  stateflags = ''
    Use the top-right corner of the screen for showing some state flags: I
    auto-indenting, M when the mark is on, L when hard-wrapping (breaking long
    lines), R when recording a macro, and S when soft-wrapping. When the buffer
    is modified, a star (*) is shown after the filename in the center of the
    title bar.
  '';
  tabstospaces = ''
    Convert each typed tab to spaces -- to the number of spaces that a tab at
    that position would take up.
  '';
  trimblanks = ''
    Remove trailing whitespace from wrapped lines when automatic hard-wrapping
    occurs or when text is justified.
  '';
  unix = ''
    Save a file by default in Unix format. This overrides nano's default
    behavior of saving a file in the format that it had. (This option has no
    effect when you also use set noconvert)
  '';
  wordbounds = ''
    Detect word boundaries differently by treating punctuation characters as
    parts of words.
  '';
  zap = ''
    Let an unmodified Backspace or Delete erase the marked region (instead of a
    single character, and without affecting the cutbuffer).
  '';
  zero = ''
    Hide all elements of the interface (title bar, status bar, and help lines)
    and use all rows of the terminal for showing the contents of the buffer. The
    status bar appears only when there is a significant message, and disappears
    after 1.5 seconds or upon the next keystroke. With M-Z the title bar plus
    status bar can be toggled. With M-X the help lines.
  '';
}
