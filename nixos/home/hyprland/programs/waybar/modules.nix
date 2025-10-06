{pkgs, ...}: {
  programs.waybar.settings.mainBar = {
    # Modules
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
      format-wifi = "   {signalStrength}%";
      format-ethernet = "{ipaddr}/{cidr} 󰊗";
      format-disconnected = "";
      tooltip-format = "{ifname} via {gwaddr} 󰊗";
      tooltip-format-wifi = "  {ifname} @ {essid}\nIP: {ipaddr}\nStrength: {signalStrength}%\nFreq: {frequency}MHz\nUp: {bandwidthUpBits} Down: {bandwidthDownBits}";
      tooltip-format-ethernet = " {ifname}\nIP: {ipaddr}\n up: {bandwidthUpBits} down: {bandwidthDownBits}";
      tooltip-format-disconnected = "Disconnected";
      max-length = 50;
      on-click = "ghostty -e nmtui";
    };
    "backlight/slider" = {
      min = 10;
      max = 100;
      orientation = "horizontal";
    };
    "power-profiles-daemon" = {
      format = "{icon}  {profile}";
      tooltip-format = "Power profile: {profile}\nDriver: {driver}";
      tooltip = true;
      format-icons = {
        default = " ";
        performance = " ";
        balanced = " ";
        power-saver = " ";
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
        "alsa_output.pci-0000_00_1f.3.analog-stereo" = "";
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
}
