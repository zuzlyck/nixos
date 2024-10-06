{pkgs, lib, ...}:
let
  gtkset = pkgs.writeTextFile {
    name = "gtkset";
    destination = "/bin/gtkset";
    executable = true;
    text = let
      schema = pkgs.gsettings-desktop-schemas;
      datadir = "${schema}/share/gsettings-schemas/${schema.name}";
    in ''
      #!/usr/bin/env bash
      #export XDG_DATA_DIRS=${datadir}:$XDG_DATA_DIRS
      #gnome_schema=org.gnome.desktop.interface
      #gsettings set org.gnome.desktop.interface gtk-theme $1 && export GTK_THEME=$1
      #echo "Net/ThemeName \"$1\"" > ~/.xsettingsd && kill -HUP $(pgrep xsettingsd)
      #${pkgs.printcols}
      dconf write /org/gnome/desktop/interface/gtk-theme "'$1'"
    '';
  };
 
  ttytheme = pkgs.writeScriptBin "ttytheme" (builtins.readFile ./scripts/ttytheme.sh);
  switchbg = pkgs.writeScriptBin "switchbg" (builtins.readFile ./scripts/switchbg.sh); 
  fetch = pkgs.writeScriptBin "fetch" (builtins.readFile ./scripts/fetch.sh);
  toggle_blur = pkgs.writeScriptBin "toggle_blur" (builtins.readFile ./scripts/toggle_blur.sh);
  distro_icon = pkgs.writeScriptBin "distro_icon" (builtins.readFile ./scripts/distro_icon.sh);
in
{
  nixpkgs.overlays = [
    (_: prev: {
      shadetoggle = pkgs.writeScriptBin "shadetoggle" (builtins.readFile ./scripts/shadetoggle.sh);
      printcols = pkgs.writeScriptBin "printcols" (builtins.readFile ./scripts/printcols.sh);
      startup = pkgs.writeScriptBin "startup" ''
        #!/usr/bin/env sh
        read -n 1 -t 0.1 key
        if [ "$key" = "q" ]
        then
          fish &
        else
          ${pkgs.hyprland}/bin/Hyprland &
        fi
      '';
    })
  ];

  environment.systemPackages = with pkgs; [  
    fetchutils
    gtkset
    ttytheme
    switchbg
    shadetoggle
    fetch
    toggle_blur
    startup
    printcols
    distro_icon
  ];
}
