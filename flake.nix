{
  description = "A collection of my own flake template shorthands";

  outputs = {...}: {
    templates = {
      rust = {
        path = ./rust;
        description = "Rust toolchain";
      };
      rust-with-ci = {
        path = ./rust-with-ci;
        description = "Rust toolchain with github CI configuration";
      };
      cmake-exe = {
        path = ./cmake-exe;
        description = "Cmake executable project";
      };
      cmake-lib = {
        path = ./cmake-lib;
        description = "Cmake library project";
      };
      devshell = {
        path = ./devshell;
        description = "Arbitrary dev shell with flake utils";
      };
      module = {
        path = ./mod;
        description = "Generic NixOS/HomeManager module flake template";
      };
    };
  };
}
