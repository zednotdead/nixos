{
  perSystem,
  inputs,
  config,
  ...
}: {
  imports = [
    inputs.noctalia.homeModules.default
  ];

  home.packages = [
    perSystem.noctalia.default
  ];
  programs.noctalia-shell = {
    enable = true;
    colors = with config.scheme.withHashtag; {
      # you must set ALL of these
      mPrimary = base0A;
      mOnPrimary = base00;
      mSecondary = base0C;
      mOnSecondary = base00;
      mTertiary = base0F;
      mOnTertiary = base05;
      mError = base08;
      mOnError = base00;
      mSurface = base00;
      mOnSurface = base05;
      mSurfaceVariant = base02;
      mOnSurfaceVariant = base04;
      mOutline = base02;
      mShadow = base00;
    };
    settings = {
      settingsVersion = 6;
      bar = {
        position = "top";
        backgroundOpacity = 1;
        showCapsule = true;
        floating = true;
        marginVertical = 0.25;
        marginHorizontal = 0.25;
        widgets = {
          left = [
            {
              id = "ActiveWindow";
            }
            {
              id = "MediaMini";
            }
          ];
          "center" = [
            {
              id = "Workspace";
            }
          ];
          "right" = [
            {
              id = "ScreenRecorder";
            }
            {
              id = "Tray";
            }
            {
              id = "NotificationHistory";
            }
            {
              id = "Bluetooth";
            }
            {
              id = "Volume";
            }
            {
              id = "Brightness";
            }
            {
              id = "NightLight";
            }
            {
              id = "Clock";
            }
            {
              id = "ControlCenter";
            }
          ];
        };
      };
      general = {
        avatarImage = "";
        dimDesktop = true;
        showScreenCorners = false;
        forceBlackScreenCorners = false;
        radiusRatio = 1;
        screenRadiusRatio = 1;
        animationSpeed = 1;
      };
      location = {
        name = "Warsaw";
        useFahrenheit = false;
        use12hourFormat = false;
        showWeekNumberInCalendar = false;
      };
      screenRecorder = {
        directory = "";
        frameRate = 60;
        audioCodec = "opus";
        videoCodec = "h264";
        quality = "very_high";
        colorRange = "limited";
        showCursor = true;
        audioSource = "default_output";
        videoSource = "portal";
      };
      wallpaper = {
        enabled = false;
      };
      network = {
        wifiEnabled = false;
        bluetoothEnabled = true;
      };
      notifications = {
        doNotDisturb = false;
        monitors = ["DP-1"];
        location = "top_right";
        alwaysOnTop = false;
        lastSeenTs = 0;
        respectExpireTimeout = false;
        lowUrgencyDuration = 3;
        normalUrgencyDuration = 8;
        criticalUrgencyDuration = 15;
        enableOSD = true;
      };
      audio = {
        volumeStep = 5;
        volumeOverdrive = false;
        cavaFrameRate = 60;
        visualizerType = "linear";
        mprisBlacklist = [];
        preferredPlayer = "";
      };
      ui = {
        fontDefault = "Roboto";
        fontFixed = "Maple Mono NF";
        fontBillboard = "Inter";
        monitorsScaling = [];
        idleInhibitorEnabled = false;
      };
      brightness = {
        brightnessStep = 5;
      };
      nightLight = {
        enabled = true;
        forced = false;
        autoSchedule = true;
        nightTemp = "4000";
        dayTemp = "5500";
        manualSunrise = "06:30";
        manualSunset = "18:30";
      };
      hooks = {
        enabled = false;
        wallpaperChange = "";
        darkModeChange = "";
      };
    };
  };
}
