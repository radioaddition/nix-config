{ config, pkgs, inputs, lib, ... }:{
  boot = {

  ### Boot animation
    plymouth = {
      enable = true;
      theme = "cuts_alt";
      themePackages = with pkgs; [
        # By default we would install all themes
        (adi1090x-plymouth-themes.override {
          selected_themes = [ "cuts_alt" ];
        })
      ];
    };

  ### Enable silent boot
    consoleLogLevel = 0;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "loglevel=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
    ];

  ### Misc bootloader config
    loader = {
      timeout = 0;
      systemd-boot.enable = true;
#      grub = {
#	enable = true;
#        efiSupport = true;
#        device = "nodev";
#        useOSProber = true;
#        timeoutStyle = "menu";
#      };
      efi.canTouchEfiVariables = true;
    };
    kernelModules = [ "ecryptfs" ];
    extraModprobeConfig = ''
      options snd-intel-dspcfg dsp_driver=1
    '';
  };
}
