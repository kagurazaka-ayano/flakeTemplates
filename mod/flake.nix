{
  description = "Generic NixOS/HomeManager module flake template";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    mname = "ReplaceMe";
    systems = [
      "x86_64-linux"
      "x86_64-darwin"
      "aarch64-darwin"
      "aarch64-linux"
    ];

    eachSystem = f:
      builtins.listToAttrs (
        builtins.map (system: {
          name = "${system}";
          value = {
            default = f {
              pkgs = inputs.nixpkgs.legacyPackages.${system};
              inherit system;
            };
          };
        })
        systems
      );
  in {
    _module.args = {
      inherit mname;
    };
    nixosModules = {
      ${mname} = ./modules/nixos;
      default = self.nixosModules.${mname};
    };
    homeModules = {
      ${mname} = ./modules/home;
      default = self.homeModules.${mname};
    };
    darwinModules = {
      ${mname} = ./modules/darwin;
      default = self.darwinModules.${mname};
    };
    packages =
      eachSystem ({pkgs, ...}:
        import ./default.nix {inherit pkgs mname;});
  };
}
