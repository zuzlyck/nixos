{pkgs, ...}: {

  home.packages = with pkgs; [
    fishPlugins.tide
    #fishPlugins.pure
    #fishPlugins.transient-fish
    #fishPlugins.z
    #fishPlugins.grc
    #fishPlugins.colored-man-pages
    #fishPlugins.bass
    #fishPlugins.sponge
    #fishPlugins.puffer
    fishPlugins.autopair
    eza
    grc
    powerline-go
    powerline-rs
    starship
    yash
  ];

  programs.fish = {

    enable = true;

    interactiveShellInit =
      ''
        set fish_greeting # Disable greeting

        tty | grep -q /dev/pts && cat ~/.cache/$USER/tty || ~/.cache/$USER/tty.sh
 
        [ $(tty) = "/dev/pts/0" ] && [ "$SHLVL" = 1 ] && fastfetch

        # Workaround for nix-shell --pure
        #if [ "$IN_NIX_SHELL" = "pure" ]; then
        #  if [ -x "$HOME/.nix-profile/bin/powerline-go" ]; then
        #    alias powerline-go="$HOME/.nix-profile/bin/powerline-go"
        #  elif [ -x "/run/current-system/sw/bin/powerline-go" ]; then
        #    alias powerline-go="/run/current-system/sw/bin/powerline-go"
        #  end
        #end

        #starship init fish | source
      '';

    plugins = [
      { name = "tide"; src = pkgs.fishPlugins.tide; }
      #{ name = "pure"; src = pkgs.fishPlugins.pure; }
      #{ name = "transient-fish"; src = pkgs.fishPlugins.transient-fish; }
      #{ name = "z"; src = pkgs.fishPlugins.z; }
      #{ name = "grc"; src = pkgs.fishPlugins.grc; }
      #{ name = "colored-man-pages"; src = pkgs.fishPlugins.colored-man-pages; }
      #{ name = "bass"; src = pkgs.fishPlugins.bass; }
      #{ name = "sponge"; src = pkgs.fishPlugins.sponge; }
      #{ name = "puffer"; src = pkgs.fishPlugins.puffer; }
      { name = "autopair"; src = pkgs.fishPlugins.autopair; }
    ];

    functions = {
      cd = ''
        if [ "$(count $argv)" = "0" ]
          builtin cd $HOME && command eza --icons --group-directories-first --color=auto -F
        else
          builtin cd "$argv" && command eza --icons --group-directories-first --color=auto -F
        end
      '';

      yy = ''
        set tmp (mktemp -t "yazi-cwd.XXXXX")
        yazi $argv --cwd-file="$tmp"
        if set cwd (cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
          builtin cd -- "$cwd"
        end
        command rm -f -- "$tmp"
      '';
      #fish_prompt = ''
        #set duration (math -s6 "$CMD_DURATION / 1000")
        #eval powerline-go -modules "venv,ssh,cwd,perms,git,hg,jobs,exit,root" -error $status -jobs (count (jobs -p))
        #powerline-rs --shell bare $status
      #'';
      debian = ''
        if [ "$(count $argv)" = "0" ]
          distrobox enter debian
        else
          distrobox enter debian -- $argv
        end
      '';
    };

    shellAliases = {
      rebuild = "sudo nixos-rebuild switch";
      update= "sudo nix flake update $NIXOS_CONFIG_DIR";
      ns = "nix-shell --run fish";
      nix-shell = "nix-shell --run fish";
      nix-clean = "sudo nix-collect-garbage && sudo nix-collect-garbage -d && sudo rm /nix/var/nix/gcroots/auto/* && nix-collect-garbage && nix-collect-garbage -d";
      nixos = "cd $NIXOS_CONFIG_DIR";
      ".." = "cd ..";
      svim = "sudoedit";
      vim = "nvim";
      c = "clear";
      q = "quit";
      grep = "grep --color=auto";
      mv = "mv -v";
      rm = "rm -v";
      ls = "eza --color=auto --icons --group-directories-first";
      la = "eza --icons --color=auto --group-directories-first -a";
      l = "eza --icons --color=auto --group-directories-first -l";
      lla = "eza --icons --color=auto --group-directories-first -la";
      tree = "eza --icons --tree --group-directories-first";
    };
  };
  # do not generate man caches as it slows down build, removes ~/.manpath
  programs.man.generateCaches = false;

  programs.bash = {
    enable = true;
    initExtra = ''
      source ~/code/shell/prompt/out/result.sh
    '';
  };
}
