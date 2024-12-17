{
  description = "Example usage of buildGradleApplication";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";

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
      flake = {
        overlays.default = final: prev: let
          jdk = prev.jdk21_headless;
        in {
          jdk = jdk;
          java = jdk;
          # gradle = prev.callPackage (prev.gradleGen {
          #   version = "8.7";
          #   nativeVersion = "0.22-milestone-25";
          #   hash = "sha256-VEw11r2Emuil7QvOo5umd9xA9J330YNVYVgtogCblh0=";
          #   defaultJava = jdk;
          # }) {};
        };
      };
      perSystem = {
        config,
        system,
        ...
      }: let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [
            self.overlays.default
            build-gradle-application.overlays.default
          ];
        };
      in {
        packages = {
          helloWorld = pkgs.callPackage ./hello-world/package.nix {
            inherit version;
          };

          funkyDependencies = pkgs.callPackage ./funky-dependencies/package.nix {
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
