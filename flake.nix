{
  description = "";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = {self, ...} @ inputs: {
    templates = {
      rust = {
        path = ./rust;
        description = "Rust development environment";
      };
    };
  };
}
