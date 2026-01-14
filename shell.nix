{
  inputs,
  mkShell,
  stdenv,
  ...
}:
mkShell {
  packages = with inputs; [
    agenix.packages.${stdenv.hostPlatform.system}.default
    deploy-rs.packages.${stdenv.hostPlatform.system}.default
    # kasumi.packages.${stdenv.hostPlatform.system}.kasumi-update
  ];
}
