{ inputs, lib, config, pkgs, ... }: {
  imports = [
    # If you want to use modules from other flakes (such as nixos-hardware):
    # inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.common-ssd

    ./hardware-configuration.nix
    ../system/xserver.nix
    ../system/nvidia.nix

    # Impermanence
    inputs.impermanence.nixosModules.impermanence
  ];

  environment = {
    persistence = {
      "/persist/data" = {
        users.getpsyched = {
          directories = [
            ".ssh"
            "backgrounds"
            "git"
          ];
        };
      };

      "/persist/data/bigdata" = {
        users.getpsyched = {
          directories = [
            ".atlauncher"
            ".local/share/Steam"
            ".osu"
            "Games"
            "My Games"
          ];
        };
      };

      "/persist/data/system" = {
        directories = [
          "/etc/nixos"
          "/var/lib"
        ];
      };

      "/persist/state" = {
        users.getpsyched = {
          directories = [
            ".config/Code"
            ".config/legendary"
            ".local/share/direnv/allow"
            ".minecraft"
            ".mozilla"
            ".railway"
            ".rustup"
            ".steam"
            ".vscode"
          ];
          files = [
            ".local/share/nix/trusted-settings.json"
          ];
        };
      };

      "/persist/state/system" = {
        directories = [
          "/etc/NetworkManager"
        ];
      };

      "/var/cache" = {
        directories = [
          "/home/getpsyched/.cache"
        ];
      };
    };
  };

  time.timeZone = "Asia/Dubai";

  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  users.users.getpsyched = {
    initialPassword = "test";
    isNormalUser = true;
    description = "Priyanshu";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # Adding steam here because it is buggy with Home Manager
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  # Fix for https://nix-community.github.io/home-manager/index.html#_why_do_i_get_an_error_message_about_literal_ca_desrt_dconf_literal_or_literal_dconf_service_literal
  programs.dconf.enable = false;

  nixpkgs = {
    overlays = [
      # If you want to use overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];

    config = {
      allowUnfree = true;
    };
  };

  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };

    # This will add each flake input as a registry
    # To make nix3 commands consistent with your flake
    registry = lib.mapAttrs (_: value: { flake = value; }) inputs;

    # This will additionally add your inputs to the system's legacy channels
    # Making legacy nix commands consistent as well, awesome!
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

    settings = {
      auto-optimise-store = true;
      experimental-features = "nix-command flakes";
      warn-dirty = false;

      # Setup Cachix to avoid building packages (useful for wine)
      substituters = [ "https://nix-gaming.cachix.org" ];
      trusted-public-keys = [ "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4=" ];
    };
  };

  system.stateVersion = "22.11";
}
