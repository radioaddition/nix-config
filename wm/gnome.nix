{ config, pkgs, inputs, lib, ... }: {
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  environment.gnome.excludePackages = with pkgs.gnome; [
    yelp
    cheese
    simple-scan
    totem
  ];
  services.xserver = {
    xkb = {
      layout = "us";
      variant = "";
    };
  };
}
