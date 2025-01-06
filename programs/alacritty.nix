# This file was shamelessly stolen from sebi/c2vi @ https://github.com/c2vi/nixos/blob/master/programs/alacritty.nix
{...}: {
  programs.alacritty = {
    enable = true;
    settings = {
      window.opacity = 0.0;
      font = {
        size = 16.0;

        normal = {
          family = "HackNerdFont";
          style = "Regular";
        };

        bold = {
          family = "HackNerdFont";
          style = "Bold";
        };

        italic = {
          family = "HackNerdFont";
          style = "Italic";
        };

        bold_italic = {
          family = "HackNerdFont";
          style = "Bold Italic";
        };
      };

      # Dracula theme for alacritty
      colors = {
        primary = {
          background = "#151515";
          foreground = "#cbe3e7";
        };

        normal = {
          black = "#100e23";
          blue = "#91ddff";
          cyan = "#aaffe4";
          green = "#95ffa4";
          magenta = "#c991e1";
          red = "#ff8080";
          white = "#cbe3e7";
          yellow = "#ffe9aa";
        };

        bright = {
          black = "#565575";
          blue = "#65b2ff";
          cyan = "#63f2f1";
          green = "#62d196";
          magenta = "#906cff";
          red = "#ff5458";
          white = "#a6b3cc";
          yellow = "#ffb378";
        };
      };
    };
  };
}
