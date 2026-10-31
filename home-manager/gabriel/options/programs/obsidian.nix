{ pkgs, ... }:
{
  programs.obsidian = {
    enable = true;
    cli.enable = true;
    package = pkgs.obsidian.overrideAttrs (oldAttrs: {
      installPhase = ''
        runHook preInstall
        mkdir -p $out/bin

        makeWrapper ${pkgs.electron}/bin/electron $out/bin/obsidian \
          --add-flags $out/share/obsidian/app.asar \
          --add-flags "''${NIXOS_OZONE_WL:+''${WAYLAND_DISPLAY:+--ozone-platform=wayland --enable-wayland-ime=true --wayland-text-input-version=3}}"
        install -m 755 -D obsidian-cli $out/bin/obsidian-cli
        install -m 444 -D resources/app.asar $out/share/obsidian/app.asar
        cp -r resources/app.asar.unpacked $out/share/obsidian/app.asar.unpacked
        install -m 444 -D resources/obsidian.asar $out/share/obsidian/obsidian.asar
        install -m 444 -D "${oldAttrs.desktopItem}/share/applications/"* \
          -t $out/share/applications/
        for size in 16 24 32 48 64 128 256 512; do
          mkdir -p $out/share/icons/hicolor/"$size"x"$size"/apps
          magick -background none ${oldAttrs.icon} -resize "$size"x"$size" $out/share/icons/hicolor/"$size"x"$size"/apps/obsidian.png
        done
        runHook postInstall
      '';
    });
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
