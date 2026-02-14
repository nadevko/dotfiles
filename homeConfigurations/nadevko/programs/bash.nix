{ config, ... }:
{
  programs.bash = {
    enable = true;
    enableCompletion = true;
    enableVteIntegration = true;
    historyControl = [
      "ignoredups"
      "ignorespace"
    ];
    historyFile = config.xdg.cacheHome + "/bash_history";
    historyFileSize = 1024 * 1024;
    historySize = 1024 * 32;
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
      "-force_fignore"
    ];
  };
  programs.readline = {
    enable = true;
    bindings = {
      "\\t" = "menu-complete";
      "\\e[Z" = "menu-complete-backward";
    };
    variables = {
      show-all-if-ambiguous = "on";
      menu-complete-display-prefix = "on";
      colored-stats = "on";
      colored-completion-prefix = "on";
      mark-directories = "on";
      mark-symlinked-directories = "on";
      page-completions = "on";
      visible-stats = "on";
      completion-query-items = "128";
      completion-ignore-case = "on";
      history-preserve-point = "on";
      bell-style = "none";
      completion-map-case = "on";
    };
  };
  programs = {
    oh-my-posh = {
      enable = true;
      enableBashIntegration = true;
      useTheme = "ys";
    };
    fzf = {
      enable = true;
      enableBashIntegration = true;
    };
    git-worktree-switcher.enableBashIntegration = true;
    direnv.enableBashIntegration = true;
  };
}
