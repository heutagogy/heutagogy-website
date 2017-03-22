{ pkgs ? import <nixpkgs> { }
}:
with pkgs;
let
  ruby-deps = bundlerEnv {
    name = "heutagogy-website-ruby-deps";
  
    # The only file that should be edited by hand is ./Gemfile.
    # To get a Gemfile.lock, run nix-shell -p bundler --run 'bundler lock'
    # To get a gemset.nix, run nix-shell -p bundix --run 'bundix'
    # You can update both in one go:
    # nix-shell -p bundler -p bundix --run 'bundler lock && bundix'
    gemfile = ./Gemfile;
    lockfile = ./Gemfile.lock;
    gemset = ./gemset.nix;
  };

in stdenv.mkDerivation {
  name = "heutagogy-website";

  buildInputs = [ ruby-deps ];
}
