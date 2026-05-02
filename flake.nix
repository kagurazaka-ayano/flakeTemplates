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
    };
  };
}
