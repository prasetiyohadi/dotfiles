{
  description = "Pras' Nix Config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixpkgs-unstable";
    snowfall-lib = {
      url = "github:snowfallorg/lib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim.url = "github:nix-community/nixvim";
    copilotchat-nvim = {
      url = "github:copilotc-nvim/copilotchat.nvim";
      flake = false;
    };
    superfile = {
      url = "github:MHNightCat/superfile";
    };
  };

  outputs = inputs:
    inputs.snowfall-lib.mkFlake {
      # You must provide our flake inputs to Snowfall Lib.
      inherit inputs;

      # The `src` must be the root of the flake. See configuration
      # in the next section for information on how you can move your
      # Nix files to a separate directory.
      src = ./.;

      # snowfall = {
      #   metadata = "snowflake";
      #   namespace = "snowflake";
      #   meta = {
      #     name = "snowflake";
      #     title = "Pras' Nix Flake";
      #   };
      # };

      channels-config = {
        allowUnfree = true;
      };

      # systems.modules.nixos = with inputs; [
      #   home-manager.nixosModules.home-manager
      # ];

      # systems.hosts.16ach6h.modules = with inputs; [];

      home.modules = with inputs; [
        home-manager.homeModules.cli
      ];

      outputs-builder = channels: {
        packages.default = inputs.home-manager.defaultPackage.${channels.nixpkgs.system};
      };

      # packages = {
      #   default = home-manager.defaultPackage.${system};
      #   homeConfigurations.pras = home-manager.lib.homeManagerConfiguration {
      #     inherit pkgs;
      #     modules = [
      #       nixvim.homeManagerModules.nixvim
      #       ./home.nix
      #     ];
      #   };
      # };
    };
}
