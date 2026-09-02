{
  description = "";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = {self, ...} @ inputs: {
    templates = {
      c-cpp = {
        path = ./c-cpp;
        description = "C/C++ development environment";
      };
      c = self.templates.c-cpp;
      cpp = self.templates.c-cpp;

      rust = {
        path = ./rust;
        description = "Rust development environment";
      };
    };
  };
}
