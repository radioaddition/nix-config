{ config, pkgs, inputs, lib, ... }: {
  hardware.enableAllFirmware = true;
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
  environment.shells = with pkgs; [ zsh ];
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
  virtualisation = {
    kvmgt.enable = true;
    libvirtd.enable = true;
    docker.enable = true;
    waydroid.enable = true;
    podman.enable = true;
  };
  environment.systemPackages = with pkgs; [
    btrfs-progs
    busybox
    ecryptfs
    gcc
    git
    libvirt
    lsof
    mcron
    neovim
    pinentry-gnome3
    qemu
    qemu_kvm
    rsync
    sbctl
    steam-tui
    steamcmd
  ];
  security.acme.acceptTerms = true;
  system.stateVersion = "24.05"; # Only change when changing machines or doing a clean update install, don't change just for updates
}
