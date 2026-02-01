{ config, pkgs, ... }:
let
  vscodeDecorators = import ./.vscode4nix.nix;
  extensionGenerator = pkgs.nix4vscode.forVscodeExtVersion vscodeDecorators config.programs.vscode.package.version;
in
{
  programs.vscode.enable = true;

  programs.vscode.profiles.default = {
    enableExtensionUpdateCheck = true;
    enableUpdateCheck = false;

    extensions =
      with pkgs.vscode-extensions;
      pkgs.lib.generateMissingVscodeExtensions extensionGenerator [
        "cweijan.vscode-office"
        "fogio.jetbrains-file-icon-theme"
        "kilocode.Kilo-Code"
        "metaseed.metago"
        "metaseed.MetaJump"
        "metaseed.MetaWord"
        "ultram4rine.vscode-choosealicense"
        "Zibro.monokai-hc-extreme"
        egirlcatnip.adwaita-github-theme
        hediet.vscode-drawio
        jnoortheen.nix-ide
        llvm-vs-code-extensions.vscode-clangd
        mesonbuild.mesonbuild
        mkhl.direnv
        ms-vscode.cmake-tools
        ms-vscode.hexeditor
        ms-vscode.live-server
        myriad-dreamin.tinymist
        piousdeer.adwaita-theme
        redhat.vscode-xml
        usernamehw.errorlens
      ];

    userSettings = {
      "accessibility.underlineLinks" = true;
      "debug.showVariableTypes" = true;
      "diffEditor.codeLens" = true;
      "editor.acceptSuggestionOnEnter" = "smart";
      "editor.autoIndentOnPaste" = true;
      "editor.cursorBlinking" = "phase";
      "editor.cursorSmoothCaretAnimation" = "explicit";
      "editor.cursorSurroundingLines" = 5;
      "editor.fastScrollSensitivity" = 10;
      "editor.foldingImportsByDefault" = true;
      "editor.fontFamily" =
        "'VictorMono Nerd Font Mono', '0xProto Nerd Font Mono', 'Mononoki Nerd Font Mono', 'Droid Sans Mono', monospace";
      "editor.fontLigatures" = "'ss01'";
      "editor.fontSize" = 16;
      "editor.formatOnPaste" = true;
      "editor.guides.bracketPairs" = true;
      "editor.inlayHints.maximumLength" = 48;
      "editor.inlayHints.padding" = true;
      "editor.linkedEditing" = true;
      "editor.minimap.showSlider" = "always";
      "editor.mouseWheelZoom" = true;
      "editor.overtypeCursorStyle" = "underline";
      "editor.renderLineHighlight" = "all";
      "editor.renderWhitespace" = "trailing";
      "editor.scrollbar.horizontalScrollbarSize" = 4;
      "editor.scrollbar.verticalScrollbarSize" = 4;
      "editor.stickyTabStops" = true;
      "editor.suggest.snippetsPreventQuickSuggestions" = true;
      "explorer.fileNesting.enabled" = true;
      "explorer.fileNesting.patterns" = builtins.mapAttrs (_: builtins.concatStringsSep ", ") {
        "flake.nix" = [ "\${basename}.lock" ];
      };
      "explorer.incrementalNaming" = "smart";
      "extensions.autoCheckUpdates" = false;
      "extensions.autoUpdate" = false;
      "git.enableCommitSigning" = true;
      "git.followTagsWhenSync" = true;
      "git.mergeEditor" = true;
      "git.replaceTagsWhenPull" = true;
      "git.terminalGitEditor" = true;
      "git.timeline.showUncommitted" = true;
      "hediet.vscode-drawio.resizeImages" = null;
      "keyboard.dispatch" = "keyCode";
      "merge-conflict.autoNavigateNextConflict.enabled" = true;
      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "/${pkgs.nixd}/bin/nixd";
      "notebook.formatOnCellExecution" = true;
      "scm.providerCountBadge" = "auto";
      "security.workspace.trust.untrustedFiles" = "open";
      "telemetry.feedback.enabled" = false;
      "telemetry.telemetryLevel" = "off";
      "terminal.integrated.copyOnSelection" = true;
      "terminal.integrated.enableImages" = true;
      "terminal.integrated.enableVisualBell" = true;
      "terminal.integrated.fontSize" = 16;
      "terminal.integrated.stickyScroll.enabled" = true;
      "testing.coverageToolbarEnabled" = true;
      "update.mode" = "none";
      "vscode-office.editorTheme" = "Auto";
      "vscode-office.openOutline" = false;
      "window.autoDetectColorScheme" = true;
      "window.confirmBeforeClose" = "keyboardOnly";
      "window.menuBarVisibility" = "toggle";
      "window.zoomLevel" = 1;
      "workbench.activityBar.location" = "top";
      "workbench.colorTheme" = "Adwaita Light & Github syntax highlighting";
      "workbench.commandPalette.history" = 256;
      "workbench.editor.defaultBinaryEditor" = "hexEditor.hexedit";
      "workbench.editor.enablePreviewFromCodeNavigation" = true;
      "workbench.editor.enablePreviewFromQuickOpen" = true;
      "workbench.editor.pinnedTabSizing" = "compact";
      "workbench.editor.preventPinnedEditorClose" = "keyboard";
      "workbench.enableExperiments" = false;
      "workbench.iconTheme" = "jetbrains-file-icon-theme-auto";
      "workbench.list.fastScrollSensitivity" = 10;
      "workbench.preferredDarkColorTheme" = "Adwaita Dark & Github syntax highlighting";
      "workbench.preferredHighContrastColorTheme" = "Monokai HC extreme dark";
      "workbench.preferredHighContrastLightColorTheme" = "Monokai HC extreme light";
      "workbench.preferredLightColorTheme" = "Adwaita Light & Github syntax highlighting";
      "workbench.productIconTheme" = "adwaita";
      "workbench.startupEditor" = "readme";
      "workbench.view.alwaysShowHeaderActions" = true;

      "github.copilot.enable" = {
        "*" = false;
      };

      "workbench.editorAssociations" = {
        "*.md" = "default";
        "*.markdown" = "default";
      };
      "kilo-code.allowedCommands" = [
        "git log"
        "git diff"
        "git show"
      ];
      "kilo-code.deniedCommands" = [ "rm" ];

      "[nix]" = {
        "editor.defaultFormatter" = "jnoortheen.nix-ide";
      };

      "nix.serverSettings".nixd.formatting.command = [
        "${pkgs.nixfmt}/bin/nixfmt"
        "--strict"
      ];
    };

    keybindings = [
      {
        key = "ctrl+left";
        command = "cursorWordPartLeft";
      }
      {
        key = "ctrl+shift+left";
        command = "cursorWordPartLeftSelect";
      }
      {
        key = "ctrl+right";
        command = "cursorWordPartRight";
      }
      {
        key = "ctrl+shift+right";
        command = "cursorWordPartRightSelect";
      }
      {
        key = "alt+i";
        command = "workbench.action.tasks.runTask";
        args = "Format project with nix3-fmt";
      }
    ];

    userTasks.version = "2.0.0";
    userTasks.tasks = [
      {
        type = "shell";
        label = "Format project with nix3-fmt";
        command = "nix";
        args = [ "fmt" ];
        problemMatcher = [ ];
      }
    ];
  };
}
