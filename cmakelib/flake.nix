{
  description = "cpp with cmake";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    nixpkgs,
    flake-utils,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {
          inherit system;
        };
        llvm = pkgs.llvmPackages_latest;
      in {
        devShells.default = with pkgs;
          mkShell.override {stdenv = pkgs.clangStdenv;} {
            buildInputs = [
              cmakeMinimal
              gnumake
              bear

              # debugger
              llvm.lldb
              gdb

              # fix headers not found
              clang-tools

              # LSP and compiler
              llvm.libstdcxxClang

              # other tools
              cppcheck
              llvm.libllvm
              valgrind

              # stdlib for cpp
              llvm.libcxx
            ];
          };
      }
    );
}
