{ pkgs, ... }:
{
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
    };
  };
}
