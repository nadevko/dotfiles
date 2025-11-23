{
  inputs,
  mkShell,
  system,
  ...
}:
mkShell {
  packages = with inputs; [
    agenix.packages.${system}.default
    deploy-rs.packages.${system}.default
    # nabiki.packages.${system}.nabiki-update
  ];
}
