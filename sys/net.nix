{ config, pkgs, inputs, lib, ... }: {
  # networking.hostName = "galith"; # Define your hostname.
  #' proxy config for using hotspot
  #- networking.proxy.default = "http://192.168.49.1:8282";
  #- networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  ### Configure NetworkManager

  networking.networkmanager = {
    enable = true;
    wifi = {
      macAddress = "random";
      powersave = true;
      scanRandMacAddress = true;
      backend = "iwd";
    };
  };

  ### Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 51413 9052 9053 9080 ];
  networking.firewall.allowedUDPPorts = [ 65530 51413 9052 9053 9080 ];
  networking.firewall.allowedTCPPortRanges = [ 
      { from = 1714; to = 1764; } # KDE Connect
    ];  
  networking.firewall.allowedUDPPortRanges = [ 
      { from = 1714; to = 1764; } # KDE Connect
    ];
  #' Or disable the firewall altogether.
  #' networking.firewall.enable = false;

  ## Locale

  ### Set your time zone.
  time.timeZone = "America/New_York";

  ### Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };
}
