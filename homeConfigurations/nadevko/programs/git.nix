{ pkgs, ... }:
let
  signers = [
    {
      condition = "hasconfig:remote.*.url:git@github.com:*/**";
      name = "Nadeŭka";
      email = "me@nadevko.cc";
      type = "ssh-ed25519";
      key = "AAAAC3NzaC1lZDI1NTE5AAAAIHEzzMRz9cg5om+U/KdUHiEqepyk8RCjuI/7YNa6VMVD";
    }
  ];
in
{
  programs.git = {
    enable = true;
    package = pkgs.git;
    lfs.enable = true;

    settings.alias = {
      a = "add --all";

      c = "commit";
      ca = "commit --amend --no-edit";
      caa = "commit --amend --no-edit --all";
      cm = "commit -m";

      l = "log --graph --branches --left-right --format='%C(blue)%h (%C(cyan)%G?%C(blue)) %C(bold yellow)%s%C(green)%d%C(reset)%n%aN <%aE> %C(white)%ad%-n%-b'";
      ls = "log --format='%C(bold)%m %C(reset blue)%h (%C(cyan)%G?%C(blue)) %C(bold yellow)%s%C(green)%d%C(reset bold) %aN %C(reset white)(%ad)'";

      n = "checkout";

      s = "status --short --branch";
    };

    settings = {
      user = {
        name = "Nadeŭka";
        email = "me@nadevko.cc";
      };
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
      push = {
        default = "upstream";
        autoSetupRemote = true;
      };
      gpg = {
        format = "ssh";
        ssh.allowedSignersFile = "${pkgs.writeText "allowed_signers" (
          builtins.foldl' (a: b: ''
            ${a}${b.email} ${b.type} ${b.key} ${b.name}
          '') "" signers
        )}";
      };
      init.defaultBranch = "master";
      log.date = "human";
      column.status = "always";
      help.autocorrect = 20;
      credential.helper = "cache --timeout=600";
      rerere.enabled = true;
    };

    includes = map (args: {
      inherit (args) condition;
      contents = {
        user = {
          inherit (args) name email;
          signingKey = "${args.type} ${args.key} ${args.name}";
        };
        commit.gpgSign = true;
        tag.gpgSign = true;
      };
    }) signers;
  };
  programs.gh = {
    enable = true;
    extensions = with pkgs; [
      gh-copilot
      gh-f
      gh-i
      gh-milestone
      gh-notify
      gh-poi
      gh-s
    ];
  };
  programs = {
    diff-highlight.enable = true;
    git-worktree-switcher.enable = true;
  };
}
