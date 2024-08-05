{...}: {
  imports = [
    (import ./package.nix {
      wan = "enp14s88";
      qnum = 200;
    })
  ];
}
