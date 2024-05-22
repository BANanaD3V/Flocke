{
  username,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [age sops];
  sops = {
    defaultSopsFile = ../hosts/secrets.yaml;
    defaultSopsFormat = "yaml";
    gnupg = {
      sshKeyPaths = ["/home/${username}/.ssh/id_rsa"];
      # keyFile = "/home/${username}/.config/sops/gpg/keys.txt";
      # generateKey = true;
    };
  };
}
