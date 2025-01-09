{
  pkgs,
  config,
  ...
}: {
  home = {
    packages = with pkgs; [
      dconf
      catppuccin-gtk
      tree
      # gnome.dconf-editor
    ];

    pointerCursor = {
      name = "catppuccin-mocha-peach-cursors";
      package = pkgs.catppuccin-cursors.mochaPeach;
      size = 20;
      gtk.enable = true;
      x11.enable = true;
    };
  };

  gtk = {
    enable = true;
    theme = {
      name = "catppuccin-mocha-lavender-standard,normal";
      package = pkgs.catppuccin-gtk.override {
        accents = ["lavender"];
        size = "standard";
        tweaks = [];
        variant = "mocha";
      };
    };

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 14;
    };
    gtk3 = {
      extraConfig = {
        gtk-application-prefer-dark-theme = 1;
      };
    };
    gtk4 = {
      extraConfig = {
        gtk-application-prefer-dark-theme = 1;
      };
    };
  };

  home.sessionVariables = {
    XCURSOR_SIZE = config.home.pointerCursor.size + 4;
    GTK_THEME = "catppuccin-mocha-lavender-standard";
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk";
  };
}
