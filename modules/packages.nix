{config, pkgs, inputs, ...}: {

  /*
  nixpkgs.overlays = [
    (final: _: {
      # this allows you to access `pkgs.unstable` anywhere in your config
      unstable = import inputs.nixpkgs-unstable {
        inherit (final.stdenv.hostPlatform) system;
        inherit (final) config;
      };
    })
  ];
  */

  # Remove unecessary preinstalled packages
  environment.defaultPackages = [ ];

  imports = [ inputs.nixvim.nixosModules.nixvim ];

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  }; 

  environment.systemPackages = with pkgs; [
    #important
    wget
    gcc
    #neovim
    git
    wl-clipboard
    brightnessctl
    playerctl
    mako
    bluez
    foot
    btop
    rofi
    #lxqt.lxqt-policykit

    #DE stuff
    river
    wlr-randr
    wlsunset
    swww
    yambar

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
    fastfetch

    #random graphical/desktop stuff/programs
    telegram-desktop
    libreoffice-qt
    syncthing
    keepassxc
    awf #gtk test thingy
    prusa-slicer
    #unstable.eog
    eog
    #kicad
    #unstable.freecad-wayland
    torrential
    mgba
    dolphin-emu
    oh-my-git
    wineWowPackages.waylandFull
    winetricks
    pavucontrol
    #ungoogled-chromium
    quickemu
    #unstable.nemo-with-extensions
    #nemo-with-extensions
    #unstable.librewolf
    librewolf
    #librewolf
    mpv
    #unstable.lutris-free
    lutris-free
    #lutris-free

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
    xwayland.enable = false;
    
    nano.enable = false;

    nixvim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      enableMan = false;
      package = pkgs.neovim-unwrapped;
      #package = pkgs.neovim-unwrapped;

      opts = {
        number = true;
        shiftwidth = 2;
        clipboard = "unnamedplus";
        termguicolors = true;
      };

      plugins = {
        colorizer.enable = true;
        harpoon.enable = true;
        nix.enable = true;
        # pretty ui
        noice.enable = true;
        # rainbow brackets
        rainbow-delimiters.enable = true;
        treesitter.enable = true;

        lualine = {
          enable = true;
          #settings.options.icons_enabled = true;
        };

        alpha = {
          enable = true;
          #theme = null;
          layout = [
            {
              opts = {
      	        position = "center";
      	        hl = "Type";
              };
              type = "text";
              val = [
      	        ""
      	        ""
      	        ""
      	        ""
      	        ""
      	        ""
      	        ""
      	        " ███▄    █  ██▓▒██   ██▒ ██▒   █▓ ██▓ ███▄ ▄███▓"
      	        " ██ ▀█   █ ▓██▒▒▒ █ █ ▒░▓██░   █▒▓██▒▓██▒▀█▀ ██▒"
      	        "▓██  ▀█ ██▒▒██▒░░  █   ░ ▓██  █▒░▒██▒▓██    ▓██░"
      	        "▓██▒  ▐▌██▒░██░ ░ █ █ ▒   ▒██ █░░░██░▒██    ▒██ "
      	        "▒██░   ▓██░░██░▒██▒ ▒██▒   ▒▀█░  ░██░▒██▒   ░██▒"
      	        "░ ▒░   ▒ ▒ ░▓  ▒▒ ░ ░▓ ░   ░ ▐░  ░▓  ░ ▒░   ░  ░"
      	        "░ ░░   ░ ▒░ ▒ ░░░   ░▒ ░   ░ ░░   ▒ ░░  ░      ░"
      	        "   ░   ░ ░  ▒ ░ ░    ░       ░░   ▒ ░░      ░   "
      	        "         ░  ░   ░    ░        ░   ░         ░   "
      	        "                             ░                  "
              ];
            }
          ];
        };
      };

      extraConfigLua = ''
        --automatic theming
        local theme_script_path = vim.fn.expand("~/.local/share/tinted-theming/tinty/base16-vim-colors-file.vim")

        local function file_exists(file_path)
          return vim.fn.filereadable(file_path) == 1 and true or false
        end

        local function handle_interrupt()
          if file_exists(theme_script_path) then
            vim.cmd("source " .. theme_script_path)
            vim.cmd("echo 'theme changed'")
            vim.cmd("hi Normal guibg=NONE ctermbg=NONE")
            vim.cmd("hi EndOfBuffer guibg=NONE ctermbg=NONE")
            vim.cmd("highlight LineNr guibg=NONE")
          end
        end
      
        if file_exists(theme_script_path) then
          vim.o.termguicolors = true
          vim.g.tinted_colorspace = 256

          vim.cmd("source " .. theme_script_path)

          vim.api.nvim_create_autocmd({"Signal"}, {
            pattern = {"SIGUSR1"},
            callback = handle_interrupt,
          })
        end
        --set background transparent
        vim.cmd("hi Normal guibg=NONE ctermbg=NONE")
        vim.cmd("hi EndOfBuffer guibg=NONE ctermbg=NONE")
        vim.cmd("highlight LineNr guibg=NONE")
      '';
    };
  };
}
