{ pkgs, config, ... }: {
  home = {
    sessionVariables = {
      MOZ_ENABLE_WAYLAND = "1";
      EDITOR = "vim";
      TEXMFHOME = "${config.xdg.configHome}/texmf";
    };
    stateVersion = "23.05";
  };
  fonts.fontconfig.enable = true;
  programs = {
    git = {
      enable = true;
      aliases = {
        ll =
          "log --graph --branches --left-right --format='%C(blue)%h (%C(cyan)%G?%C(blue)) %C(bold yellow)%s%C(green)%d%C(reset)%n%aN <%aE> %C(white)%ad%-n%-b'";
        ls =
          "log --format='%C(bold)%m %C(reset blue)%h (%C(cyan)%G?%C(blue)) %C(bold yellow)%s%C(green)%d%C(reset bold) %aN %C(reset white)(%ad)'";
        ss = "status --short --branch";
        nn = "checkout";
        cc = "commit";
        ca = "commit --amend";
        rr = "rebase";
        mm = "merge";
        rs = "restore --staged";
      };
      extraConfig = {
        rebase = {
          stat = true;
          autoSquash = true;
          autoStash = true;
          missingCommitsCheck = "warn";
          abbreviateCommands = true;
          rescheduleFailedExec = true;
        };
        merge = {
          tool = "vimdiff";
          conflictstyle = "diff3";
        };
        push.default = "upstream";
        init.defaultBranch = "master";
        log.date = "human";
        column.status = "always";
        help.autocorrect = 3;
        credential.helper = "cache --timeout=600";
        rerere.enabled = true;
      };
    };
    bash = {
      enable = true;
      enableCompletion = true;
      historyControl = [ "ignoredups" "ignorespace" ];
      historyFile = "${config.xdg.cacheHome}/bash_history";
      historySize = 2048;
      shellOptions = [
        "globstar"
        "histappend"
        "histverify"
        "autocd"
        "cdspell"
        "dirspell"
        "checkhash"
        "checkjobs"
        "assoc_expand_once"
        "gnu_errfmt"
        "xpg_echo"
        "progcomp_alias"
        "extdebug"
        "-force_fignore"
      ];
    };
    firefox = {
      enable = true;
      package = pkgs.firefox.override {
        cfg = {
          enableGnomeExtensions = true;
          speechSynthesisSupport = true;
        };
      };
    };
    vscode = {
      enable = true;
      package = pkgs.vscodium;
    };
    gpg = {
      enable = true;
      homedir = "${config.xdg.dataHome}/gnupg";
    };
    direnv = {
      config.global = {
        disable_stdin = true;
        load_dotenv = true;
      };
      enable = true;
      enableBashIntegration = true;
    };
    nano = {
      enable = true;
      extraConfig = ''
        ## GNU nano (5.8) initialization file
        ## Copyright 2019, 2021 nadevko
        ## Distributed under terms of GPLv3 or later

        ##  1. Coloring
        ##    1. Nano color scheme
        ##    2. Include external syntax schemes
        ##    3. User specific extendsyntax
        ##  2. Options
        ##    1. User interface
        ##    2. User experience
        ##    3. Content analysis
        ##    4. Lines
        ##    5. File saving, backups and security
        ##  3. Keybinding
        ##    1. Meta
        ##    2. Undo copypasta
        ##    3. Removal & insertion
        ##    4. Advanched movement, search and replace
        ##    5. Search flips
        ##    6. Work with files
        ##    7. Text formatting
        ##    8. Basics
        ##  4. Special use
        ##    1. Accessibility
        ##    2. Unrecommended
        ##    3. Troubleshooting
        ##    4. Deprecated
        ##                          Read `man 5 nanorc` for full and actual description



        ### 1 COLORING
        ## set <itemname>color [bold,][italic,]<fg colorname>,<bg colorname>
        ##  Colornames:
        ##    May be prefixed with light to get the lighter version:
        ##      red, green, blue, magenta, yellow, cyan, while, black
        ##    Can't be prefixed:
        ##      pink, purple, mauve, lagoon, mint, lime, peach, orange, latte, normal
        ## include <path>

        ### 1 1 ### Nano color scheme
        ## Title bar
        #set titlecolor [bold,][italic,]fgcolor,bgcolor
        ## Status bar
        #set statuscolor [bold,][italic,]fgcolor,bgcolor
        ## Selected text
        #set selectedcolor [bold,][italic,]fgcolor,bgcolor
        ## Promt
        #set promptcolor [bold,][italic,]fgcolor,bgcolor
        ## Search match
        #set spotlightcolor [bold,][italic,]fgcolor,bgcolor
        ## Strike-limiter
        #set stripecolor [bold,][italic,]fgcolor,bgcolor
        ## Help description
        #set functioncolor [bold,][italic,]fgcolor,bgcolor
        ## Help keys
        #set keycolor [bold,][italic,]fgcolor,bgcolor
        ## Scrollbar
        #set scrollercolor fgcolor,bgcolor
        ## Status bar error
        #set errorcolor [bold,][italic,]fgcolor,bgcolor
        ## Line numbers
        #set numbercolor [bold,][italic,]fgcolor,bgcolor

        ### 1 2 ### Include external syntax schemes
        ## System-wide syntax
        include /usr/share/nano/*
        ## In some distros, there are uncommon syntaxes
        #include /usr/share/nano/extra/*
        ## User-specific syntax
        include ~/.config/nano/syntax/*

        ## 1 3 ### User specific extendsyntax
        ## You know what you wan't to do



        ### 2 OPTIONS
        ## set <option> "[value]"
        ## unset <options>
        ##
        ## All options unset by default.
        ## Shell-like character escaping doesn't recuired
        ## Quotation marks in value doesn't break it

        ### 2 1 ### User interface
        ## Don't display two help lines at bottom of screen
        set nohelp
        ## Cute alternative status bar at bottom of screen
        set minibar
        ## Line numbering
        set linenumbers
        ## Scrollbar on the right window edge
        #set indicator
        ## State flags on the status bar:
        ## L - hard-wrap   * - file modified     M - mark on
        ## S - soft-wrap   R - macro recording
        set stateflags
        ## Vertical stripe-limiter at the given column
        set guidestripe 80
        ## Display the cursor position in the status bar
        set constantshow
        ## Do not use first line
        #set emptyline
        ## Old school bold instead beautiful reverse video
        #set boldtext
        ## Disappear messages after 1 keystroke
        set quickblank

        ### 2 2 ### User experience
        ## Save file on exit without promting
        #set saveonexit
        ## Regex search by defaut
        #set regexp
        ## Enable multibuffer mode
        #set multibuffer
        ## Remember cursor position between sessions
        set positionlog
        ## Remember search/replace history between sessions
        set historylog
        ## Cut-from-cursor-to-end-of-line
        set cutfromcursor
        ## Allow delete all marked region in one keystroke
        set zap
        ## Scroll the buffer half-screen instead of per line
        #set jumpyscrolling
        ## Do case-sensitive searches by default
        #set casesensitive
        ## Enable xorg mouse support
        set mouse
        ## Stop 'nextword' and 'chopwordright' at word end instead of beginning.
        set afterends
        ## Jump to start of text instead of true line start
        set smarthome
        ## Tab character size
        set tabsize 4
        ## Print spaces via tab key
        set tabstospaces
        ## Call external spell checker
        #set speller "aspell -x -c"
        ## Allow nano to be suspended
        #set suspendable

        ## 2 3 ### Content analysis
        ## Treat lines with leading whitespace as beginning of paragraph
        #set bookstyle
        ## Find quotes with regex
        #set quotestr "regex"
        ## Paragraph closing characters
        #set punct "characters"
        ## Include punctuation signs in word boundaries
        #set wordbounds
        ## Specify non-alphabetical characters, which should be included in
        ## word boundaries
        #set wordchars "characters"
        ## Specify brackets pairs for search
        #set matchbrackets "characters"
        ## The characters treated as closing brackets at paragraph justifying
        #set brackets "characters"

        ### 2 4 ### Lines
        ## Indent new line to same number of tabs/spaces as previous line
        set autoindent
        ## Soft-wrap at tabs/spaces unstead of screen edge
        set atblanks
        ## Enable soft wrap
        set softwrap
        ## Enable hard wrap
        #set breaklonglines
        ## Autoremove extra spaces from hard-wrapped lines
        set trimblanks
        ## Automatic line hard-wrapping at certain column
        ## If 0 or less - the width of the screen minus X columns
        set fill 80

        ### 2 5 ### File saving, backups and security
        ## Limit nano access to <value> directory
        #set operatingdir "directory"
        ## Don't add automatic blank POSIX line at end of file
        #set nonewlines
        ## Force save files in unix format
        #set unix
        ## Don't convert files from DOS/Mac format
        #set noconvert
        ## Two character, used for indicating presence of tabs and spaces:
        ## UTF-8 - "»⋅" Other - ">."
        #set whitespace "characters"
        ## Preserve the XON (^Q) and XOFF (^S) keys
        #set preserve
        ## Vim-style lock-files
        #set locking
        ## Enable backups
        set backup
        ## Backup to specific directory instead of "~filename"
        set backupdir ~/.cache/nano



        ### 3 KEYBINDINGS
        ## bind "" function menu
        ##
        ## Please don't use: ^H (May not work everywhere), ^M (enter), ^I (tab key)
        ## Can't be used: ^[ (esc), the arrows, home, end, pageup, pagedown

        ### 3 1 ### Meta
        ## Exit from nano/help/file browser
        bind ^Q exit all
        ## Invoke help screen
        bind F1 help all
        ## Cancel current action
        bind F2 cancel all
        ## Suspend editor
        bind ^Z suspend all
        ## Report cursor location
        #bind "" location main
        ## Report number of words, characters and lines
        bind ^P wordcount main
        ## Refresh the screen
        bind F5 refresh all
        ## Switch to next buffer
        #bind "" nextbuf
        ## Switch to previous buffer
        #bind "" prevbuf
        ## Execute shell program and paste output in current buffer
        bind ^R execute main

        ### 3 2 ### Undo copypasta
        ## Select text
        bind ^T mark all
        ## Cut mark/line
        bind ^X cut main
        ## Copy mark/line
        bind ^C copy main
        ## Paste mark/line
        bind ^V paste main
        ## Zap key
        bind ^K zap main
        ## Redo action
        bind ^Y redo main
        ## Undo action
        bind ^U undo main

        ### 3 3 ### Removal & insertion
        ## Delete under cursor
        #bind "" delete main
        ## Delete the character before the cursor
        #bind "" backspace all
        ## Insert tab
        #bind "" tab main
        ## Insert newline
        #bind "" enter main
        ## Delete from the cursor to the beginning of word
        #bind "" chopwordleft main
        ## Delete from the cursor to the beginning of next word
        #bind "" chopwordright main
        ## Cut from the cursor to the end of file
        #bind "" cutrestoffile main
        ## Record actions
        bind F9 recordmacro main
        ## Replay macro
        bind F10 runmacro main

        ### 3 4 ### Advanched movement, search and replace
        ## Forward search
        bind ^F whereis all
        ## Backward search
        bind ^B wherewas all
        ## Show next occurrence
        bind ^G findnext all
        ## Show previous occurrence
        bind ^D findprevious all
        ## Interactive replace
        bind ^P replace all
        ## Go to specific line
        bind ^L gotoline all
        ## Go to pair bracket
        #bind "" findbracket all
        ## Un/place ancor on the line
        bind F7 anchor all
        ## Go to next anchor
        bind F8 nextanchor all
        ## Go to previous anchor
        bind F6 prevanchor all

        ### 3 5 ### Search flips
        ## Toggle case sensitivity
        #bind "" casesens all
        ## Toggle regexp
        bind ^R regexp search
        ## Toggle forward/backward
        #bind "" backwards all
        ## Flip to replace
        #bind "" flipreplace search
        ## Flip to targeting a line number
        #bind "" flipgoto search
        ## Flip to command executing
        #bind "" flipexecute search
        ## Like flipexecute, but pipe buffer/mark to command
        #bind "" flippipe search
        ## Flip to new empty buffer insert
        #bind "" flipnewbuffer search
        ## Flip to not converting to unix format at file reading
        #bind "" flipconvert search

        ### 3 6 ### Work with files
        ## Write file with promting
        bind ^W writeout main
        ## Write file quietly
        bind ^S savefile main
        ## Open file in the current/new(if multibuffer on) buffer
        bind ^O insert all
        ## Switch to dos format at writing
        bind ^D dosformat writeout
        ## Switch to mac format at writing
        bind ^T macformat writeout
        ## Append to the first line of file at writing
        bind ^D append writeout
        ## Append to the end of file at writing
        bind ^G prepend writeout
        ## Invoke file browser
        bind ^E browser all
        ## Go to specific directory
        bind ^O gotodir browser
        ## Go to first file at list
        bind ^D firstfile browser
        ## Go to last file at list
        bind ^G lastfile browser

        ### 3 6 ### Toggle features
        ## Help lines
        bind F12 nohelp all
        ## Cursor position displaying
        #bind "" constantshow all
        ## Soft wrap
        bind F11 softwrap all
        ## Hard wrap
        #bind "" breaklonglines all
        ## Line numbering
        #bind "" linenumbers all
        ## Whitespaces highlight
        #bind "" whitespacedisplay all
        ## Syntax highlight
        #bind "" nosyntax all
        ## Home key behavior
        #bind "" smarthome all
        ## Autoindent
        #bind "" autoindent all
        ## Cut-from-cursor/full line
        #bind "" cutfromcursor all
        ## Tab to spaces converting
        #bind "" tabtospaces all
        ## Mouse support
        #bind "" mouse all
        ## Suspend support
        #bind "" suspendable all

        ### 3 7 ### Text formatting
        ## Autocomplete using words finded elsewere in the buffer
        bind ^/ complete main
        ## (Un)comment current line
        bind F4 comment main
        ## Invoke spell checker
        bind F3 speller main
        ## Invoke full-buffer-processor
        #bind "" formatter main
        ## Invoke syntax checker
        #bind "" linter main
        ## Justify current paragraph
        #bind "" justify main
        ## Justify enture buffer
        #bind "" fulljustify main
        ## Shift to the right
        #bind "" indent main
        ## Shift to the left
        #bind "" unindent main
        ## Next keystroke verbatim
        #bind "" verbatim main

        ### 3 8 ### Basics
        ## One line up
        #bind "" up all
        ## One line down
        #bind "" down all
        ## One character right
        #bind "" right all
        ## One character left
        #bind "" left all
        ## Up, but save cursor position
        #bind "" scrollup all
        ## Down, but save cursor position
        #bind "" scrolldown all
        ## Center cursor position in the middle of the screen
        #bind "" center all
        ## To the beginning of the next word
        #bind "" nextword all
        ## To the beginning of the previous word
        #bind "" prevword all
        ## To the beginning of the line
        #bind "" home all
        ## To the end of the line
        #bind "" end all
        ## To the beginning of the paragraph
        #bind "" beginpara all
        ## To the end of the paragraph
        #bind "" endpara all
        ## To the next block of text
        #bind "" nextblock all
        ## To the previous block of text
        #bind "" nextblock all
        ## One screen up
        #bind "" pageup all
        ## One screen down
        #bind "" pagedown all
        ## To the first line of the file
        #bind "" firstline all
        ## To the last line of the file
        #bind "" lastline all



        ### 4 SPECIAL USE
        ### 4 1 ### Accessibility
        ## Braille users aid
        #set showcursor

        ### 4 2 ### Unrecommended
        ## Determine file syntax using libmagic
        #set magic
        ## Force backup
        #set allow_insecure_backup

        ### 4 3 ### Troubleshooting
        ## Enable if Delete and Backspace suddenly switched places
        #set rebinddelete
        ## Enable this option if keyboard doesn't work correctly
        #set rawsequences

        ### 4 4 ### Deprecated
        ## Use 'bind "" location all'
        #bind "" curpos main
        ## Use 'bind "" suspendable all'
        #bind "" suspendenable
        ## Use "unset emptyline"
        #set morespace
        ## Use "unset breaklonglines"
        #set nowrap
        ## Use "unset jumpyscrolling"
        #set smooth
        ## Use "set saveonexit"
        #set tempfile
        ## Ignored
        #set nopauses
      '';
    };
  };
  services = {
    gpg-agent = {
      enable = true;
      pinentryFlavor = "gnome3";
    };
  };
  xdg.configFile."texmf/tex/xelatex/bsuir-report.cls".source =
    ./config/texmf/tex/xelatex/bsuir-report.cls;
}
