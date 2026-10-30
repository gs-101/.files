{
  lib,
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
          assistant.copilot = {
            enable = true;
            setupOpts.suggestion.auto_trigger = true;
          };
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
            register = {
              "<leader>o" = lib.mkForce "+Org / Octo";
              # Keybindings for Snack that are like the ones for Telescope.
              # Should be temporary until nvf adds first-class support to snacks.picker.
              "<leader>f" = "+Find (Snacks)";
              "<leader>fl" = "+LSP";
              "<leader>fv" = "+Git";
              "<leader>fvc" = "+Commits";
            };
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
          # Keybindings for Snack that are like the ones for Telescope.
          # Should be temporary until nvf adds first-class support to snacks.picker.
          keymaps = [
            # Find / Pick (Snacks)
            {
              key = "<leader>ff";
              mode = "n";
              action = "<cmd>lua Snacks.picker.files()<CR>";
              desc = "Find files [Snacks]";
            }
            {
              key = "<leader>fg";
              mode = "n";
              action = "<cmd>lua Snacks.picker.grep()<CR>";
              desc = "Live grep [Snacks]";
            }
            {
              key = "<leader>fb";
              mode = "n";
              action = "<cmd>lua Snacks.picker.buffers()<CR>";
              desc = "Buffers [Snacks]";
            }
            {
              key = "<leader>fh";
              mode = "n";
              action = "<cmd>lua Snacks.picker.help()<CR>";
              desc = "Help tags [Snacks]";
            }
            {
              key = "<leader>ft";
              mode = "n";
              action = "<cmd>lua Snacks.picker.pickers()<CR>";
              desc = "Open pickers [Snacks]";
            }
            {
              key = "<leader>fr";
              mode = "n";
              action = "<cmd>lua Snacks.picker.resume()<CR>";
              desc = "Resume [Snacks]";
            }
            {
              key = "<leader>fp";
              mode = "n";
              action = "<cmd>lua Snacks.picker.projects()<CR>";
              desc = "Find projects [Snacks]";
            }
            {
              key = "<leader>fs";
              mode = "n";
              action = "<cmd>lua Snacks.picker.treesitter()<CR>";
              desc = "Treesitter [Snacks]";
            }
            # Git [Snacks]
            {
              key = "<leader>fvf";
              mode = "n";
              action = "<cmd>lua Snacks.picker.git_files()<CR>";
              desc = "Git files [Snacks]";
            }
            {
              key = "<leader>fvcw";
              mode = "n";
              action = "<cmd>lua Snacks.picker.git_log()<CR>";
              desc = "Git commits [Snacks]";
            }
            {
              key = "<leader>fvcb";
              mode = "n";
              action = "<cmd>lua Snacks.picker.git_log_file()<CR>";
              desc = "Git buffer commits [Snacks]";
            }
            {
              key = "<leader>fvb";
              mode = "n";
              action = "<cmd>lua Snacks.picker.git_branches()<CR>";
              desc = "Git branches [Snacks]";
            }
            {
              key = "<leader>fvs";
              mode = "n";
              action = "<cmd>lua Snacks.picker.git_status()<CR>";
              desc = "Git status [Snacks]";
            }
            {
              key = "<leader>fvx";
              mode = "n";
              action = "<cmd>lua Snacks.picker.git_stash()<CR>";
              desc = "Git stash [Snacks]";
            }
            # LSP [Snacks]
            {
              key = "<leader>flsb";
              mode = "n";
              action = "<cmd>lua Snacks.picker.lsp_symbols()<CR>";
              desc = "LSP Document Symbols [Snacks]";
            }
            {
              key = "<leader>flsw";
              mode = "n";
              action = "<cmd>lua Snacks.picker.lsp_workspace_symbols()<CR>";
              desc = "LSP Workspace Symbols [Snacks]";
            }
            {
              key = "<leader>flr";
              mode = "n";
              action = "<cmd>lua Snacks.picker.lsp_references()<CR>";
              desc = "LSP References [Snacks]";
            }
            {
              key = "<leader>fli";
              mode = "n";
              action = "<cmd>lua Snacks.picker.lsp_implementations()<CR>";
              desc = "LSP Implementations [Snacks]";
            }
            {
              key = "<leader>flD";
              mode = "n";
              action = "<cmd>lua Snacks.picker.lsp_definitions()<CR>";
              desc = "LSP Definitions [Snacks]";
            }
            {
              key = "<leader>flt";
              mode = "n";
              action = "<cmd>lua Snacks.picker.lsp_type_definitions()<CR>";
              desc = "LSP Type Definitions [Snacks]";
            }
            {
              key = "<leader>fld";
              mode = "n";
              action = "<cmd>lua Snacks.picker.diagnostics()<CR>";
              desc = "Diagnostics [Snacks]";
            }
            # Keybind for Snack terminal.
            # Should be temporary until nvf adds first-class support to snacks.terminal.
            {
              key = "<c-/>";
              mode = [ "n" "t" ];
              action = "<cmd>lua Snacks.terminal.toggle()<CR>";
              desc = "Toggle Terminal [Snacks]";
            }
            # Words [Snacks]
            {
              key = "]]";
              mode = [ "n" "t" ];
              action = "<cmd>lua Snacks.words.jump(vim.v.count1)<CR>";
              desc = "Next Reference [Snacks]";
            }
            {
              key = "[[";
              mode = [ "n" "t" ];
              action = "<cmd>lua Snacks.words.jump(-vim.v.count1)<CR>";
              desc = "Prev Reference [Snacks]";
            }
          ];
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
          notes = {
            obsidian.enable = true;
            orgmode = {
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
          };
          options = {
            linebreak = true;
            mouse = "a";
            mousefocus = true;
            mousemoveevent = true;
            wrap = true;
          };
          preventJunkFiles = true;
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
            noice.enable = true;
          };
          undoFile.enable = true;
          utility = {
            ccc.enable = true;
            diffview-nvim.enable = true;
            direnv.enable = true;
            mkdir.enable = true;
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
            snacks-nvim = {
              enable = true;
              setupOpts = {
                image.enabled = true;
                picker.enabled = true;
                terminal.enabled = true;
                words.enabled = true;
              };
            };
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
