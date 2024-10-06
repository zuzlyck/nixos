{ ... }: {
  imports = [
    ./home.nix
    ./packages.nix
    ./scripts.nix
    ./systemd.nix
  ];
}
