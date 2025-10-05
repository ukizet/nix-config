{pkgs, ...}: let
  startupScript = pkgs.pkgs.writeShellScriptBin "start" ''
    sleep 1

    waybar &
    swww init &

    sleep 1

  '';
in {
  programs = {
    kitty.enable = true;
    rofi.enable = true;
    waybar = {
      enable = true;
      settings.mainBar = {
        # layer = "top";
        position = "top";
        height = 40;
        modules-left = ["hyprland/workspaces" "hyprland/window" "hyprland/windowcount"];
        modules-center = ["sway/window"];
        modules-right = ["privacy" "hyprland/language" "mpris" "pulseaudio" "bluetooth" "network" "custom/mymodule#with-css-id" "backlight" "clock" "temperature" "power-profiles-daemon" "gamemode" "battery"];

        "hyprland/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
        };
        "mpris" = {
          format = "DEFAULT: {player_icon} {dynamic}";
          format-paused = "DEFAULT: {status_icon} <i>{dynamic}</i>";
          player-icons = {
            default = "▶";
            mpv = "🎵";
          };
          status-icons = {
            paused = "⏸ ";
          };
        };
        "custom/hello-from-waybar" = {
          format = "hello {}";
          max-length = 40;
          interval = "once";
          exec = pkgs.writeShellScript "hello-from-waybar" ''
            echo "from within waybar"
          '';
        };
        "bluetooth" = {
          format = " {status}";
          format-connected = " {device_alias}";
          tooltip = true;
          interval = 10;
          on-click = "blueman-manager";
        };
        "network" = {
          format = "{ifname}";
          format-wifi = " {signalStrength}%";
          format-ethernet = "{ipaddr}/{cidr} 󰊗";
          format-disconnected = "";
          tooltip-format = "{ifname} via {gwaddr} 󰊗";
          tooltip-format-wifi = "  {ifname} @ {essid}\nIP: {ipaddr}\nStrength: {signalStrength}%\nFreq: {frequency}MHz\nUp: {bandwidthUpBits} Down: {bandwidthDownBits}";
          tooltip-format-ethernet = " {ifname}\nIP: {ipaddr}\n up: {bandwidthUpBits} down: {bandwidthDownBits}";
          tooltip-format-disconnected = "Disconnected";
          max-length = 50;
          on-click = "nmtui-connect";
        };
        "backlight/slider" = {
          min = 10;
          max = 100;
          orientation = "horizontal";
        };
        "power-profiles-daemon" = {
          format = "{icon} {profile}";
          tooltip-format = "Power profile: {profile}\nDriver: {driver}";
          tooltip = true;
          format-icons = {
            default = "";
            performance = "";
            balanced = "";
            power-saver = "";
          };
        };
        "gamemode" = {
          format = "{glyph}";
          format-alt = "{glyph} {count}";
          glyph = "";
          hide-not-running = true;
          use-icon = true;
          icon-name = "input-gaming-symbolic";
          icon-spacing = 4;
          icon-size = 20;
          tooltip = true;
          tooltip-format = "Games running: {count}";
        };
        "pulseaudio" = {
          format = "{volume}% {icon}";
          format-bluetooth = "{volume}% {icon}";
          format-muted = "";
          format-icons = {
            "alsa_output.pci-0000_00_1f.3.analog-stereo" = "";
            "alsa_output.pci-0000_00_1f.3.analog-stereo-muted" = "";
            headphone = "";
            "hands-free" = "";
            headset = "";
            phone = "";
            "phone-muted" = "";
            portable = "";
            car = "";
            default = ["" ""];
          };
          scroll-step = 5;
          on-click = "pavucontrol";
          ignored-sinks = ["Easy Effects Sink"];
        };
        "backlight" = {
          format = "{percent}% {icon}";
          format-icons = ["" ""];
          scroll-step = 5;
          min = 5;
        };
        "temperature" = {
          thermal-zone = 5;
          format = "{temperatureC}°C ";
        };
      };
    };
  };
  services = {
    dunst.enable = true;
    swww.enable = true;
    blueman-applet.enable = true;
    mpd-mpris = {
      enable = true;
      mpd.useLocal = true;
    };
    mpd = {
      enable = true;
      musicDirectory = "true";
    };
  };
  home.packages = with pkgs; [
    waybar-mpris
    brightnessctl
    pavucontrol
    networkmanager
    bluez
    bluez-tools
    wlroots
    dunst
    libnotify
    wev
  ];
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    settings = {
      "debug:disable_logs" = "false";
      "$mod" = "SUPER";
      "$browser" = "librewolf";
      "$terminal" = "ghostty";
      "$runner" = "rofi";
      "$explorer" = "dolphin";
      "$network" = "nmtui-connect";
      monitor = [
        ", preferred, auto, 1"
      ];
      bind =
        [
          "$mod ALT, h, movefocus, l"
          "$mod ALT, l, movefocus, r"
          "$mod ALT, k, movefocus, u"
          "$mod ALT, j, movefocus, d"
          "$mod, B, exec, $browser"
          "$mod, T, exec, $terminal"
          "$mod, E, exec, $explorer"
          "$mod, S, exec, $runner -show drun -show-icons"
          "$mod, N, exec, $network"
          "$mod, C, killactive"
          "$mod, M, exit"
          "$mod, V, togglefloating"
          "$mod, P, pseudo"
          "$mod, J, togglesplit"
          ",XF86AudioMute, exec, pactl set-sink-mute @DEFAULT_SINK@ toggle"
          ",XF86AudioLowerVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ -5%"
          ",XF86AudioRaiseVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ +5%"
          ",XF86MonBrightnessDown, exec, brightnessctl set 5%-"
          ",XF86MonBrightnessUp, exec, brightnessctl set +5%"
        ]
        ++ (
          # workspaces
          # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
          builtins.concatLists (builtins.genList (
              i: let
                ws = i + 1;
              in [
                "$mod, code:1${toString i}, workspace, ${toString ws}"
                "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
              ]
            )
            9)
        );
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
        "$mod ALT, mouse:272, resizewindow"
      ];
      exec-once = ''${startupScript}/bin/start'';
    };
  };
}
