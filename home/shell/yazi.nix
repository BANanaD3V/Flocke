{
  config,
  pkgs,
  ...
}: {
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      manager = {
        layout = [0 1 1];
        sort_by = "alphabetical";
        sort_sensitive = false;
        linemode = "size";
        sort_reverse = false;
        show_hidden = true;
      };
    };
  };
}
