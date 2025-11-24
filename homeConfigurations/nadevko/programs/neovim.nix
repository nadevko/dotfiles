{
  inputs,
  config,
  pkgs,
  ...
}:
{
  imports = [ inputs.nixvim.homeModules.nixvim ];
  home.sessionVariables.MANPAGER = "${config.programs.nixvim.build.package}/bin/nvim +Man!";

  programs.nixvim = {
    enable = true;
    impureRtp = false;
    nixpkgs.pkgs = pkgs;

    defaultEditor = true;
    vimdiffAlias = true;
    viAlias = true;
    vimAlias = true;

    withNodeJs = true;
    withRuby = false;
    withPython3 = false;

    opts = {
      autoread = true;
      backup = false;
      breakindent = true;
      completeopt = [
        "fuzzy"
        "noselect"
        "popup"
      ];
      confirm = true;
      cursorline = true;
      hlsearch = true;
      ignorecase = true;
      inccommand = "split";
      list = true;
      listchars = {
        tab = "» ";
        trail = "·";
        nbsp = "␣";
      };
      mouse = "a";
      number = true;
      relativenumber = true;
      ruler = true;
      scrolloff = 8;
      showmode = false;
      signcolumn = "yes";
      smartcase = true;
      splitbelow = true;
      splitright = true;
      swapfile = true;
      termguicolors = true;
      timeoutlen = 300;
      undofile = true;
      updatetime = 250;
    };

    globals = {
      mapleader = " ";
      maplocalleader = "\\";
      have_nerd_font = true;
    };

    editorconfig.enable = true;

    clipboard = {
      register = "unnamedplus";
      providers.wl-copy.enable = true;
    };

    colorschemes.kanagawa = {
      enable = true;
    };

    dependencies.gcc = {
      enable = true;
    };

    dependencies.tree-sitter = {
      enable = true;
    };

    lsp = {
      inlayHints.enable = true;
    };

    performance.byteCompileLua = {
      enable = true;
    };

    performance.combinePlugins = {
      enable = true;
    };

    plugins.nvim-autopairs = {
      enable = true;
    };

    plugins.comment = {
      enable = true;
    };

    plugins.todo-comments = {
      enable = true;
      settings.signs = true;
    };

    plugins.telescope = {
      enable = true;
      keymaps = {
        "<leader><leader>" = "oldfiles";
        "<leader><leader>b" = "buffers";
        "<leader><leader>f" = "file_browser";
        "<leader><leader>F" = "find_files";
        "<leader><leader>s" = "symbols";
        "<leader><leader>t" = "tags";
        "<leader><leader>u" = "undo";
        "<leader><localleader>" = "";
      };

      extensions.file-browser = {
        enable = true;
      };

      extensions.fzf-native = {
        enable = true;
      };

      extensions.media-files = {
        enable = true;

        settings.filetypes = [
          "png"
          "jpg"
          "gif"
          "mp4"
          "webm"
          "pdf"
        ];
        settings.find_cmd = "find";
      };

      extensions.project = {
        enable = true;
      };

      extensions.ui-select = {
        enable = true;
      };

      extensions.undo = {
        enable = true;
      };
    };

    plugins.neo-tree = {
      enable = true;
      autoCleanAfterSessionRestore = true;
      closeIfLastWindow = true;
      usePopupsForInput = true;
    };

    plugins.web-devicons = {
      enable = true;
    };

    keymaps = [
      {
        action = "<cmd>nohlsearch<return>";
        key = "<esc>";
        mode = "n";
        options.desc = "Clear highlights on search when pressing escape";
      }
      {
        action = "<cmd>Neotree toggle<return>";
        key = "<leader>e";
        options.desc = "Toggle file explorer";
      }
      {
        action = "<C-\\\\><C-n>";
        key = "<esc><esc>";
        mode = "t";
        options.desc = "Exit terminal mode";
      }
      {
        action = "<esc>";
        key = "jk";
        mode = [
          "i"
          "v"
        ];
        options.desc = "Simplify escape access";
      }
      {
        mode = "n";
        key = "<C-h>";
        action = "<C-w><C-h>";
        options.desc = "Move focus to the left window";
      }
      {
        mode = "n";
        key = "<C-l>";
        action = "<C-w><C-l>";
        options.desc = "Move focus to the right window";
      }
      {
        mode = "n";
        key = "<C-j>";
        action = "<C-w><C-j>";
        options.desc = "Move focus to the lower window";
      }
      {
        mode = "n";
        key = "<C-k>";
        action = "<C-w><C-k>";
        options.desc = "Move focus to the upper window";
      }
    ];
  };
}
