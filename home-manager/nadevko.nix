{ pkgs, config, ... }: {
  home = {
    sessionVariables = {
      MOZ_ENABLE_WAYLAND = "1";
      EDITOR = "vim";
      TEXMFHOME = "/home/nadevko/Стол/texmf";
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
      historyFile = "\${XDG_CACHE_HOME:=$HOME/.cache}/bash_history";
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
      package =
        pkgs.firefox.override { cfg = { enableGnomeExtensions = true; }; };
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
    mangohud.enable = true;
  };
  services = {
    gpg-agent = {
      enable = true;
      pinentryFlavor = "gnome3";
    };
  };
}
