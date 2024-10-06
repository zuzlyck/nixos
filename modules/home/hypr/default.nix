{pkgs, ...}: {

  home = {
    packages = [pkgs.hyprshade pkgs.hyprshot pkgs.hyprpicker pkgs.rofi-wayland];
    file.".config/hypr/shaders/blue-light-filter.glsl".source = ./blue-light-filter.glsl;
  };

  imports = [ 
    ./paper.nix
    ./lock.nix
    ./idle.nix
  ];


  wayland.windowManager.hyprland = {
    enable = true;
    sourceFirst = true;
    systemd.enable = true;
    xwayland.enable = true;
    settings = import ./binds.nix // import ./env.nix // {
      source = "~/.config/hypr/theme.conf";

      monitor=",preferred,auto,2";
      
      general = {
	border_size = 2;
	gaps_in = 1;
	gaps_out = 3;
	gaps_workspaces = 0;
	"col.inactive_border" = "0xbb$base7alpha";
	"col.active_border" = "$base03";
	"col.nogroup_border" = "0xffffaaff";
	"col.nogroup_border_active" = "0xffff00ff";
    	layout = "dwindle";
	resize_on_border = true;
	extend_border_grab_area = 5;
      };
 
      decoration = {
	rounding = 12;
	inactive_opacity = 0.8;
	drop_shadow = false;
	shadow_range = 10;
	shadow_render_power = 2;
	"col.shadow" = "0x66404040";
	shadow_offset = "1 2";
	dim_inactive = true;
	dim_strength = 0.2;

	blur = {
	  enabled = true;
	  ignore_opacity = false;
	  new_optimizations = true;
	  passes = 3;
	  size = 3;
	  xray = false;
	};
      };

      animations = {
	enabled = "truef";
	bezier = [
	  "overshot, 0.05, 0.9, 0.1, 1.05"
	  "smoothOut, 0.36, 0, 0.66, -0.56"
	  "smoothIn, 0.25, 1, 0.5, 1"
	  "linear, 0.0, 0.0, 1.0, 1.0"
	];
	animation = [
	  "windows, 1, 5, overshot, slide"
	  "windowsOut, 1, 4, smoothOut, slide"
	  "windowsMove, 1, 4, default"
	  "border, 1, 10, default"
	  "fade, 1, 10, smoothIn"
	  "fadeDim, 1, 10, smoothIn"
	  "workspaces, 1, 6, default"
	  "borderangle, 1, 100, linear, loop"
	];
      };

      input = {
	kb_model = "pc104";
	kb_layout = "us,us,us";
	kb_variant = "altgr-intl,olpc2,symbolic";
	kb_options = "grp:alt_space_toggle,compose:rctrl-altgr";
	sensitivity = 0.25;
	
	touchpad = {
	  natural_scroll = true;
        };
      };

      gestures = {
	workspace_swipe = true;
	workspace_swipe_forever = true;
      };

      group = {
	"col.border_active" = "0x66ffff00";
	"col.border_inactive" = "0x66777700";
	"col.border_locked_active" = "0x66ff5500";
	"col.border_locked_inactive" = "0x66775500";

	groupbar = {
	  enabled = true;
	  gradients = false;
	  font_size = 20;
	  height = 14;
	  render_titles = true;
	  text_color = "0xffffffff";
	  "col.active" = "0x66ffff00";
	  "col.inactive" = "0x66777700";
	  "col.locked_active" = "0x66ff5500";
	  "col.locked_inactive" = "0x66775500";
	};
      };

      misc = {
	disable_hyprland_logo = true;
	disable_splash_rendering = true;
	"col.splash" = "0xffffffff";
	mouse_move_enables_dpms = true;
	key_press_enables_dpms = true;
      };

      #cursor = {
        #inactive_timeout = 10;
      #};
    };
  };
}
