{ config, pkgs, inputs, lib, ... }: {
  ### Auto Updates
  system.autoUpgrade = {
    enable = true;
    flake = inputs.self.outPath;
    flags = [
      "--update-input"
      "nixpkgs"
      "--no-write-lock-file"
      "-L" # print build logs
    ];
    dates = "02:00";
    randomizedDelaySec = "45min";
  };
  ### AppArmor
  services.dbus.apparmor = "enabled";
  security.apparmor = {
    enable = true;
    killUnconfinedConfinables = true;
    enableCache = true;
  };

  ### Enable GnuPG
  services.pcscd.enable = true;
  programs.gnupg.agent = {
   enable = true;
   pinentryPackage = pkgs.pinentry-gnome3;
   enableSSHSupport = true;
  };

  ### Yubikey Support
  security.pam.yubico = {
   enable = true;
   mode = "challenge-response";
   id = [ "27725426" ];
  };
  # Lock device upon removal
  #services.udev.extraRules = ''
      #ACTION=="remove",\
       #ENV{ID_BUS}=="usb",\
       #ENV{ID_MODEL_ID}=="0407",\
       #ENV{ID_VENDOR_ID}=="1050",\
       #ENV{ID_VENDOR}=="Yubico",\
       #RUN+="${pkgs.systemd}/bin/loginctl lock-sessions"
  #'';
  ### Filesystem Encryption
  security.pam.enableEcryptfs = true;

  ### Firejail
  programs.firejail = {
    enable = true;
    wrappedBinaries = {
    librewolf = {
      executable = "${pkgs.librewolf}/bin/librewolf";
      profile = "${pkgs.firejail}/etc/firejail/librewolf.profile";
      extraArgs = [
        # Required for U2F USB stick
        "--ignore=private-dev"
        # Enforce dark mode
        "--env=GTK_THEME=Adwaita:dark"
        # Enable system notifications
        "--dbus-user.talk=org.freedesktop.Notifications"
      ];
      };
    };
  };
}
