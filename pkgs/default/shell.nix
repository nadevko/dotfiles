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
    nabiki.packages.${stdenv.hostPlatform.system}.nabiki-update
  ];
}
