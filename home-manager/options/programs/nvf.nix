{ pkgs, ... }:
{
  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        autocomplete.blink-cmp = {
          enable = true;
          friendly-snippets.enable = true;
        };
        binds.cheatsheet.enable = true;
        gestures.gesture-nvim.enable = true;
        git.enable = true;
        languages = {
          enableTreesitter = true;
          arduino.enable = true;
          assembly.enable = true;
          bash.enable = true;
          clang.enable = true;
          clojure.enable = true;
          cmake.enable = true;
          csharp.enable = true;
          css.enable = true;
          dart.enable = true;
          elixir.enable = true;
          fsharp.enable = true;
          glsl.enable = true;
          go.enable = true;
          haskell.enable = true;
          html.enable = true;
          java.enable = true;
          json.enable = true;
          julia.enable = true;
          just.enable = true;
          kotlin.enable = true;
          lua.enable = true;
          markdown.enable = true;
          nix.enable = true;
          php.enable = true;
          python.enable = true;
          qml.enable = true;
          r.enable = true;
          ruby.enable = true;
          rust.enable = true;
          sql.enable = true;
          svelte.enable = true;
          tailwind.enable = true;
          ts.enable = true;
          typst.enable = true;
          xml.enable = true;
          yaml.enable = true;
          zig.enable = true;
        };
        navigation.harpoon.enable = true;
        projects.project-nvim.enable = true;
        statusline.lualine.enable = true;
        telescope.enable = true;
        treesitter = {
          autotagHtml = true;
          textobjects.enable = true;
        };
        ui = {
          colorful-menu-nvim.enable = true;
          colorizer.enable = true;
          illuminate.enable = true;
          modes-nvim.enable = true;
        };
        utility = {
          ccc.enable = true;
          direnv.enable = true;
          leetcode-nvim.enable = true;
          mkdir.enable = true;
          motion = {
            leap.enable = true;
          };
          multicursors.enable = true;
          oil-nvim.enable = true;
          outline.aerial-nvim.enable = true;
          sleuth.enable = true;
          surround.enable = true;
          undotree.enable = true;
          vim-wakatime.enable = true;
        };
        visuals = {
          highlight-undo.enable = true;
          nvim-web-devicons.enable = true;
        };
        withRuby = false; # Only one that's enabled by default.
      };
    };
  };
}
