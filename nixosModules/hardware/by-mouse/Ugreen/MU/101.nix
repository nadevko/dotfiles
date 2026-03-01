{
  services.keyd.enable = true;
  services.keyd.keyboards.ugreen-mu101 = {
    ids = [ "2b89:6621" ];
    settings.meta = {
      "]" = "layer(meta)";
      "[" = "down";
    };
  };
}
