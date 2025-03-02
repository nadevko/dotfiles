{
  programs.fastfetch = {
    enable = true;
    settings.display = {
      separator = " : ";
    };
    settings.modules = [
      "break"
      {
        type = "title";
        format = "{6} {7} {8}";
      }
      {
        type = "command";
        text = ''splash="bbbaka!";echo $splash'';
      }
      {
        type = "colors";
        symbol = "circle";
        paddingLeft = builtins.stringLength "Command : ";
      }
      "break"
      {
        type = "chassis";
        key = "󰇺 Chassis";
        format = "{1} {2} {3}";
        keyColor = "green";
      }
      {
        type = "display";
        key = "󰍹 Display";
        format = "{1}x{2} @ {3}Hz [{7}]";
        keyColor = "green";
      }
      {
        type = "cpu";
        format = "{1} @ {7}";
        key = " CPU";
        keyColor = "blue";
      }
      {
        type = "gpu";
        format = "{1} {2}";
        key = "󰊴 GPU";
        keyColor = "blue";
      }
      {
        type = "memory";
        key = " Memory";
        keyColor = "magenta";
      }
      {
        type = "battery";
        key = " Battery";
        keyColor = "magenta";
      }
      "break"
      {
        type = "os";
        key = "󰣇 OS";
        format = "{3}";
        keyColor = "red";
      }
      {
        type = "kernel";
        key = " Kernel";
        format = "{2}";
        keyColor = "red";
      }
      {
        type = "packages";
        key = "󰏗 Packages";
        keyColor = "green";
      }
      {
        type = "terminal";
        key = " Terminal";
        keyColor = "yellow";
      }
      {
        type = "wm";
        key = "󱗃 WM";
        format = "{2}";
        keyColor = "yellow";
      }
      {
        type = "disk";
        key = "󱦟 OS Age";
        folders = "/";
        format = "{days} days";
      }
      {
        type = "uptime";
        key = "󱫐 Uptime";
      }
      "break"
    ];
  };
}
