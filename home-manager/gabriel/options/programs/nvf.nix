{
  lib,
  options,
  pkgs,
  ...
}:
let
  inherit (lib.generators) mkLuaInline;
in
{
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };
  programs = {
    antigravity-cli.settings.editorMode = "vim";
    atuin.settings.keymap_mode = "vim-insert";
    git.settings = {
      diff.tool = "nvimdiff";
      merge.tool = "nvimdiff";
    };
    nvf = {
      defaultEditor = true;
      enable = true;
      settings = {
        vim = {
          extraPackages = with pkgs; [
            copilot-language-server
            fd
            ripgrep
            sqlite
          ];
          assistant.copilot.enable = true;
          autocmds = [
            {
              desc = "Make script files executable on save (like Emacs executable-make-buffer-file-executable-if-script-p).";
              event = [ "BufWritePost" ];
              callback = mkLuaInline ''
                function(args)
                  local first_line = vim.api.nvim_buf_get_lines(args.buf, 0, 1, false)[1] or ""
                  if first_line:match("^#!") then
                    local file = vim.api.nvim_buf_get_name(args.buf)
                    if file ~= "" then
                      vim.fn.setfperm(file, "rwxr-xr-x")
                    end
                  end
                end
              '';
            }
            {
              desc = "Go prettify symbols (walrus := and go keyword)";
              event = [ "FileType" ];
              pattern = [ "go" ];
              callback = mkLuaInline ''
                function()
                  vim.opt_local.conceallevel = 2
                  vim.fn.matchadd("Conceal", ":=", 10, -1, { conceal = "󰟓" })
                  vim.fn.matchadd("Conceal", "\\<go\\>", 10, -1, { conceal = "󰟓" })
                end
              '';
            }
          ];
          autocomplete.blink-cmp = {
            enable = true;
            friendly-snippets.enable = true;
            setupOpts = {
              completion.list.cycle = {
                from_bottom = true;
                from_top = true;
              };
            };
          };
          autopairs.nvim-autopairs.enable = true;
          bell = "none";
          binds.whichKey = {
            enable = true;
            register."<leader>o" = lib.mkForce "+Org / Octo";
          };
          debugger.nvim-dap = {
            enable = true;
            ui.enable = true;
          };
          extraPlugins = with pkgs.vimPlugins; {
            compiler-explorer-nvim = {
              package = compiler-explorer-nvim;
              setup = "require('compiler-explorer').setup {}";
            };
            devdocs-nvim = {
              package = devdocs-nvim;
              setup = "require('devdocs').setup {}";
            };
            helpview-nvim = {
              package = helpview-nvim;
              setup = "require('helpview').setup {}";
            };
            nabla-nvim = {
              package = nabla-nvim;
              setup = ''
                vim.api.nvim_create_autocmd('FileType', {
                  pattern = { 'org', 'tex', 'markdown' },
                  callback = function()
                    require('nabla').enable_virt { autogen = true, silent = true }
                  end,
                })
              '';
            };
            notmuch-nvim = {
              package = notmuch-nvim;
              setup = "require('notmuch').setup {}";
            };
            nvim-coverage = {
              package = nvim-coverage;
              setup = "require('coverage').setup {}";
            };
            nvim-paredit = {
              package = nvim-paredit;
              setup = "require('nvim-paredit').setup {}";
            };
            org-roam-nvim = {
              package = org-roam-nvim;
              setup = ''
                require('org-roam').setup {
                  directory = '~/Documents/org-roam',
                  org_files = { '~/Documents/org' },
                  templates = {
                    d = {
                      description = 'default',
                      template = '* %?',
                      target = '%<%Y-%m-%d>.org',
                    },
                    b = {
                      description = 'bibliographic',
                      template = '%?',
                      target = '%<%Y%m%d%H%M%S>-%^{citekey}.org',
                    },
                  },
                }
              '';
              after = [ "orgmode" ];
            };
            overseer-nvim = {
              package = overseer-nvim;
              setup = "require('overseer').setup {}";
            };
            zotcite = {
              package = zotcite;
              setup = ''
                vim.g.zotcite_filetypes = { 'markdown', 'org', 'tex', 'rmd', 'quarto' }
              '';
            };
          };
          formatter.conform-nvim.enable = true;
          gestures.gesture-nvim.enable = true;
          git = {
            enable = true;
            neogit.enable = true;
            octo-nvim.enable = true;
          };
          languages = {
            enableDAP = true;
            enableFormat = true;
            enableTreesitter = true;
            arduino.enable = true;
            assembly.enable = true;
            astro.enable = true;
            bash.enable = true;
            clang.enable = true;
            clojure.enable = true;
            cmake.enable = true;
            csharp.enable = true;
            css.enable = true;
            dart = {
              enable = true;
              flutter-tools.enable = true;
            };
            elixir.enable = true;
            fsharp.enable = true;
            glsl.enable = true;
            go.enable = true;
            haskell = {
              enable = true;
              extensions.haskell-tools.enable = true;
            };
            helm.enable = true;
            html.enable = true;
            java.enable = true;
            json.enable = true;
            julia.enable = true;
            just.enable = true;
            kotlin.enable = true;
            lisp.enable = true;
            lua.enable = true;
            markdown.enable = true;
            nix = {
              enable = true;
              lsp.servers = [ "nixd" ];
            };
            php.enable = true;
            python.enable = true;
            qml.enable = true;
            r.enable = true;
            ruby.enable = true;
            rust.enable = true;
            sql.enable = true;
            svelte.enable = true;
            tex.enable = true;
            typescript.enable = true;
            typst.enable = true;
            vue.enable = true;
            xml.enable = true;
            yaml.enable = true;
            zig.enable = true;
          };
          lineNumberMode = "relNumber";
          lsp = {
            enable = true;
            presets.tailwindcss-language-server.enable = true;
          };
          navigation.harpoon.enable = true;
          notes.orgmode = {
            enable = true;
            setupOpts = {
              org_agenda_files = [
                "~/Documents/org/**/*"
                "~/Documents/org-roam/**/*"
              ];
              org_default_notes_file = "~/Documents/org-roam/inbox.org";
              org_todo_keywords = [
                "TODO(t)"
                "WAIT(w)"
                "|"
                "DONE(d)"
                "BACKLOG(b)"
                "CANCELLED(c)"
                "FIX(f)"
                "FEAT(F)"
                "DOCS(D)"
                "STYLE(s)"
                "REFACTOR(r)"
                "CHORE(C)"
                "|"
                "MERGED(m)"
                "CLOSED(x)"
              ];
              org_log_done = "time";
              org_log_into_drawer = "LOGBOOK";
              org_tags_column = 0;
              org_agenda_skip_scheduled_if_done = true;
              org_agenda_skip_deadline_if_done = true;
            };
          };
          options = {
            linebreak = true;
            mouse = "a";
            mousefocus = true;
            mousemoveevent = true;
            shiftwidth = 2;
            tabstop = 2;
            wrap = true;
          };
          preventJunkFiles = true;
          projects.project-nvim.enable = true;
          repl.conjure.enable = true;
          searchCase = "smart";
          statusline.lualine = {
            enable = true;
            # Temporary workaround for Neovim 0.12 floating window statuslines
            # triggered by lualine.refresh({ scope = "window" }) (e.g. via vim-wakatime).
            setupOpts.options.ignore_focus = mkLuaInline ''
              (function()
                local nvim_opts = require("lualine.utils.nvim_opts")
                local orig_set = nvim_opts.set
                nvim_opts.set = function(name, val, opts)
                  if name == "statusline" and opts and opts.window and vim.fn.win_gettype(opts.window) == "popup" then
                    return
                  end
                  return orig_set(name, val, opts)
                end
                return function(win)
                  return vim.fn.win_gettype(win) == "popup"
                end
              end)()
            '';
          };
          telescope.enable = true;
          terminal.toggleterm.enable = true;
          treesitter = {
            autotagHtml = true;
            grammars = with pkgs.vimPlugins.nvim-treesitter.grammarPlugins; [
              hyprlang
              kdl
              meson
            ];
            textobjects.enable = true;
          };
          ui = {
            colorful-menu-nvim.enable = true;
            illuminate.enable = true;
            noice.enable = true;
          };
          undoFile.enable = true;
          utility = {
            ccc.enable = true;
            diffview-nvim.enable = true;
            direnv.enable = true;
            images.image-nvim = {
              enable = true;
              setupOpts.backend = "kitty";
            };
            leetcode-nvim = {
              enable = true;
              setupOpts.storage.home = mkLuaInline "vim.fn.expand('~/Projects/study/leetcode-solutions/')";
            };
            mkdir.enable = true;
            motion.leap.enable = true;
            multicursors.enable = true;
            oil-nvim = {
              enable = true;
              gitStatus.enable = true;
              setupOpts = {
                default_file_explorer = true;
                delete_to_trash = true;
                skip_confirm_for_simple_edits = true;
              };
            };
            outline.aerial-nvim.enable = true;
            sleuth.enable = true;
            surround.enable = true;
            vim-wakatime.enable = true;
          };
          visuals = {
            highlight-undo.enable = true;
            nvim-web-devicons.enable = true;
            rainbow-delimiters.enable = true;
          };
        };
      };
    };
    readline = {
      enable = true;
      variables.editing-mode = "vi";
    };
    television.settings.keybindings = {
      ctrl-b = "select_prev_page";
      ctrl-d = "scroll_preview_half_page_down";
      ctrl-f = "select_next_page";
      ctrl-j = "select_next_entry";
      ctrl-k = "select_prev_entry";
      ctrl-shift-j = "scroll_preview_down";
      ctrl-shift-k = "scroll_preview_up";
      ctrl-u = "scroll_preview_half_page_up";
      ctrl-w = "delete_prev_word";
    };
    zathura = {
      mappings = {
        "<C-d>" = "scroll half-down";
        "<C-i>" = "jumplist forward";
        "<C-o>" = "jumplist backward";
        "<C-u>" = "scroll half-up";
        "D" = "toggle_page_mode";
        "H" = "navigate previous";
        "L" = "navigate next";
        "R" = "rotate rotate-ccw";
        "d" = "scroll half-down";
        "r" = "rotate rotate-cw";
        "u" = "scroll half-up";
      };
      options = {
        synctex = true;
        synctex-editor-command = "nvim --remote-silent +%{line} '%{input}'";
      };
    };
  };
}
