{
  description = "Example usage of buildGradleApplication";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-24.05";

    build-gradle-application.url = "github:raphiz/buildGradleApplication";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    flake-parts,
    build-gradle-application,
    ...
  }: let
    version = self.shortRev or "dirty";
  in
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux" "x86_64-darwin" "aarch64-darwin" "aarch64-linux"];

      perSystem = {
        config,
        system,
        ...
      }: let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [build-gradle-application.overlays.default];
        };
      in {
        packages = {
          helloWorld = pkgs.callPackage ./hello-world/package.nix {
            inherit version;
          };

          springBoot = pkgs.callPackage ./spring-boot/package.nix {
            inherit version;
          };
        };

        devShells.default = with pkgs;
          mkShellNoCC {
            buildInputs = [jdk gradle updateVerificationMetadata];
          };

        formatter = pkgs.alejandra;
      };
    };
}
