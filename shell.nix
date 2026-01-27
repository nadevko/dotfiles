{
  mkShell,
  agenix,
  deploy-rs,
  # kasumi-update,
  ...
}:
mkShell {
  packages = [
    agenix
    deploy-rs.deploy-rs
    # kasumi-update
  ];
}
