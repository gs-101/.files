{
  pkgs,
  ...
}:
let
  skills = pkgs.linkFarm "agent-skills" {
    caveman = pkgs.caveman;
    # Creates nested skills. Doesn't work with all agents (Claude Code, for example)!
    emacs-skills = pkgs.emacs-skills;
  };
in
{
  imports = [
    ./home/pointerCursor.nix
  ];
  home = {
    homeDirectory = "/home/gabriel";
    packages = with pkgs; [
      antigravity-cli
      ast-grep
      cryptsetup
      gimp
      inkscape
      monero-cli
      pastel
      quickemu
      tor-browser
      viu
      wasabiwallet
      zotero
    ];
    file.".agents/skills".source = skills;
    sessionVariables = {
      NIXOS_OZONE_WL = 1;
    };
    username = "gabriel";
    stateVersion = "25.11";
  };
}
