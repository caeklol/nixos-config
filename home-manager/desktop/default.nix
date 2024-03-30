{pkgs, ...}: {
  config = {
    gtk = {
      enable = true;
      cursorTheme = {
        name = "macOS-Monterey";
        package = pkgs.apple-cursor;
        size = 24;
      };
      font = {
        name = "SF-Pro-Display-Regular";
        package = pkgs.apple-fonts;
        size = 10;
      };

      iconTheme = {
        name = "Papirus-Dark";
        package = pkgs.papirus-icon-theme;
      };

      theme = {
        name = "Catppuccin-Mocha-Standard-Teal-Dark";
        package = pkgs.catppuccin-gtk.override {
          accents = ["teal" "blue"];
          variant = "mocha";
        };
      };
    };
  };
  # TODO
  # QT
}
