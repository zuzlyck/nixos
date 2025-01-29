{config, pkgs, lib, inputs, ... }: { 
  imports = [
    ./hardware-configuration.nix
    ./modules/packages.nix
    ./modules/scripts.nix
    ./modules/nixvim.nix
  ];

  boot = {
    kernelParams = ["quiet" "mem_sleep_default=deep"];
    kernelPackages = lib.mkDefault pkgs.linuxPackages_latest;
    tmp.cleanOnBoot = true;
    plymouth = {
      enable = true;
      themePackages = [ pkgs.catppuccin-plymouth ];
      theme = "catppuccin-macchiato";
      extraConfig = ''
        DeviceScale=2
      '';
    };
    initrd = {
      systemd.enable = true;
      luks.devices."luks-0c72d3d5-512b-446f-a1e8-5d0373d3257a".device = "/dev/disk/by-uuid/0c72d3d5-512b-446f-a1e8-5d0373d3257a";
    };
    loader = {
      systemd-boot.enable = true;
      systemd-boot.editor = false;
      efi.canTouchEfiVariables = true;
      timeout = 0;
    };
  };

  powerManagement = {
    enable = true;
    powertop.enable = true;
  };

  networking = {
    hostName = "nixos";
    networkmanager = {
      enable = true;
      wifi.powersave = true;
    };
    firewall.enable = false;
  };

  # Don't wait for network startup
  systemd.services.NetworkManager-wait-online.enable = lib.mkForce false;

  environment = {
    variables = {
      MOZ_ENABLE_WAYLAND = "1";
      NIXOS_CONFIG_DIR = "/etc/nixos";
      FLAVOURS_DATA_DIRECTORY = "/home/balint/.config/flavours/";
      EDITOR = "nvim";
    };
  };

  nix = {
    package = pkgs.nixVersions.stable;

    extraOptions =
      lib.optionalString (config.nix.package == pkgs.nixVersions.stable)
      "experimental-features = nix-command flakes";

    #clean up boot
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };

    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = ["nix-command" "flakes"];
      # Deduplicate and optimize nix store
      auto-optimise-store = true;
      allowed-users = ["balint"];
      trusted-users = ["balint"];
      builders-use-substitutes = true;
      substituters = [
        "https://nix-community.cachix.org"
        "https://cache.nixos.org/"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
  };

  # Set your time zone.
  time.timeZone = "Europe/Budapest";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  /*
  i18n.extraLocaleSettings = {
    LANGUAGE = "en_US.UTF-8";
    LC_ALL = "en_US.UTF-8";
    LC_ADDRESS = "hu_HU.UTF-8";
    LC_IDENTIFICATION = "hu_HU.UTF-8";
    LC_MEASUREMENT = "hu_HU.UTF-8";
    LC_MONETARY = "hu_HU.UTF-8";
    LC_NAME = "hu_HU.UTF-8";
    LC_NUMERIC = "hu_HU.UTF-8";
    LC_PAPER = "hu_HU.UTF-8";
    LC_TELEPHONE = "hu_HU.UTF-8";
    LC_TIME = "hu_HU.UTF-8";
    LANG = "en_US.UTF-8";
  };
    */

  console = {
    earlySetup = true;
    font = "${pkgs.terminus_font}/share/consolefonts/ter-132n.psf.gz";
    packages = with pkgs; [ terminus_font ];
    useXkbConfig = true;
  };
 
  xdg = {
    portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-wlr ];
      configPackages = [ pkgs.xdg-desktop-portal-wlr ];
    };
  };

  #sound.enable = true;
  hardware = {
    pulseaudio.enable = false;
    bluetooth.enable = true; # enables support for Bluetooth
    bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  };
  security.rtkit.enable = true;
  security.polkit.enable = true;
  security.pam.services.login.fprintAuth = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’
  users.users.balint = {
    initialPassword = "pw123";
    isNormalUser = true;
    description = "balint";
    extraGroups = ["wheel" "networkmanager" "audio" "rfkill" "sys" "disk" "input" "kvm" "optical" "storage" "video" "plugdev" "vboxusers"];
    shell = pkgs.fish;
  };

  zramSwap = {
    enable = true;
    algorithm = "zstd";
    priority = 100;
    swapDevices = 1;
    memoryPercent = 50;
  };

  services = {
    zram-generator = {
      package = pkgs.zram-generator;
      enable = true;
    };

    greetd = {
      enable = true;
      settings = {
        initial_session = {
          command = "${pkgs.river}/bin/river";
          user = "balint";
        };

        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd fish";
          user = "balint";
        };
      };
    };
 
    tlp = {
      enable = true;
      settings = {
        CPU_MIN_PERF_ON_AC = 0;
        CPU_MAX_PERF_ON_AC = 100;
        CPU_MIN_PERF_ON_BAT = 0;
        CPU_MAX_PERF_ON_BAT = 60;

        CPU_BOOST_ON_BAT = 0;

        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BATTERY = "powersave";

        RUNTIME_PM_ON_BAT = "auto";
      };
    };

    logind.extraConfig = ''
      # don’t shutdown when power button is short-pressed
      HandlePowerKey=suspend
    '';

    fprintd.enable = true;
    devmon.enable = true;
    udisks2.enable = true;
    upower.enable = true;
    thermald.enable = true;
    fwupd.enable = true;
    printing.enable = true;
    flatpak.enable = true;
  };

  environment.etc."greetd/environments".text = ''
    river
    fish
  '';
 
  virtualisation = {
    podman = {
      enable = true;
      # Create a `docker` alias for podman, to use it as a drop-in replacement
      dockerCompat = true;
      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
    };
    virtualbox.host = {
      enable = true;
      enableKvm = false;
    };
  };

  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = true;
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
