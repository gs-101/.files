{ lib, pkgs, ... }:
let
  emacsSkills = lib.mapAttrs (name: _: "${pkgs.emacs-skills}/${name}") (
    lib.filterAttrs (_: type: type == "directory") (builtins.readDir pkgs.emacs-skills)
  );
in
{
  home.packages = with pkgs; [
    codex-acp
  ];
  programs.codex = {
    enable = true;
    context = ''
      You are in a system with the Nix package manager. This means that,
      in a "command not found" situation, you can try to rerun the command with
      "nix run nixpkgs#<package>", where <package> is the name of the package
      that provides the command.
    '';
    skills = {
      caveman = "${pkgs.caveman}/SKILL.md";
    }
    // emacsSkills;
  };
}
