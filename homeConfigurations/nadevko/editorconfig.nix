{ lib, ... }:
{
  editorconfig.enable = true;
  editorconfig.settings = {
    "*" = {
      end_of_line = "lf";
      charset = "utf-8";
      trim_trailing_whitespace = true;
      insert_final_newline = true;
      indent_style = "space";
      indent_size = 2;
    };

    "*.{d.,}{m,c,}{j,t}s".indent_style = "tab";

    "*.{j,t}sx".indent_style = "tab";

    "*.go" = {
      indent_style = "tab";
      indent_size = 8;
    };
  }
  //
    lib.genAttrs
      [
        "*.py"
        "*.rs"
        "*.kt"
        "*.php"
        "*.swift"
        "*.fs"
        "*.odin"
        "*.gd"
      ]
      (_: {
        indent_size = 4;
      });
}
