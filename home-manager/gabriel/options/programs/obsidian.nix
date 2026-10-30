{ pkgs, ... }:
{
  programs.obsidian = {
    enable = true;
    cli.enable = true;
    vaults = {
      Notes = {
        enable = true;
        settings.communityPlugins = with pkgs.obsidianPlugins; [
          obsidian-tasks-plugin
          obsidian-citation-plugin
          obsidian-zotero-desktop-connector
        ];
        target = "Documents/notes";
      };
      "Agentic Vault" = {
        enable = true;
        target = "Documents/agentic-vault";
      };
    };
  };
}
