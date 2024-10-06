{lib, pkgs, ...}: {
  home = {

    packages = [ pkgs.flavours ];

    file.".config/flavours/config.toml".source = ./config.toml;
    file.".config/flavours/schemes".source = ./schemes;
    file.".config/flavours/templates".source = ./templates;

    activation = {
      myActivationAction = lib.hm.dag.entryAfter ["writeBoundary"]
      ''
        #!/usr/bin/env bash

	FILE=~/.config/hypr/theme.conf
        if ! [[ -f "$FILE" ]]; then
          cp ${./fallback/theme.conf} $FILE
        fi

	FILE=~/.config/btop/themes/base16.theme
        if ! [[ -f "$FILE" ]]; then
          cp ${./fallback/base16.theme} $FILE
        fi

	FILE=~/.themes/colors2
        if ! [[ -f "$FILE" ]]; then
          cp ${./fallback/colors2} $FILE
        fi

	FILE=~/.themes/colors3
        if ! [[ -f "$FILE" ]]; then
          cp ${./fallback/colors3} $FILE
        fi

	FILE=~/.cache/$USER/tty
        if ! [[ -f "$FILE" ]]; then
          cp ${./fallback/tty} $FILE
        fi
      '';
    };
  };
}
