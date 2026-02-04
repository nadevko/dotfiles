{
  config,
  pkgs,
  nixvim,
  ...
}:
{
  imports = [ nixvim.homeModules.nixvim ];
  home.sessionVariables.MANPAGER = config.programs.nixvim.build.package + "/bin/nvim +Man!";

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

    plugins.neo-tree = {
      enable = true;
      settings = {
        use_popups_for_input = true;
        close_if_last_window = true;
        auto_clean_after_session_restore = true;
      };
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
