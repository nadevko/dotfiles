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
      };
      extraConfig = ''
        set guidestripe 80
        set tabsize 4
        set fill 80
        set backupdir ~/.cache/nano
        bind ^Q exit all
        bind F1 help all
        bind F2 cancel all
        bind ^Z suspend all
        bind ^P wordcount main
        bind F5 refresh all
        bind ^R execute main
        bind ^T mark all
        bind ^X cut main
        bind ^C copy main
        bind ^V paste main
        bind ^K zap main
        bind ^Y redo main
        bind ^U undo main
        bind F9 recordmacro main
        bind F10 runmacro main
        bind ^F whereis all
        bind ^B wherewas all
        bind ^G findnext all
        bind ^D findprevious all
        bind ^P replace all
        bind ^L gotoline all
        bind F7 anchor all
        bind F8 nextanchor all
        bind F6 prevanchor all
        bind ^R regexp search
        bind ^W writeout main
        bind ^S savefile main
        bind ^O insert all
        bind ^D dosformat writeout
        bind ^T macformat writeout
        bind ^D append writeout
        bind ^G prepend writeout
        bind ^E browser all
        bind ^O gotodir browser
        bind ^D firstfile browser
        bind ^G lastfile browser
        bind F12 nohelp all
        bind F11 softwrap all
        bind ^/ complete main
        bind F4 comment main
        bind F3 speller main
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
