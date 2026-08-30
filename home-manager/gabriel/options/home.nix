{
  pkgs,
  ...
}:
let
  skills = pkgs.symlinkJoin {
    name = "agent-skills";
    paths = [
      (pkgs.linkFarm "caveman-skill" {
        caveman = pkgs.caveman;
      })
      pkgs.emacs-skills
    ];
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
    file = {
      ".agents/skills".source = skills;
      ".gemini/skills".source = skills;
    };
    sessionVariables = {
      NIXOS_OZONE_WL = 1;
    };
    username = "gabriel";
    stateVersion = "25.11";
  };
}
