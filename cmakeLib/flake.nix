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
  }: let
    buildDir = "$PWD/build";
  in
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {
          inherit system;
        };
        lib = pkgs.lib;
        llvm = pkgs.llvmPackages_latest;
        cmakegen = pkgs.writeShellScriptBin "cmakegen" ''
          mkdir -p ${buildDir}
          ${lib.getExe pkgs.cmakeMinimal} -B ${buildDir} -S $PWD -GNinja $@
        '';
        cmakebuild = pkgs.writeShellScriptBin "cmakebuild" ''
          mkdir -p ${buildDir}
          ${lib.getExe pkgs.cmakeMinimal} --build ${buildDir} $@
        '';
        cmakeclean = pkgs.writeShellScriptBin "cmakeclean" ''
          rm -rf ${buildDir}
        '';
      in {
        devShells.default = with pkgs;
          mkShell.override {stdenv = pkgs.clangStdenv;} {
            buildInputs = [
              cmakegen
              cmakebuild
              cmakeclean
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
