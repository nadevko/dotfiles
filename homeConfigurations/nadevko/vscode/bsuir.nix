{
  inputs,
  config,
  pkgs,
  ...
}:
let
  vscodeDecorators = import ./_vscode4nix.nix;
  inherit (inputs.nix4vscode.lib.${pkgs.system}) forVscodeExtVersion;
  default = config.programs.vscode.profiles.default;
in
{
  programs.vscode.profiles.bsuir = {
    extensions =
      with pkgs.vscode-extensions;
      inputs.self.lib.GetVscodeExtensions forVscodeExtVersion vscodeDecorators
        config.programs.vscode.package.version
        [
          "cweijan.vscode-office"
          bodil.blueprint-gtk
          csharpier.csharpier-vscode
          default.extensions
          hediet.vscode-drawio
          llvm-vs-code-extensions.vscode-clangd
          mesonbuild.mesonbuild
          ms-dotnettools.csdevkit
          ms-dotnettools.csharp
          ms-dotnettools.vscode-dotnet-runtime
          ms-vscode.cmake-tools
          ms-vscode.live-server
          myriad-dreamin.tinymist
          redhat.vscode-xml
        ];

    userSettings = default.userSettings // {
      # "csharpier.dev.customPath" = "/${pkgs.csharpier}/bin";
      # "csharpier.dev.useCustomPath" = true;
      "[csharp]" = {
        "editor.defaultFormatter" = "csharpier.csharpier-vscode";
      };
      "hediet.vscode-drawio.resizeImages" = null;

      "workbench.editorAssociations" = {
        "*.md" = "default";
        "*.markdown" = "default";
      };
    };
    keybindings = default.keybindings ++ [ ];
    userTasks.version = default.userTasks.version;
    userTasks.tasks = default.userTasks.tasks ++ [ ];
  };
}
