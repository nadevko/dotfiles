{ config, pkgs, ... }: {
  programs.nano = {
    enable = true;
    package = pkgs.nano.override {
      file = pkgs.file;
      gettext = pkgs.gettext;
      enableNls = true;
      enableTiny = false;
    };
    config = {
      afterends = true;
      allow_insecure_backup = false;
      atblanks = true;
      autoindent = true;
      backup = true;
      boldtext = false;
      bookstyle = false;
      breaklonglines = false;
      casesensitive = false;
      constantshow = true;
      cutfromcursor = false;
      emptyline = false;
      historylog = true;
      indicator = true;
      jumpyscrolling = false;
      linenumbers = true;
      locking = true;
      magic = true;
      minibar = true;
      mouse = true;
      multibuffer = true;
      noconvert = false;
      nohelp = true;
      nonewlines = false;
      positionlog = true;
      preserve = false;
      quickblank = false;
      rawsequences = false;
      rebinddelete = false;
      regexp = false;
      saveonexit = false;
      showcursor = false;
      smarthome = true;
      softwrap = true;
      stateflags = true;
      tabstospaces = false;
      trimblanks = true;
      unix = true;
      wordbounds = false;
      zap = true;
      zero = false;
      brackets = null;
      matchbrackets = null;
      punct = null;
      quotestr = null;
      speller = null;
      whitespace = null;
      wordchars = "$#@*&-+";
      fill = 120;
      guidestripe = 80;
      tabsize = 4;
      backupdir = config.xdg.cacheHome + "/nano";
      operatingdir = null;
    };
    bindings = [
      {
        key = "^Q";
        function = "exit";
        menu = "all";
      }
      {
        key = "M-E";
        function = "browser";
        menu = "all";
      }
      {
        key = "M-S";
        function = "suspend";
        menu = "all";
      }
      {
        key = "^Z";
        function = "undo";
        menu = "all";
      }
      {
        key = "^R";
        function = "redo";
        menu = "all";
      }
      {
        key = "^X";
        function = "cut";
        menu = "all";
      }
      {
        key = "^C";
        function = "copy";
        menu = "all";
      }
      {
        key = "^V";
        function = "paste";
        menu = "all";
      }
      {
        key = "^U";
        function = "cancel";
        menu = "all";
      }
      {
        key = "^O";
        function = "comment";
        menu = "main";
      }
      {
        key = "M-D";
        function = "prevanchor";
        menu = "main";
      }
      {
        key = "M-F";
        function = "anchor";
        menu = "main";
      }
      {
        key = "M-G";
        function = "nextanchor";
        menu = "main";
      }
      {
        key = "Sh-M-R";
        function = "recordmacro";
        menu = "main";
      }
      {
        key = "M-R";
        function = "runmacro";
        menu = "main";
      }
      {
        key = "M-H";
        function = "nohelp";
        menu = "all";
      }
      {
        key = "M-X";
        function = "execute";
        menu = "all";
      }
      {
        key = "^A";
        function = "mark";
        menu = "all";
      }
      {
        key = "^D";
        function = "findprevious";
        menu = "all";
      }
      {
        key = "^F";
        function = "whereis";
        menu = "all";
      }
      {
        key = "^B";
        function = "wherewas";
        menu = "all";
      }
      {
        key = "^G";
        function = "findnext";
        menu = "all";
      }
      {
        key = "^P";
        function = "replace";
        menu = "all";
      }
      {
        key = "^L";
        function = "gotoline";
        menu = "main";
      }
      {
        key = "^W";
        function = "writeout";
        menu = "main";
      }
      {
        key = "^S";
        function = "savefile";
        menu = "main";
      }
      {
        key = "M-D";
        function = "dosformat";
        menu = "writeout";
      }
      {
        key = "M-M";
        function = "macformat";
        menu = "writeout";
      }
      {
        key = "^G";
        function = "append";
        menu = "writeout";
      }
      {
        key = "^D";
        function = "prepend";
        menu = "writeout";
      }
      {
        key = "^O";
        function = "gotodir";
        menu = "browser";
      }
      {
        key = "^D";
        function = "firstfile";
        menu = "browser";
      }
      {
        key = "^G";
        function = "lastfile";
        menu = "browser";
      }
      {
        key = "^Space";
        function = "complete";
        menu = "main";
      }
      {
        key = "^I";
        function = "wordcount";
        menu = "main";
      }
    ];
    includes = [ config.programs.nano.package (import <dotfiles>).nanorc ];
  };
}
