{ lib, pkgs, ... }:
let
  emacsSkills = lib.mapAttrs (name: _: "${pkgs.emacs-skills}/${name}") (
    lib.filterAttrs (_: type: type == "directory") (builtins.readDir pkgs.emacs-skills)
  );
in
{

  programs.antigravity-cli = {
    enable = true;
    context = {
      AGENTS = ''
        You are in a system with the Nix package manager. This means that,
        in a "command not found" situation, you can try to rerun the command with
        "nix run nixpkgs#<package>", where <package> is the name of the package
        that provides the command.
      '';
    };
    settings = {
      enableTerminalSandbox = true;
      context.fileName = [
        "AGENTS.md"
        "GEMINI.md"
        "CLAUDE.md"
      ];
      toolPermission = "proceed-in-sandbox";
      useG1Credits = true;
    };
    skills = {
      caveman = "${pkgs.caveman}/SKILL.md";
    }
    // emacsSkills;
  };
}
