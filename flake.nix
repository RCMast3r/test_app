{
  description = "simple c++ oriented flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
    utils.url = "github:numtide/flake-utils";
    test_lib.url = "github:RCMast3r/test_lib";
    easy_cmake.url = "github:RCMast3r/easy_cmake";
  };
  outputs = { self, nixpkgs, utils, test_lib, easy_cmake }:
    let
      this_projects_overlay = final: prev: {
        test_app_pkg = final.callPackage ./default.nix { };
      };
      my_overlays = [ this_projects_overlay test_lib.overlays.default ];
      pkgs = import nixpkgs {
        system = "x86_64-linux";
        overlays = [ self.overlays.default ];
      };
    in
    {
      overlays.default = nixpkgs.lib.composeManyExtensions my_overlays;

      packages.x86_64-linux =
        let
          pkgs = import nixpkgs {
            system = "x86_64-linux";
            overlays = [ self.overlays.default ];
          };
        in
        rec {
          test_app_pkg = pkgs.test_app_pkg;
          default = test_app_pkg;
        };
      devShells.x86_64-linux.default =
        pkgs.mkShell rec {
          # Update the name to something that suites your project.
          name = "nix-devshel2l";
          packages = with pkgs; [
            # Development Tools
            cmake
            gdb
            test_libyo
          ];

          # Setting up the environment variables you need during
          # development.
          shellHook =
            let
              icon = "f121";
            in
            ''
              export test=${pkgs.test_libyo}
              export PS1="$(echo -e '\u${icon}') {\[$(tput sgr0)\]\[\033[38;5;228m\]\w\[$(tput sgr0)\]\[\033[38;5;15m\]} (${name}) \\$ \[$(tput sgr0)\]"
            '';
        };

    };
}
