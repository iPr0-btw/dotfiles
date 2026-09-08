
{ config, pkgs, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];


   nix.settings.experimental-features = [ "nix-command" "flakes" ];

   virtualisation.docker.enable = true;

  boot.loader = { 
    systemd-boot.enable = true;
    timeout = 1;
    efi.canTouchEfiVariables = true;
  };
 
systemd.services.display-manager.enable = false;

systemd.user.services.autopush.enable = true;

services.tlp.enable = true;
services.tlp.pd.enable = true;
services.power-profiles-daemon.enable = false;
  boot.blacklistedKernelModules = [ "nouveau" ];

    services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c0330", ATTR{power/control}="auto", ATTR{remove}="1"

    ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c8000", ATTR{power/control}="auto", ATTR{remove}="1"

    ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x040300", ATTR{power/control}="auto", ATTR{remove}="1"

    ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x03[0-9]*", ATTR{power/control}="auto", ATTR{remove}="1"
  '';

   services.tailscale.enable = true;
   services.asusd.enable = true;

  boot.kernelPackages = pkgs.linuxPackages_zen;

  networking.hostName = "nixos"; # Define your hostname.
  networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.


  networking.networkmanager.enable = true;

  time.timeZone = "America/Chicago";

  i18n.defaultLocale = "en_GB.UTF-8";

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

  services.xserver = { 
  enable = true;
  videoDrivers = [ "amdgpu" "nvidia" ];
  };

  hardware.nvidia = {
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;

      prime = {
    offload = {
      enable = true;
      enableOffloadCmd = true;
    };
    amdgpuBusId = "PCI:0:65:0";
    nvidiaBusId = "PCI:0:64:0";
  };

  };

environment.variables = {
  LIBGL_ALWAYS_INDIRECT = "0";
  LIBGLVND_VENDOR_DIR = "/run/opengl-driver/lib";
};

boot.kernelModules = [ "amdgpu" "nvidia" "nvidia_drm" "nvidia_uvm" ];

  systemd.services."getty@tty1" = {
    wantedBy = [ "getty.target" ];
  };

  services.getty.autologinUser = "bruh";

  services.xserver.xkb = {
    layout = "us";
    variant = "altgr-intl";
  };

  services.printing.enable = true;


  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;

  };


  users.users."bruh" = {
    isNormalUser = true;
    description = "bruh";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
librewolf
thunar
fastfetch
btop
uwsm
dms-shell
swaylock
swaybg
rofi
quickshell
pulsemixer
searxng
];
  };

  nixpkgs.config.allowUnfree = true;

fonts.packages = with pkgs; [
  noto-fonts
  noto-fonts-cjk-sans
  nerd-fonts.iosevka-term
];

  environment.systemPackages = with pkgs; [
    pkgs.asusctl
    neovim
    kitty
    python3
    pciutils
    tailscale
    appimage-run
    engrampa
    zip
    unzip
    fish
    docker
    git 
    pkgs.kdePackages.plasma-desktop
    pkgs.kdePackages.systemsettings
    pkgs.kdePackages.plasma-pa
    pkgs.kdePackages.plasma-nm
    zoxide
];


  programs.zsh.enable = true;

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

    xdg.portal.enable = true;
  xdg.portal.extraPortals = [
    pkgs.xdg-desktop-portal-gtk
  ];


  programs.steam = {
  enable = true;
  remotePlay.openFirewall = true;
  dedicatedServer.openFirewall = true;
  extraPackages = with pkgs; [
    libxinerama
    libxrandr
    vulkan-loader
  ];
};

  services.searx = { 
    enable = true;
     settings = {
    use_default_settings = true;
    
    server = {
      port = 2222;
      bind_address = "0.0.0.0";
      secret_key = "2ff6bcd584334071f8dae0ad66e9d7815167ce97fb28b93f004ae64d6547553f";
      limiter = true;
    };
    
    valkey = {
      url = "unix:///run/valkey/valkey.sock?password=yourpassword&db=1";
    };
    
    checker = {
      scheduling = {
        start_after = [300 1800];
        every = [86400 90000];
      };
    };
    
    search = {
      formats = ["html" "json"];
    };
  };
  
  };

   services.openssh = { 
   enable = true;
   

   extraConfig = ''
    Match User bruh
      ForceCommand /run/current-system/sw/bin/fish
  '';

   };

  system.stateVersion = "26.05"; # Did you read the comment?
}
