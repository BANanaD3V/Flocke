{
  inputs,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    inputs.Flocke.packages.${system}.default
    lazygit
  ];
}
