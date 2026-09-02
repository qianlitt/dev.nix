{
  description = "C/C++ development environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = {
    self,
    flake-parts,
    ...
  } @ inputs:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      perSystem = {
        inputs',
        pkgs,
        ...
      }: {
        devShells.default = with pkgs;
          mkShell.override {
            # Override stdenv in order to change compiler:
            # stdenv = clangStdenv;
          } {
            packages = [
              clang-tools
              cmake
              cppcheck
              lcov
            ];
          };
      };
    };
}
