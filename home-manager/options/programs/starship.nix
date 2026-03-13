{ lib, ... }:
{
  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    enableInteractive = true;
    settings = {
      add_newline = false;
      follow_symlinks = true;
      format = lib.concatStrings [
        "$all"
        "$directory"
        "$character "
      ];
      aws = {
        disabled = false;
        expiration_symbol = "󰚭";
        force_display = false;
        format = lib.concatStrings [
          "on "
          "[$symbol ($profile \($region\) )]"
          "$(style)"
        ];
        # Amazon logo color.
        style = "bold #ff9a00";
        symbol = "󰸏";
      };
      azure = {
        disabled = false;
        format = lib.concatStrings [
          "on "
          "[$symbol ($username )]"
          "($style)"
        ];
        # Azure logo color.
        style = "bold #2173b9";
        symbol = "󰠅";
      };
      battery = {
        # Disabled as it will display in whatever bar I'm using.
        disabled = true;
      };
      buf = {
        disabled = false;
        format = lib.concatStrings [
          "with "
          "[$symbol ($version )]"
          "($style)"
        ];
        # Darkest color of the logo.
        style = "bold #0e5df5";
        symbol = "󰚉";
        version_format = "$raw";
      };
      bun = {
        disabled = false;
        format = lib.concatStrings [
          "via "
          "[$symbol ($version )]($style)"
        ];
        # Main color of the logo.
        style = "bold #fbf0df";
        symbol = "";
        version_format = "$raw";
      };
      c = {
        disabled = false;
        format = lib.concatStrings [
          "via "
          "[$symbol (($name )$version )]"
          "($style)"
        ];
        # Darkest color of the logo.
        style = "bold #004283";
        version_format = "$raw";
        symbol = "";
      };
      # Regular prompt symbol.
      character = {
        disabled = false;
        error_symbol = lib.concatStrings [
          "[λ]"
          "(bold red)"
        ];
        success_symbol = lib.concatStrings [
          "[λ]"
          "(bold)"
        ];
        vimcmd_symbol = lib.concatStrings [
          "[]"
          "(bold #019331)"
        ];
        vimcmd_replace_one_symbol = lib.concatStrings [
          "[]"
          "(bold #019331)"
        ];
        vimcmd_replace_symbol = lib.concatStrings [
          "[]"
          "(bold #019331)"
        ];
        vimcmd_visual_symbol = lib.concatStrings [
          "[]"
          "(bold white)"
        ];
      };
      cmake = {
        disabled = false;
        format = lib.concatStrings [
          "via [$symbol ($version )]($style)"
        ];
        style = "bold #003764";
        symbol = "";
        version_format = "$raw";
      };
      cobol = {
        disabled = false;
        format = lib.concatStrings [
          "via "
          "[$symbol ($version )]"
          "($style)"
        ];
        style = "bold blue";
        symbol = "󰒓";
        version_format = "$raw";
      };
      cmd_duration = {
        disabled = false;
        format = lib.concatStrings [
          "[󰞌 $duration ]"
          "($style)"
        ];
        min_time = 2000;
        min_time_to_notify = 45000;
        show_milliseconds = false;
        show_notifications = false;
        style = "bold blue";
      };
      conda = {
        # Disabled as I'll probaly not remember to disable the Conda prompt
        # if I end up using it.
        disabled = true;
      };
      container = {
        disabled = false;
        format = lib.concatStrings [
          "[$symbol ($name )]"
          "($style)"
        ];
        style = "bold red";
        symbol = "";
      };
      crystal = {
        disabled = false;
        format = lib.concatStrings [
          "via "
          "[$symbol ($version )]"
          "($style)"
        ];
        style = "bold black";
        version_format = "$raw";
      };
      daml = {
        disabled = false;
        format = lib.concatStrings [
          "via "
          "[$symbol ($version )]"
          "($style)"
        ];
        style = "bold #21356a";
        symbol = "A";
        version_format = "$raw";
      };
      dart = {
        disabled = false;
        format = lib.concatStrings [
          "via "
          "[$symbol ($version )]"
          "($style)"
        ];
        # Darkest color of the logo.
        style = "bold #04599c";
        symbol = "";
        version_format = "$raw";
      };
      deno = {
        disabled = false;
        format = lib.concatStrings [
          "via "
          "[$symbol ($version )]"
          "($style)"
        ];
        symbol = "";
        style = "bold black";
        version_format = "$raw";
      };
      directory = {
        disabled = false;
        format = lib.concatStrings [
          "[$path ($read_only )]"
          "($style)"
        ];
        read_only = "󰂽";
        repo_root_format = lib.concatStrings [
          "[$before_root_path]"
          "($before_root_path_style)"
          "[$repo_root]"
          "($repo_root_style)"
          "[$path ($read_only_symbol )]"
          "($style)"
        ];
        style = "bold";
        # Try to avoid truncation as much as possible.
        truncation_length = 10;
        # But allow it for repositories.
        truncate_to_repo = true;
        truncation_symbol = "";
        use_os_path_sep = true;
      };
      direnv = {
        # Disabled because I don't like the look.
        disabled = true;
      };
      docker_context = {
        disabled = false;
        format = lib.concatStrings [
          "via "
          "[$symbol $context ]"
          "($style)"
        ];
        only_with_files = true;
        # Color of the logo.
        style = "bold #0092e6";
        symbol = "󰡨";
      };
      dotnet = {
        disabled = false;
        format = lib.concatStrings [
          "via "
          "[$symbol ($version) (󰓾 $tfm )]"
          "($style)"
        ];
        heuristic = true;
        # Color of the logo.
        style = "bold #5027d5";
        symbol = "";
        version_format = "$raw";
      };
      elixir = {
        disabled = false;
        format = lib.concatStrings [
          "via "
          "[$symbol ($version )]"
          "($style)"
        ];
        # Darkest color of the logo.
        style = "bold #481e5e";
        symbol = "";
        version_format = "$raw";
      };
      elm = {
        disabled = false;
        format = lib.concatStrings [
          "via "
          "[$symbol ($version )]"
          "($style)"
        ];
        # Blue color of the logo.
        style = "bold #60b5cc";
        symbol = "";
        version_format = "$raw";
      };
      erlang = {
        disabled = false;
        format = lib.concatStrings [
          "via "
          "[$symbol ($version )]"
          "($style)"
        ];
        # Color of the logo.
        style = "bold #a40531";
        symbol = "";
        version_format = "$raw";
      };
      fennel = {
        disabled = false;
        format = lib.concatStrings [
          "via "
          "[$symbol ($version )]"
          "($style)"
        ];
        # Main color of the logo.
        style = "bold #fff3d7";
        symbol = "";
        version_format = "$raw";
      };
      fossil_branch = {
        disabled = false;
        format = lib.concatStrings [
          "on "
          "[$symbol $branch ]"
          "($style)"
        ];
        # Main color of the logo.
        style = "bold #5c8294";
        symbol = "󰘬";
      };
      fossil_metrics = {
        disabled = false;
        added_style = "bold green";
        deleted_style = "bold red";
        format = lib.concatStrings [
          "[(󰐖 $added )]"
          "($added_style)"
          "[(󰍵 $deleted )]"
          "($deleted_style)"
        ];
        only_nonzero_diffs = true;
      };
      gcloud = {
        disabled = false;
        format = lib.concatStrings [
          "on "
          "[$symbol $account (@$domain )($project )]"
          "($style)"
        ];
        # Red of the Google logo.
        style = "bold #ea4335";
        symbol = "󱇶";
      };
      git_branch = {
        disabled = false;
        always_show_remote = false;
        format = lib.concatStrings [
          "on "
          "[$symbol $branch ]"
          "($style)"
        ];
        only_attached = true;
        # Color of the logo.
        style = "bold #f05133";
        symbol = "󰘬";
      };
      git_commit = {
        disabled = false;
        format = lib.concatStrings [
          "[$hash $tag ]"
          "($style)"
        ];
        only_detached = true;
        # Color of the logo.
        style = "bold #f05133";
        tag_disabled = false;
        tag_max_candidates = 0;
        tag_symbol = "󰓹";
      };
      git_metrics = {
        disabled = false;
        added_style = "bold green";
        deleted_style = "bold red";
        format = lib.concatStrings [
          "[(󰐖 $added )]"
          "($added_style)"
          "[(󰍵 $deleted )]"
          "($deleted_style)"
        ];
        ignore_submodules = true;
        only_nonzero_diffs = true;
      };
      git_state = {
        disabled = false;
        format = lib.concatStrings [
          "[$state ($progress_current/$progress_total )]"
          "($style)"
        ];
        am = "󰇮";
        am_or_rebase = "󰇮/󰥵";
        bisect = "";
        cherry_pick = "";
        merge = "󰽜";
        rebase = "󰥵";
        revert = "󰒫";
        # Color of the logo.
        style = "bold #f05133";
      };
      git_status = {
        # Didn't like the look, I prefer the git_metrics module.
        disabled = true;
      };
      golang = {
        # (Guile) Scheme files compile down to .go.
        detect_extensions = [
          "go"
          "!scm"
        ];
        disabled = false;
        format = lib.concatStrings [
          "via "
          "[$symbol ($version )]"
          "($style)"
        ];
        # Color of the Gopher.
        style = "bold #6ad7e5";
        symbol = "";
        version_format = "$raw";
      };
      guix_shell = {
        disabled = false;
        format = lib.concatStrings [
          "via "
          "[$symbol ]"
          "($style)"
        ];
        # Darkest color of the logo.
        style = "bold #ff5f00";
        symbol = "";
      };
      gradle = {
        disabled = false;
        format = lib.concatStrings [
          "via "
          "[$symbol ($version )]"
          "($style)"
        ];
        recursive = false;
        # Main color of the blue logo.
        # Gradle seems to have many different logos.
        style = "bold #39b6c2";
        symbol = "";
        version_format = "$raw";
      };
      haskell = {
        disabled = false;
        format = lib.concatStrings [
          "via "
          "[$symbol ($version )]"
          "($style)"
        ];
        # Darkest color of the logo.
        style = "bold #433762";
        symbol = "󰲒";
      };
      haxe = {
        disabled = false;
        format = lib.concatStrings [
          "via "
          "[$symbol ($version )]"
          "($style)"
        ];
        # Darkest color of the logo.
        style = "bold #f25c19";
        symbol = "";
        version_format = "$raw";
      };
      helm = {
        disabled = false;
        format = lib.concatStrings [
          "via "
          "[$symbol ($version )]"
          "($style)"
        ];
        # Color of the logo.
        style = "bold #0f1689";
        symbol = "";
        version_format = "$raw";
      };
      hostname = {
        disabled = false;
        format = lib.concatStrings [
          "on "
          "[$ssh_symbol]"
          "($style)"
          " on "
          "[$hostname ]"
          "($style)"
        ];
        ssh_only = true;
        style = "bold white";
        ssh_symbol = "󰣀";
        trim_at = ".";
      };
      java = {
        disabled = false;
        format = lib.concatStrings [
          "via "
          "[$symbol ($version )]"
          "($style)"
        ];
        # Color of the orange logo.
        style = "bold #f89917";
        symbol = "󰬷";
        version_format = "$raw";
      };
      jobs = {
        disabled = false;
        format = lib.concatStrings [
          "[$symbol $number ]"
          "($style)"
        ];
        number_threshold = 2;
        style = "bold yellow";
        symbol = "";
        symbol_threshold = 1;
      };
      julia = {
        disabled = false;
        format = lib.concatStrings [
          "via "
          "[$symbol ($version )]"
          "($style)"
        ];
        # Purple of the logo.
        style = "bold #aa79c1";
        symbol = "";
        version_format = "$raw";
      };
      kotlin = {
        disabled = false;
        format = lib.concatStrings [
          "via "
          "[$symbol ($version )]"
          "($style)"
        ];
        kotlin_binary = "kotlin";
        # Darkest color of the logo.
        style = "bold #b71fe8";
        symbol = "󱈙";
        version_format = "$raw";
      };
      kubernetes = {
        # Requires additional configuration.
        disabled = true;
      };
      localip = {
        # Don't want to flaunt my IP address.
        disabled = true;
      };
      lua = {
        disabled = false;
        format = lib.concatStrings [
          "via "
          "[$symbol ($version )]"
          "($style)"
        ];
        # Color of the logo.
        style = "bold #00007c";
        symbol = "󰢱";
        version_format = "$raw";
      };
      memory_usage = {
        # Don't want to be anxious about my system.
        # This data can be viewed from something like btop.
        disabled = true;
      };
      meson = {
        disabled = false;
        format = lib.concatStrings [
          "via "
          "[$symbol $project ]"
          "($style)"
        ];
        # Color of the logo.
        style = "bold #39207c";
        symbol = "󰔶";
      };
      hg_branch = {
        disabled = false;
        format = lib.concatStrings [
          "on "
          "[$symbol $branch (:$topic )]"
          "($style)"
        ];
        # Main color of the logo.
        style = "bold #999999";
        symbol = "󰘬";
      };
      mojo = {
        disabled = false;
        format = lib.concatStrings [
          "with "
          "[$symbol ($version )]"
          "($style)"
        ];
        style = "bold black";
        symbol = "󰬔";
      };
      nats = {
        disabled = false;
        format = lib.concatStrings [
          "[$symbol $name ]"
          "($style)"
        ];
        # Darkest color of the logo.
        style = "bold #c75c93";
        symbol = "󰭹";
      };
      nim = {
        disabled = false;
        format = lib.concatStrings [
          "via "
          "[$symbol ($version )]"
          "($style)"
        ];
        # Darkest color of the logo.
        style = "bold #f3d400";
        symbol = "";
        version_format = "$raw";
      };
      nix_shell = {
        disabled = false;
        format = lib.concatStrings [
          "via "
          "[$symbol ]"
          "($style)"
        ];
        # Enables support for the "nix shell" command.
        heuristic = true;
        impure_msg = "󱎶";
        # Darkest color of the logo.
        style = "bold 496aaf";
        pure_msg = "";
        symbol = "󱄅";
        unknown_msg = "?";
      };
      nodejs = {
        # Disable when Bun is detected.
        detect_files = [
          "package.json"
          ".node-version"
          "!bun.lock"
          "!bun.lockb"
          "!bunfig.toml"
        ];
        disabled = false;
        format = lib.concatStrings [
          "via "
          "[$symbol ($version )]"
          "($style)"
        ];
        version_format = "$raw";
        # Darkest color of the logo.
        style = "bold #3e863d";
        symbol = "󰎙";
      };
      ocaml = {
        disabled = false;
        format = lib.concatStrings [
          "via "
          "[$symbol ($version )(\($switch_indicator$switch_name\) )]"
          "($style)"
        ];
        # Darkes color of the logo.
        style = "bold #ed6806";
        symbol = "";
        version_format = "$raw";
      };
      odin = {
        disabled = false;
        format = lib.concatStrings [
          "via "
          "[$symbol ($version )]"
          "($style)"
        ];
        show_commit = false;
        # Color of the homepage banner.
        style = "bold #3882d2";
        symbol = "ᛟ";
      };
      opa = {
        disabled = false;
        format = lib.concatStrings [
          "via "
          "[$symbol ($version )]"
          "($style)"
        ];
        # Color from the header in the homepage.
        style = "bold #566366";
        symbol = "󰡘";
        version_format = "$raw";
      };
      openstack = {
        disabled = false;
        format = lib.concatStrings [
          "on "
          "[$symbol $cloud (\($project\) )]"
          "($style)"
        ];
        # Color of the logo.
        style = "bold #f20b4b";
        symbol = "";
      };
      os = {
        # According to documentation, this can be inaccurate.
        disabled = true;
      };
      package = {
        # Rare.
        disabled = true;
      };
      perl = {
        disabled = false;
        format = lib.concatStrings [
          "via "
          "[$symbol ($version )]"
          "($style)"
        ];
        # Color from the O"Reilly book.
        style = "bold #009bcb";
        symbol = "";
        version_format = "$raw";
      };
      php = {
        disabled = false;
        format = lib.concatStrings [
          "via "
          "[$symbol ($version )]"
          "($style)"
        ];
        # Color from the regular logo, not the elephant.
        style = "bold #7377ad";
        symbol = "󰌟";
        version_format = "$raw";
      };
      pijul_channel = {
        disabled = false;
        format = lib.concatStrings [
          "on "
          "[$symbol $channel ]"
          "($style)"
        ];
        style = "bold black";
        symbol = "󰘬";
      };
      pulumi = {
        disabled = false;
        format = lib.concatStrings [
          "via "
          "[$symbol ($username@)$stack ]"
          "($style)"
        ];
        search_upwards = true;
        # Purple color of the logo.
        style = "bold #8a3391";
        symbol = "";
        version_format = "$raw";
      };
      purescript = {
        disabled = false;
        format = lib.concatStrings [
          "via "
          "[$symbol ($version )]"
          "($style)"
        ];
        style = "bold white";
        symbol = "";
        version_format = "$raw";
      };
      python = {
        disabled = false;
        format = lib.concatStrings [
          "via "
          "[$symbol ($pyenv_prefix )($version )(\($virtualenv\) )]"
          "($style)"
        ];
        pyenv_version_name = false;
        pyenv_prefix = "env";
        # Yellow color of the logo.
        style = "bold #f7cc40";
        symbol = "󰌠";
        version_format = "$raw";
      };
      quarto = {
        disabled = false;
        format = lib.concatStrings [
          "via "
          "[$symbol ($version )]"
          "($style)"
        ];
        # Color from this banner:
        # https://web.archive.org/web/20241010044838im_/https://posit.co/wp-content/uploads/2022/10/thumbnail-2.jpg
        style = "bold #3e79a1";
        symbol = "⨁";
        version_format = "$raw";
      };
      rlang = {
        disabled = false;
        format = lib.concatStrings [
          "via "
          "[$symbol ($version )]"
          "($style)"
        ];
        version_format = "$raw";
        # Main color of the logo.
        style = "bold #1c61b0";
        symbol = "";
      };
      raku = {
        disabled = false;
        format = lib.concatStrings [
          "via "
          "[$symbol ($version )]"
          "($style)"
        ];
      };
      red = {
        disabled = false;
        format = lib.concatStrings [
          "via "
          "[$symbol ($version )]"
          "($style)"
        ];
        # Darkest color of the logo.
        style = "bold #811b1e";
        symbol = "󰔶";
        version_format = "$raw";
      };
      ruby = {
        disabled = false;
        format = lib.concatStrings [
          "via "
          "[$symbol ($version )]"
          "($style)"
        ];
        version_format = "$raw";
        symbol = "󰴭";
        # Darkest color of the logo.
        style = "bold #83150c";
      };
      rust = {
        disabled = false;
        format = lib.concatStrings [
          "via "
          "[$symbol ($version )]"
          "($style)"
        ];
        version_format = "$raw";
        symbol = "󱘗";
        # Color of the logo.
        style = "bold #000000";
      };
      scala = {
        disabled = false;
        format = lib.concatStrings [
          "via "
          "[$symbol ($version )]"
          "($style)"
        ];
        version_format = "$raw";
        symbol = "";
        # Darkest color of the logo.
        style = "bold #7f0c1d";
      };
      shell = {
        # I don"t see the appeal of using an other shell.
        disabled = true;
      };
      shlvl = {
        # Not really necessary, shows the depth of a shell.
        # In a shell script, for example, it would be two,
        # as you would be running a shell from a shell.
        disabled = true;
      };
      singularity = {
        disabled = false;
        format = lib.concatStrings [
          "[$symbol \($env\) ]"
          "($style)"
        ];
        symbol = "󰓾";
        # Color of the logo.
        style = "bold #174283";
      };
      solidity = {
        disabled = false;
        format = lib.concatStrings [
          "via "
          "[$symbol ($version )]"
          "($style)"
        ];
        version_format = "$raw";
        symbol = "";
        # Color of the logo.
        style = "bold #2b247c";
      };
      spack = {
        disabled = false;
        format = lib.concatStrings [
          "via "
          "[$symbol $environment ]"
          "($style)"
        ];
        # Try to avoid truncation as much as possible.
        truncation_length = 10;
        symbol = " ";
      };
      status = {
        # The error_symbol is enough already.
        disabled = true;
      };
      sudo = {
        # Only shows if credentials are cached.
        disabled = true;
      };
      swift = {
        disabled = false;
        format = lib.concatStrings [
          "via "
          "[$symbol ($version )]"
          "($style)"
        ];
        version_format = "$raw";
        # Color of the logo.
        style = "bold #f05138";
        symbol = "󰛥";
      };
      terraform = {
        disabled = false;
        format = lib.concatStrings [
          "via "
          "[$symbol $workspace ]"
          "($style)"
        ];
        version_format = "$raw";
        # Color of the logo.
        style = "bold #7b42bc";
        symbol = "󱁢";
      };
      time = {
        # Disabled as it will display in whatever bar I"m using.
        disabled = true;
      };
      typst = {
        format = lib.concatStrings [
          "via "
          "[$symbol ($version )]"
          "($style)"
        ];
        # Color from the corner of the homepage.
        # It"s a gradient.
        style = "bold #05afc4";
        symbol = "";
        version_format = "$raw";
      };
      username = {
        # I know who I am.
        disabled = true;
      };
      vagrant = {
        disabled = false;
        format = lib.concatStrings [
          "via "
          "[$symbol ($version )]"
          "($style)"
        ];
        # Color of the logo.
        style = "bold #18b8f";
        symbol = "";
        version_format = "$raw";
      };
      vlang = {
        disabled = false;
        # Darkest color of the logo.
        style = "bold #536b8a";
        symbol = "";
        version_format = "$raw";
      };
      vcsh = {
        disabled = false;
        format = lib.concatStrings [
          "[$symbol $repo ]"
          "($style)"
        ];
        # Color from Git.
        style = "bold #f05133";
      };
      zig = {
        disabled = false;
        format = lib.concatStrings [
          "via "
          "[$symbol ($version )]"
          "($style)"
        ];
        # Color of the logo.
        style = "bold #f7a41d";
        symbol = "";
        version_format = "$raw";
      };
    };
  };
}
