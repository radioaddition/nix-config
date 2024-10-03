{ config, pkgs, inputs, lib, ... }: {
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
}
