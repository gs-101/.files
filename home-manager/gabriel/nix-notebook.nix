{
  imports = [
    ./default.nix
    ./desktop.nix
    ./options/programs/umbriel.nix
  ];
  "programs" = {
    prismlauncher.enable = true;
    umbriel.settings.input.keyboard.layout = "br";
  };
}
