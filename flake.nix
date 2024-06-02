{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix.url = "github:MichaelPachec0/spicetify-nix";

    nix-gaming.url = "github:fufexan/nix-gaming";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    nixpkgs-wayland.url = "github:nix-community/nixpkgs-wayland";

    Lumi.url = "github:bananad3v/Lumi";
    waybar.url = "github:Alexays/Waybar";
    catppuccin-grub = {
      url = "github:catppuccin/grub";
      flake = false;
    };

    auto-cpufreq = {
      url = "github:adnanhodzic/auto-cpufreq";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur.url = "github:nix-community/NUR";

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    getchoo = {
      url = "github:getchoo/nix-exprs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    schizofox = {
      url = "github:schizofox/schizofox";
    };
    nix-colors.url = "github:misterio77/nix-colors";
    prism.url = "github:IogaMaster/prism";
    game-rs.url = "github:amanse/game-rs";
    nix-alien.url = "github:thiagokokada/nix-alien";
    sops-nix.url = "github:Mic92/sops-nix";
    sddm-sugar-candy-nix = {
      url = "gitlab:Zhaith-Izaliel/sddm-sugar-candy-nix";
    };
    wayfreeze.url = "github:jappie3/wayfreeze";
  };

  outputs = {
    nixpkgs,
    self,
    ...
  } @ inputs: let
    username = "banana";
    userfullname = "Nikita";
    useremail = "bananadev@skiff.com";

    system = "x86_64-linux";

    commonInherits = {
      inherit (nixpkgs) lib;
      inherit self inputs;
      inherit username userfullname useremail;
      inherit system;
    };
  in {
    nixosConfigurations = import ./hosts (
      commonInherits // {isNixOS = true;}
    );

    homeConfigurations = import ./hosts (
      commonInherits // {isNixOS = false;}
    );
  };
}
