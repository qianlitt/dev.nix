{
  description = "Rust development environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    flake-parts,
    rust-overlay,
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
      }: let
        rustToolchain = pkgs.rust-bin.fromRustupToolchainFile ./rust-toolchain.toml;
      in {
        devShells.default = with pkgs;
          mkShell {
            packages = [
              rustToolchain

              # dev tools
              rust-analyzer

              # lib
              pkg-config
              # openssl
            ];
            RUST_SRC_PATH = "${rustToolchain}/lib/rustlib/src/rust/library";
          };
      };
    };
}
