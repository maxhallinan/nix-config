{ ... }:

let
  default-font = "Menlo";
in
{
  programs.alacritty = {
    enable = true;

    settings = {
      # Solarized Dark
      # https://github.com/alacritty/alacritty-theme/blob/master/themes/solarized_dark.yaml
      colors = {
        primary.background = "0x002b36";
        primary.foreground = "0x839496";
        normal = {
          black = "0x073642";
          red = "0xdc322f";
          green = "0x859900";
          yellow = "0xb58900";
          blue = "0x268bd2";
          magenta = "0xd33682";
          cyan = "0x2aa198";
          white = "0xeee8d5";
        };
        bright = {
          black = "0x002b36";
          red = "0xcb4b16";
          green = "0x586e75";
          yellow = "0x657b83";
          blue = "0x839496";
          magenta = "0x6c71c4";
          cyan = "0x93a1a1";
          white = "0xfdf6e3";
        };
      };
      cursor.style = "Block";
      cursor.unfocused_hollow = true;
      font.normal = {
        family = default-font;
        style = "Regular";
      };
      font.size = 14.0;
      scrolling.history = 10000;
      url.launcher.program = "chrome";
      window = {
        # https://github.com/alacritty/alacritty/issues/93
        option_as_alt = "Both";
      };
    };
  };
}
