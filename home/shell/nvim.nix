{
  inputs,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    inputs.Lumi.packages.${system}.default
    lazygit
  ];
}
