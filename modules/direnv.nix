{pkgs, ...}: {
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    config = {
      warn_timeout = "0ms";
    };
  };
}
