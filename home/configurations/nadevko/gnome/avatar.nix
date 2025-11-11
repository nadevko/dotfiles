{ inputs, pkgs, ... }:
{
  home.file.".face".source =
    (pkgs.callPackage "/${inputs.self}/pkgs/_face.nix" {
      githubID = "93840073";
      githubAvatarHash = "sha256-wsOCr3rbxTEG9cEXvh7GnpW5Xc+8/VP4ZHsjiItgVVU=";
      inherit inputs;
    }).outPath;
}
