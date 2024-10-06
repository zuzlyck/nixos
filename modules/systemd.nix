{pkgs, lib, ...}: {
  systemd.timers."hyprshadetoggle" = {
    wantedBy = [ "timers.target" ];
      timerConfig = {
        OnCalendar = "*-*-* *:00:00";
        Persistent = true;
        Unit = "hyprshadetoggle.service";
      };
  };
 
  systemd.services."hyprshadetoggle" = {
    script = "${pkgs.shadetoggle}";
    serviceConfig = {
      Type = "oneshot";
      User = "balint";
    };
  };

  systemd.services = {
    # Don't wait for network startup
    NetworkManager-wait-online.enable = lib.mkForce false;
  };
}
