{ config, pkgs, ... }:
let
  cliphist = "${pkgs.cliphist}/bin/cliphist";
  wl-paste = "${pkgs.wl-clipboard}/bin/wl-paste";
in
  {
    home.packages = [
      pkgs.kdePackages.qttools
    ];
    programs.noctalia-shell = {
      enable = true;
      plugins = {
        states = {
          clipper = {
            enabled = true;
            sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
          };
          currency-exchange = {
            enabled = true;
            sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
          };
          file-search = {
            enabled = true;
            sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
          };
          kaomoji-provider = {
            enabled = true;
            sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
          };
          kde-connect = {
            enabled = true;
            sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
          };
          polkit-agent = {
            enabled = true;
            sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
          };
          privacy-indicator = {
            enabled = true;
            sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
          };
          screen-recorder = {
            enabled = true;
            sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
          };
          unicode-picker = {
            enabled = true;
            sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
          };
        };
        sources = [
          {
            enabled = true;
            name = "Noctalia Plugins";
            url = "https://github.com/noctalia-dev/noctalia-plugins";
          }
        ];
      };
      settings = {
        settingsVersion = 58;
        bar = {
          barType = "floating";
          position = "top";
          monitors = [

          ];
          density = "default";
          showOutline = false;
          showCapsule = false;
          capsuleOpacity = 1;
          capsuleColorKey = "none";
          widgetSpacing = 6;
          contentPadding = 2;
          fontScale = 1;
          enableExclusionZoneInset = true;
          backgroundOpacity = 0;
          useSeparateOpacity = false;
          floating = true;
          marginVertical = 5;
          marginHorizontal = 5;
          frameThickness = 8;
          frameRadius = 12;
          outerCorners = true;
          hideOnOverview = true;
          displayMode = "always_visible";
          autoHideDelay = 500;
          autoShowDelay = 150;
          showOnWorkspaceSwitch = true;
          widgets = {
            left = [
              {
                characterCount = 2;
                colorizeIcons = true;
                emptyColor = "secondary";
                enableScrollWheel = true;
                focusedColor = "primary";
                followFocusedScreen = false;
                groupedBorderOpacity = 1;
                hideUnoccupied = false;
                iconScale = 0.8;
                id = "Workspace";
                labelMode = "index";
                occupiedColor = "secondary";
                pillSize = 0.6;
                showApplications = true;
                showBadge = false;
                showLabelsOnlyWhenOccupied = true;
                unfocusedIconsOpacity = 1;
              }
              {
                compactMode = false;
                hideMode = "idle";
                hideWhenIdle = false;
                id = "MediaMini";
                maxWidth = 145;
                panelShowAlbumArt = true;
                scrollingMode = "always";
                showAlbumArt = true;
                showArtistFirst = true;
                showProgressRing = true;
                showVisualizer = true;
                textColor = "none";
                useFixedWidth = false;
                visualizerType = "linear";
              }
            ];
            center = [
              {
                clockColor = "none";
                customFont = "";
                formatHorizontal = "HH:mm";
                formatVertical = "";
                id = "Clock";
                tooltipFormat = "HH:mm ddd, dd MMM";
                useCustomFont = false;
              }
            ];
            right = [
              {
                defaultSettings = {
                  audioCodec = "opus";
                  audioSource = "default_output";
                  colorRange = "limited";
                  copyToClipboard = false;
                  directory = "";
                  filenamePattern = "recording_yyyyMMdd_HHmmss";
                  frameRate = "60";
                  hideInactive = false;
                  iconColor = "none";
                  quality = "very_high";
                  resolution = "original";
                  showCursor = true;
                  videoCodec = "h264";
                  videoSource = "portal";
                };
                id = "plugin:screen-recorder";
              }
              {
                defaultSettings = {
                  activeColor = "primary";
                  enableToast = true;
                  hideInactive = false;
                  iconSpacing = 4;
                  inactiveColor = "none";
                  removeMargins = false;
                };
                id = "plugin:privacy-indicator";
              }
              {
                defaultSettings = {
                  enableTodoIntegration = false;
                  notecardsEnabled = true;
                  pincardsEnabled = true;
                  position = "Bottom";
                  showCloseButton = false;
                };
                id = "plugin:clipper";
              }
              {
                defaultSettings = {
                };
                id = "plugin:kde-connect";
              }
              {
                hideWhenZero = false;
                hideWhenZeroUnread = true;
                iconColor = "none";
                id = "NotificationHistory";
                showUnreadBadge = true;
                unreadBadgeColor = "primary";
              }
              {
                displayMode = "onhover";
                iconColor = "none";
                id = "Volume";
                middleClickCommand = "pwvucontrol || pavucontrol";
                textColor = "none";
              }
              {
                applyToAllMonitors = false;
                displayMode = "onhover";
                iconColor = "none";
                id = "Brightness";
                textColor = "none";
              }
              {
                deviceNativePath = "__default__";
                displayMode = "graphic";
                hideIfIdle = false;
                hideIfNotDetected = true;
                id = "Battery";
                showNoctaliaPerformance = true;
                showPowerProfiles = true;
              }
              {
                colorizeDistroLogo = false;
                colorizeSystemIcon = "none";
                customIconPath = "";
                enableColorization = true;
                icon = "noctalia";
                id = "ControlCenter";
                useDistroLogo = true;
              }
            ];
          };
          mouseWheelAction = "workspace";
          reverseScroll = false;
          mouseWheelWrap = true;
          middleClickAction = "none";
          middleClickFollowMouse = false;
          middleClickCommand = "";
          rightClickAction = "controlCenter";
          rightClickFollowMouse = true;
          rightClickCommand = "";
          screenOverrides = [

          ];
        };
        general = {
          avatarImage = "/home/gabriel/.face";
          dimmerOpacity = 0.2;
          showScreenCorners = false;
          forceBlackScreenCorners = false;
          scaleRatio = 1;
          radiusRatio = 1;
          iRadiusRatio = 1;
          boxRadiusRatio = 1;
          screenRadiusRatio = 1;
          animationSpeed = 1;
          animationDisabled = false;
          compactLockScreen = false;
          lockScreenAnimations = true;
          lockOnSuspend = true;
          showSessionButtonsOnLockScreen = true;
          showHibernateOnLockScreen = true;
          enableLockScreenMediaControls = true;
          enableShadows = false;
          enableBlurBehind = true;
          shadowDirection = "bottom_right";
          shadowOffsetX = 2;
          shadowOffsetY = 3;
          language = "";
          allowPanelsOnScreenWithoutBar = true;
          showChangelogOnStartup = true;
          telemetryEnabled = false;
          enableLockScreenCountdown = true;
          lockScreenCountdownDuration = 10000;
          autoStartAuth = true;
          allowPasswordWithFprintd = true;
          clockStyle = "analog";
          clockFormat = "hh\\nmm";
          passwordChars = true;
          lockScreenMonitors = [

          ];
          lockScreenBlur = 0;
          lockScreenTint = 0;
          keybinds = {
            keyUp = [
              "Up"
            ];
            keyDown = [
              "Down"
            ];
            keyLeft = [
              "Left"
            ];
            keyRight = [
              "Right"
            ];
            keyEnter = [
              "Return"
              "Enter"
            ];
            keyEscape = [
              "Esc"
            ];
            keyRemove = [
              "Del"
            ];
          };
          reverseScroll = false;
        };
        ui = {
          fontDefault = "sans-serif";
          fontFixed = "monospace";
          fontDefaultScale = 1;
          fontFixedScale = 1;
          tooltipsEnabled = true;
          scrollbarAlwaysVisible = true;
          boxBorderEnabled = false;
          panelBackgroundOpacity = 1;
          translucentWidgets = true;
          panelsAttachedToBar = true;
          settingsPanelMode = "attached";
          settingsPanelSideBarCardStyle = true;
        };
        location = {
          name = "São Paulo";
          weatherEnabled = true;
          weatherShowEffects = true;
          useFahrenheit = false;
          use12hourFormat = false;
          showWeekNumberInCalendar = true;
          showCalendarEvents = true;
          showCalendarWeather = true;
          analogClockInCalendar = true;
          firstDayOfWeek = -1;
          hideWeatherTimezone = false;
          hideWeatherCityName = true;
        };
        calendar = {
          cards = [
            {
              enabled = true;
              id = "calendar-header-card";
            }
            {
              enabled = true;
              id = "calendar-month-card";
            }
            {
              enabled = true;
              id = "weather-card";
            }
          ];
        };
        wallpaper = {
          enabled = true;
          overviewEnabled = false;
          directory = "/home/gabriel/Pictures/wallpapers";
          monitorDirectories = [

          ];
          enableMultiMonitorDirectories = false;
          showHiddenFiles = false;
          viewMode = "recursive";
          setWallpaperOnAllMonitors = true;
          fillMode = "crop";
          fillColor = "#000000";
          useSolidColor = false;
          solidColor = "#1a1a2e";
          automationEnabled = true;
          wallpaperChangeMode = "random";
          randomIntervalSec = 900;
          transitionDuration = 1500;
          transitionType = "random";
          skipStartupTransition = true;
          transitionEdgeSmoothness = 0.05;
          panelPosition = "follow_bar";
          hideWallpaperFilenames = false;
          overviewBlur = 0.4;
          overviewTint = 0.6;
          useWallhaven = false;
          wallhavenQuery = "";
          wallhavenSorting = "relevance";
          wallhavenOrder = "desc";
          wallhavenCategories = "111";
          wallhavenPurity = "100";
          wallhavenRatios = "";
          wallhavenApiKey = "";
          wallhavenResolutionMode = "atleast";
          wallhavenResolutionWidth = "";
          wallhavenResolutionHeight = "";
          sortOrder = "random";
          favorites = [

          ];
        };
        appLauncher = {
          enableClipboardHistory = true;
          autoPasteClipboard = true;
          enableClipPreview = true;
          clipboardWrapText = true;
          enableClipboardSmartIcons = true;
          enableClipboardChips = true;
          clipboardWatchTextCommand = "${wl-paste} --type text --watch ${cliphist} store";
          clipboardWatchImageCommand = "${wl-paste} --type image --watch ${cliphist} store";
          position = "center";
          pinnedApps = [

          ];
          sortByMostUsed = false;
          terminalCommand = "alacritty -e";
          customLaunchPrefixEnabled = false;
          customLaunchPrefix = "";
          viewMode = "list";
          showCategories = true;
          iconMode = "native";
          showIconBackground = false;
          enableSettingsSearch = true;
          enableWindowsSearch = true;
          enableSessionSearch = true;
          ignoreMouseInput = false;
          screenshotAnnotationTool = "";
          overviewLayer = true;
          density = "default";
        };
        controlCenter = {
          position = "close_to_bar_button";
          diskPath = "/";
          shortcuts = {
            left = [

            ];
            right = [
              {
                id = "Notifications";
              }
              {
                id = "Network";
              }
              {
                id = "Bluetooth";
              }
              {
                id = "WallpaperSelector";
              }
            ];
          };
          cards = [
            {
              enabled = true;
              id = "profile-card";
            }
            {
              enabled = true;
              id = "shortcuts-card";
            }
            {
              enabled = true;
              id = "brightness-card";
            }
            {
              enabled = true;
              id = "audio-card";
            }
            {
              enabled = true;
              id = "weather-card";
            }
            {
              enabled = true;
              id = "media-sysmon-card";
            }
          ];
        };
        systemMonitor = {
          cpuWarningThreshold = 80;
          cpuCriticalThreshold = 90;
          tempWarningThreshold = 80;
          tempCriticalThreshold = 90;
          gpuWarningThreshold = 80;
          gpuCriticalThreshold = 90;
          memWarningThreshold = 80;
          memCriticalThreshold = 90;
          swapWarningThreshold = 80;
          swapCriticalThreshold = 90;
          diskWarningThreshold = 80;
          diskCriticalThreshold = 90;
          diskAvailWarningThreshold = 20;
          diskAvailCriticalThreshold = 10;
          batteryWarningThreshold = 20;
          batteryCriticalThreshold = 5;
          enableDgpuMonitoring = true;
          useCustomColors = false;
          warningColor = "#6a5969";
          criticalColor = "#ba1a1a";
          externalMonitor = "${pkgs.resources}/bin/resources";
        };
        noctaliaPerformance = {
          disableWallpaper = true;
          disableDesktopWidgets = true;
        };
        dock = {
          enabled = false;
          position = "bottom";
          displayMode = "auto_hide";
          dockType = "floating";
          backgroundOpacity = 1;
          floatingRatio = 1;
          size = 1;
          onlySameOutput = true;
          monitors = [

          ];
          pinnedApps = [

          ];
          colorizeIcons = false;
          showLauncherIcon = false;
          launcherPosition = "end";
          launcherIconColor = "none";
          pinnedStatic = false;
          inactiveIndicators = false;
          groupApps = false;
          groupContextMenuMode = "extended";
          groupClickAction = "cycle";
          groupIndicatorStyle = "dots";
          deadOpacity = 0.6;
          animationSpeed = 1;
          sitOnFrame = false;
          showDockIndicator = false;
          indicatorThickness = 3;
          indicatorColor = "primary";
          indicatorOpacity = 0.6;
        };
        network = {
          wifiEnabled = true;
          airplaneModeEnabled = false;
          bluetoothRssiPollingEnabled = true;
          bluetoothRssiPollIntervalMs = 10000;
          networkPanelView = "wifi";
          wifiDetailsViewMode = "grid";
          bluetoothDetailsViewMode = "grid";
          bluetoothHideUnnamedDevices = false;
          disableDiscoverability = false;
          bluetoothAutoConnect = true;
        };
        sessionMenu = {
          enableCountdown = false;
          countdownDuration = 10000;
          position = "center";
          showHeader = true;
          showKeybinds = true;
          largeButtonsStyle = true;
          largeButtonsLayout = "grid";
          powerOptions = [
            {
              action = "lock";
              command = "";
              countdownEnabled = true;
              enabled = true;
              keybind = "1";
            }
            {
              action = "shutdown";
              command = "";
              countdownEnabled = true;
              enabled = true;
              keybind = "2";
            }
            {
              action = "reboot";
              command = "";
              countdownEnabled = true;
              enabled = true;
              keybind = "3";
            }
            {
              action = "suspend";
              command = "";
              countdownEnabled = true;
              enabled = true;
              keybind = "4";
            }
            {
              action = "hibernate";
              command = "";
              countdownEnabled = true;
              enabled = true;
              keybind = "5";
            }
            {
              action = "logout";
              command = "";
              countdownEnabled = true;
              enabled = false;
              keybind = "";
            }
            {
              action = "rebootToUefi";
              command = "";
              countdownEnabled = true;
              enabled = true;
              keybind = "6";
            }
            {
              action = "userspaceReboot";
              command = "";
              countdownEnabled = true;
              enabled = false;
              keybind = "";
            }
          ];
        };
        notifications = {
          enabled = true;
          enableMarkdown = false;
          density = "compact";
          monitors = [

          ];
          location = "top_right";
          overlayLayer = true;
          backgroundOpacity = 1;
          respectExpireTimeout = true;
          lowUrgencyDuration = 3;
          normalUrgencyDuration = 8;
          criticalUrgencyDuration = 15;
          clearDismissed = true;
          saveToHistory = {
            low = true;
            normal = true;
            critical = true;
          };
          sounds = {
            enabled = false;
            volume = 0.5;
            separateSounds = false;
            criticalSoundFile = "";
            normalSoundFile = "";
            lowSoundFile = "";
            excludedApps = "discord,firefox,chrome,chromium,edge";
          };
          enableMediaToast = true;
          enableKeyboardLayoutToast = true;
          enableBatteryToast = true;
        };
        osd = {
          enabled = true;
          location = "top_right";
          autoHideMs = 2000;
          overlayLayer = true;
          backgroundOpacity = 1;
          enabledTypes = [
            0
            1
            2
            3
          ];
          monitors = [

          ];
        };
        audio = {
          volumeStep = 5;
          volumeOverdrive = false;
          spectrumFrameRate = 60;
          visualizerType = "linear";
          mprisBlacklist = [

          ];
          preferredPlayer = "";
          volumeFeedback = false;
          volumeFeedbackSoundFile = "";
        };
        brightness = {
          brightnessStep = 5;
          enforceMinimum = true;
          enableDdcSupport = true;
          backlightDeviceMappings = [

          ];
        };
        colorSchemes = {
          useWallpaperColors = true;
          predefinedScheme = "Ayu";
          darkMode = false;
          schedulingMode = "location";
          manualSunrise = "06:30";
          manualSunset = "18:30";
          generationMethod = "content";
          monitorForColors = "";
        };
        templates = {
          activeTemplates = [
            {
              enabled = true;
              id = "ghostty";
            }
            {
              enabled = true;
              id = "helix";
            }
            {
              enabled = true;
              id = "hyprland";
            }
            {
              enabled = true;
              id = "hyprtoolkit";
            }
            {
              enabled = true;
              id = "kcolorscheme";
            }
            {
              enabled = true;
              id = "kitty";
            }
            {
              enabled = true;
              id = "mango";
            }
            {
              enabled = true;
              id = "niri";
            }
            {
              enabled = true;
              id = "pywalfox";
            }
            {
              enabled = true;
              id = "qt";
            }
            {
              enabled = true;
              id = "scroll";
            }
            {
              enabled = true;
              id = "spicetify";
            }
            {
              enabled = true;
              id = "sway";
            }
            {
              enabled = true;
              id = "telegram";
            }
            {
              enabled = true;
              id = "vicinae";
            }
            {
              enabled = true;
              id = "code";
            }
            {
              enabled = true;
              id = "walker";
            }
            {
              enabled = true;
              id = "wezterm";
            }
            {
              enabled = true;
              id = "yazi";
            }
            {
              enabled = true;
              id = "zathura";
            }
            {
              enabled = true;
              id = "zed";
            }
            {
              enabled = true;
              id = "zenBrowser";
            }
            {
              enabled = true;
              id = "btop";
            }
            {
              enabled = true;
              id = "cava";
            }
            {
              enabled = true;
              id = "discord";
            }
            {
              enabled = true;
              id = "foot";
            }
            {
              enabled = true;
              id = "fuzzel";
            }
            {
              enabled = true;
              id = "alacritty";
            }
            {
              enabled = true;
              id = "emacs";
            }
            {
              enabled = true;
              id = "gtk";
            }
            {
              enabled = true;
              id = "labwc";
            }
            {
              enabled = true;
              id = "steam";
            }
          ];
          enableUserTheming = true;
        };
        nightLight = {
          enabled = false;
          forced = false;
          autoSchedule = false;
          nightTemp = "4000";
          dayTemp = "6500";
          manualSunrise = "06:30";
          manualSunset = "18:30";
        };
        hooks = {
          enabled = false;
          wallpaperChange = "";
          darkModeChange = "";
          screenLock = "";
          screenUnlock = "";
          performanceModeEnabled = "";
          performanceModeDisabled = "";
          startup = "";
          session = "";
        };
        plugins = {
          autoUpdate = false;
        };
        idle = {
          enabled = true;
          screenOffTimeout = 300;
          lockTimeout = 660;
          suspendTimeout = 1800;
          fadeDuration = 5;
          screenOffCommand = "";
          lockCommand = "";
          suspendCommand = "";
          resumeScreenOffCommand = "";
          resumeLockCommand = "";
          resumeSuspendCommand = "";
          customCommands = "[]";
        };
        desktopWidgets = {
          enabled = false;
          overviewEnabled = true;
          gridSnap = false;
          gridSnapScale = false;
          monitorWidgets = [
            {
              name = "HDMI-A-1";
              widgets = [

              ];
            }
          ];
        };
      };
    };
  }
