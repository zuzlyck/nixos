{config, pkgs, ...}: {

  # Remove unecessary preinstalled packages
  environment.defaultPackages = [ ];

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  }; 

  environment.systemPackages = with pkgs; [
    #important
    wget
    gcc
    neovim
    git
    wl-clipboard
    brightnessctl
    playerctl
    waybar
    mako
    nemo-with-extensions
    bluez
    #lxqt.lxqt-policykit

    #shell stuff
    yash
    ffmpegthumbnailer
    distrobox
    podman
    nix-index
    #nix-melt
    nix-tree
    deadnix
    comma
    statix
    hyperfine
    yazi
    eza

    #random graphical/desktop stuff/programs
    telegram-desktop
    libreoffice-qt
    syncthing
    keepassxc
    awf #gtk test thingy
    prusa-slicer
    eog
    #kicad
    freecad-wayland
    torrential
    mgba
    dolphin-emu
    oh-my-git
    wineWowPackages.waylandFull
    winetricks
    pavucontrol
    ungoogled-chromium
    quickemu

    #code
    ghc

    #test
    #gimp
    #krita
    #pinta
    #inkscape
  ];

  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      (nerdfonts.override { fonts = [ "DejaVuSansMono" ]; })
      rPackages.phosphoricons
    ];
  };

  programs = {
    mtr.enable = true;
    fish.enable = true;
    xwayland.enable = true;
    sway.enable = true;
    
    nano.enable = false;
  };
}
