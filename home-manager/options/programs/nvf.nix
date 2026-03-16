{ ... }:
{
  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        autocomplete.nvim-cmp.enable = true;
        languages = {
          enableDAP = true;
          enableExtraDiagnostics = true;
          enableFormat = true;
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
        lsp.enable = true;
        statusline.lualine.enable = true;
        telescope.enable = true;
      };
    };
  };
}
