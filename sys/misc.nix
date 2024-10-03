{ config, pkgs, inputs, lib, ... }: {
  # Shell
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
  environment.shells = with pkgs; [ zsh ];
  # Nix
  nix = {
    package = pkgs.nixVersions.latest;
    settings = {
      auto-optimise-store = true;
      warn-dirty = false;
    };
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
  nixpkgs.config.allowUnfree = true;
  # Virtualization
  virtualisation = {
    kvmgt.enable = true;
    libvirtd.enable = true;
    docker.enable = true;
    waydroid.enable = true;
    podman.enable = true;
  };
  # Sound
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
  # ADB
  programs.adb.enable = true;
  services.udev.packages = [
    pkgs.android-udev-rules
  ];
  # Misc misc
  hardware.enableAllFirmware = true;
  services.flatpak.enable = true;
  security.acme.acceptTerms = true;
  services.printing.enable = false;
  system.stateVersion = "24.05"; # Only change when changing machines or doing a clean update install, don't change just for updates
}
