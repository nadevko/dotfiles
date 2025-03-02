{ inputs, pkgs, ... }:
let
  signers = [
    {
      condition = "hasconfig:remote.*.url:git@github.com:*/**";
      name = "Nadeŭka";
      email = "me@nadevko.cc";
      type = "ssh-ed25519";
      key = "AAAAC3NzaC1lZDI1NTE5AAAAIHEzzMRz9cg5om+U/KdUHiEqepyk8RCjuI/7YNa6VMVD";
    }
    {
      condition = "hasconfig:remote.*.url:git@codeberg.org:*/**";
      name = "Hakajoŭka";
      email = "hakajouka@riseup.net";
      type = "ssh-ed25519";
      key = "AAAAC3NzaC1lZDI1NTE5AAAAIE0kSuvVv7tBX08ezn6hhmHZSPGPaztD2gvK+le8RPDR";
    }
  ];
in
{
  programs.git = {
    enable = true;
    package = pkgs.git;
    lfs.enable = true;
    diff-highlight.enable = true;

    aliases = {
      aa = "add .";

      cc = "commit";
      ca = "commit --amend --no-edit";
      caa = "commit --amend --no-edit .";

      ll = "log --graph --branches --left-right --format='%C(blue)%h (%C(cyan)%G?%C(blue)) %C(bold yellow)%s%C(green)%d%C(reset)%n%aN <%aE> %C(white)%ad%-n%-b'";
      ls = "log --format='%C(bold)%m %C(reset blue)%h (%C(cyan)%G?%C(blue)) %C(bold yellow)%s%C(green)%d%C(reset bold) %aN %C(reset white)(%ad)'";

      nn = "checkout";

      ss = "status --short --branch";
    };

    extraConfig = {
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
      help.autocorrect = 3;
      credential.helper = "cache --timeout=600";
      rerere.enabled = true;
    };

    includes = builtins.map (args: {
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
  programs = {
    gh = {
      enable = true;
      extensions = with pkgs; [
        gh-copilot
        gh-f
        gh-i
        inputs.self.packages.${system}.gh-milestone
        gh-notify
        gh-poi
        gh-s
      ];
    };
    git-worktree-switcher.enable = true;
  };
}
