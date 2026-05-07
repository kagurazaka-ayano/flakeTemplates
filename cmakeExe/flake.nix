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
        lib = pkgs.lib;
        llvm = pkgs.llvmPackages_latest;
        cmakegen = pkgs.writeShellScriptBin "cmakegen" ''
          ${lib.getExe pkgs.cmakeMinimal} -B $PWD/build -S $PWD -GNinja $@
        '';
        cmakebuild = pkgs.writeShellScriptBin "cmakebuild" ''
          ${lib.getExe pkgs.cmakeMinimal} --build $PWD/build $@
        '';
      in {
        devShells.default = with pkgs;
          mkShell.override {stdenv = pkgs.clangStdenv;} {
            buildInputs = [
              cmakegen
              cmakebuild
              cmakeMinimal
              gnumake
              bear
              ninja

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
