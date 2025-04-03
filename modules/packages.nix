{config, pkgs, inputs, nixpkgs, ...}: {

  # Remove unecessary preinstalled packages
  environment.defaultPackages = [ ];

  #imports = [ inputs.nixvim.nixosModules.nixvim ];

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  }; 

  environment.systemPackages = with pkgs; [
    #important
    wget
    gcc
    git
    wl-clipboard
    brightnessctl
    playerctl
    mako
    bluez
    foot
    btop
    rofi
    keyd

    #DE stuff
    river
    wlr-randr
    wlsunset
    swww
    yambar
    grim
    slurp

    #shell stuff
    yash
    ffmpegthumbnailer
    distrobox
    podman
    yazi
    eza
    fastfetch

    #random graphical/desktop stuff/programs
    telegram-desktop
    libreoffice-qt
    syncthing
    keepassxc
    #prusa-slicer
    eog
    #kicad
    #freecad-wayland
    torrential
    mgba
    dolphin-emu
    oh-my-git
    #wineWowPackages.waylandFull
    #winetricks
    pavucontrol
    #ungoogled-chromium
    quickemu
    #nemo-with-extensions
    librewolf
    mpv
    #lutris-free
    mtpfs
    wineWowPackages.waylandFull
    steam
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

    xwayland.enable = false;
    nano.enable = false;

    appimage = {
      enable = true;
      binfmt = true;
    };
  };
}
