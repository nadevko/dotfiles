{ pkgs, ... }:
{
  home.packages = with pkgs; [
    curlie
    # xq
    usql
    entr
    code-cursor
  ];

  programs = {
    direnv = {
      enable = true;
      config.global = {
        disable_stdin = true;
        load_dotenv = true;
      };
      nix-direnv.enable = true;
    };
    ripgrep = {
      enable = true;
      arguments = [ "--smart-case" ];
    };
    ripgrep-all.enable = true;
    jq.enable = true;
  };
}
