{ config, pkgs, inputs, username, ... }:

{
  services.nfsClient.enable = true;
  imports = [
    ./hardware-configuration.nix
    ./../../modules/nixos
  ];

  boot = {
    kernelParams = [ 
      "amd_iommu=on" 
      "iommu=pt" 
      "pcie_aspm=off" # Better PCIe performance
      "mitigations=off" # For maximum performance
      "amd_pstate=active"
    ];

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      timeout = 1;
    };
  };


  hardware = {
    cpu.amd.updateMicrocode = true;
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
      rocmPackages.clr.icd

      mesa-demos
      
      gst_all_1.gstreamer
      gst_all_1.gst-plugins-base
      gst_all_1.gst-plugins-good
      gst_all_1.gst-plugins-bad
      gst_all_1.gst-plugins-ugly
      gst_all_1.gst-libav
      gst_all_1.gst-vaapi
      
      # Additional multimedia libraries
      ffmpeg-full
      libva
      libva-utils
      libva-vdpau-driver
      libvdpau-va-gl
      ]; 
      extraPackages32 = with pkgs.pkgsi686Linux; [
        gst_all_1.gstreamer
        gst_all_1.gst-plugins-base
        gst_all_1.gst-plugins-good
        gst_all_1.gst-plugins-bad
        gst_all_1.gst-plugins-ugly
        gst_all_1.gst-libav
        libva
      ];
    };
  };

  powerManagement.cpuFreqGovernor = "performance";
  services.thermald.enable = true;

  boot.extraModprobeConfig = ''
    options amdgpu ppfeaturemask=0xffffffff
    options amdgpu overdrive=1
  '';

  system.stateVersion = "24.11";
}
