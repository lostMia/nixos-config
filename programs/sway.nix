{...}: {
  home.file = {
    ".config/sway/config".text = ''

      # Mia's sway config

      ### Colors
          set $rosewater #f5e0dc
          set $flamingo  #f2cdcd
          set $pink      #f5c2e7
          set $mauve     #cba6f7
          set $red       #f38ba8
          set $maroon    #eba0ac
          set $peach     #fab387
          set $green     #a6e3a1
          set $teal      #94e2d5
          set $sky       #89dceb
          set $sapphire  #74c7ec
          set $blue      #89b4fa
          set $lavender  #b4befe
          set $text      #cdd6f4
          set $subtext1  #bac2de
          set $subtext0  #a6adc8
          set $overlay2  #9399b2
          set $overlay1  #7f849c
          set $overlay0  #6c7086
          set $surface2  #585b70
          set $surface1  #45475a
          set $surface0  #313244
          set $base      #1e1e2e
          set $mantle    #181825
          set $crust     #11111b

      ### Flameshot fix
          exec_always "export SDL_VIDEODRIVER=wayland"
          exec_always "export _JAVA_AWT_WM_NONREPARENTING=1"
          exec_always "export QT_QPA_PLATFORM=wayland"
          exec_always "export XDG_CURRENT_DESKTOP=sway"
          exec_always "export XDG_SESSION_DESKTOP=sway"
          exec_always "export QT_AUTO_SCREEN_SCALE_FACTOR=0"

          exec_always systemctl --user import-environment DISPLAY WAYLAND_DISPLAY SWAYSOCK
          exec_always hash dbus-update-activation-environment 2>/dev/null && \
              dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY SWAYSOCK

      ### Variables
          set $mod Mod4
          set $left b
          set $down n
          set $up r
          set $right s
          set $term alacritty
          set $menu rofi

      ### Font
          font HackNerdFont-Regular 16

      ### Output configuration
          output * scale 1 bg $HOME/.config/nixos/resources/nix.png fill

      ### Input configuration
          input type:keyboard {
              xkb_layout de,de
              xkb_variant bone,
              repeat_delay 160,160
              repeat_rate 80,80
              xkb_options altwin:swap_lalt_lwin
          }

          # altwin:swap_lalt_lwin swaps the left alt and windows keys, so the win key is on the right and the alt is on the left.
          # ctrl:swap_ralt_rctl swaps the right alt and right control keys, so the control key is on the left and the alt is on the right.
          #xkb_options grp:rctrl_toggle,altwin:swap_lalt_lwin

          input 2362:628:PIXA3854:00_093A:0274_Touchpad {
              pointer_accel 0
              tap enabled
              accel_profile flat
              scroll_method two_finger
              scroll_factor 0.3
              middle_emulation enabled
          }

          input 1133:49291:Logitech_G502_HERO_Gaming_Mouse {
              accel_profile flat
              pointer_accel -0.5
          }

      ### Border colors and looks
          client.focused           #ff4060   #222222 #ff4060 #ff4060  #ff4060
          client.focused_inactive  #222222   #222222 #ff4060 #222222 #222222
          client.unfocused         #222222 #222222 #222222 #222222 #222222
          client.urgent            $peach    $base $peach $overlay0  $peach
          client.placeholder       $overlay0 $base $text  $overlay0  $overlay0
          client.background        $base

      ## Autostart
          exec autotiling                                                           # Automatically tiles in whatever direction is the longest
          exec $HOME/.config/nixos/scripts/idlescript                               # Manages suspending and locking
          exec $HOME/.config/nixos/scripts/batteryscript.sh                         # Sends battery notifications when necessary
          exec nm-applet                                                            # Networkmanager applet
          exec blueman-applet                                                       # Bluetoothmanager applet
          exec blueman-tray                                                         # Bluetoothmanager tray icon
          exec signal-desktop                                                       # Signal (Even though sebi refuses to use it pwp)
          exec vesktop
          exec thunderbird
          exec shikane                                                              # Manages displays and known display setups
          exec firefox
          exec sway-audio-idle-inhibit                                              # Prevents sleep when audio is playing
          exec swayosd-server                                                       # OSD server for audio and screen brightness popups
          exec waybar                                                               # Status bar for sway
          exec "rfkill block bluetooth"                                             # Disable bluetooth by default

          assign [class="vesktop"] workspace 1
          assign [class="Signal"] workspace 1
          assign [app_id="firefox"] workspace 2
          assign [app_id="thunderbird"] workspace 10


      ### Key bindings
          bindsym $mod+e exec $term
          bindsym $mod+d kill
          bindsym $mod+i exec $menu -show combi -combi-modes "drun,run,ssh" -modi combi -monitor "eDP-1" # rofi
          bindsym $mod+Shift+i exec $menu -show ssh -monitor "eDP-1"
          bindsym $mod+t exec nautilus -w
          bindsym $mod+f exec firefox
          #bindsym $mod+l exec alacritty -e lf
          bindsym $mod+x exec $HOME/.config/nixos/scripts/lockscript
          bindsym $mod+Shift+t exec "$HOME/.config/nixos/scripts/screenshot.sh"
          #bindsym $mod+Shift+t exec "grimshot copy area"
          #bindsym $mod+Shift+t exec "flameshot gui"
          bindsym $mod+Shift+q reload
          bindsym $mod+Shift+c exec swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -B 'Yes, exit sway' 'swaymsg exit'
          bindsym $mod+Shift+Control+c exec "swaymsg exit"
          bindsym $mod+Escape exec 'swaymsg input type:keyboard xkb_switch_layout next'
          # bindsym $mod+odiaeresis exec woomer
          bindsym $mod+a exec woomer
          # bindsym $mod+p exec $HOME/.config/nixos/scripts/toggle_freeze_process.sh
          bindsym $mod+p exec "message=$(hyprpicker -a) && notify-send -u low $message"

      # Function Keys
          bindsym $mod+Shift+m exec sleep 0.1 && swaymsg output eDP-1 dpms toggle
          bindsym $mod+Shift+l exec swayosd-client --brightness -2
          bindsym $mod+Shift+h exec swayosd-client --brightness +2
          bindsym $mod+m exec swayosd-client --output-volume mute-toggle --max-volume 200
          bindsym $mod+l exec swayosd-client --output-volume -2 --max-volume 200
          bindsym $mod+h exec swayosd-client --output-volume +2 --max-volume 200

      # Moving around:
          bindsym $mod+$left focus left
          bindsym $mod+$down focus down
          bindsym $mod+$up focus up
          bindsym $mod+$right focus right

          bindsym $mod+Left focus left
          bindsym $mod+Down focus down
          bindsym $mod+Up focus up
          bindsym $mod+Right focus right

          bindsym $mod+Shift+$left move left
          bindsym $mod+Shift+$down move down
          bindsym $mod+Shift+$up move up
          bindsym $mod+Shift+$right move right

          bindsym $mod+Shift+Left move left
          bindsym $mod+Shift+Down move down
          bindsym $mod+Shift+Up move up
          bindsym $mod+Shift+Right move right

          bindsym $mod+y workspace prev
          bindsym $mod+z workspace next

      # Workspaces:
          bindsym $mod+1 workspace number 1
          bindsym $mod+2 workspace number 2
          bindsym $mod+3 workspace number 3
          bindsym $mod+4 workspace number 4
          bindsym $mod+5 workspace number 5
          bindsym $mod+6 workspace number 6
          bindsym $mod+7 workspace number 7
          bindsym $mod+8 workspace number 8
          bindsym $mod+9 workspace number 9
          bindsym $mod+0 workspace number 10

          bindsym $mod+Shift+1 move container to workspace number 1
          bindsym $mod+Shift+2 move container to workspace number 2
          bindsym $mod+Shift+3 move container to workspace number 3
          bindsym $mod+Shift+4 move container to workspace number 4
          bindsym $mod+Shift+5 move container to workspace number 5
          bindsym $mod+Shift+6 move container to workspace number 6
          bindsym $mod+Shift+7 move container to workspace number 7
          bindsym $mod+Shift+8 move container to workspace number 8
          bindsym $mod+Shift+9 move container to workspace number 9
          bindsym $mod+Shift+0 move container to workspace number 10

          workspace_auto_back_and_forth false

      # Fx stuff:
          blur disable
          blur_passes 0
          blur_radius 1
          blur_noise 0
          blur_brightness 1

          corner_radius 12
          default_dim_inactive 0.15

      # Layout stuff:
          gaps inner 2
          gaps outer 2

          gaps top 5
          #smart_borders on
          #smart_gaps on

          default_border pixel 2
          floating_modifier $mod normal

          #bindsym $mod+h splith
          #bindsym $mod+m splitv

          # Switch the current container between different layout styles
          bindsym $mod+Comma layout tabbed
          bindsym $mod+Period layout toggle split

          bindsym $mod+Return fullscreen
          bindsym $mod+Shift+space floating toggle
          bindsym $mod+space focus mode_toggle

      # Scratchpad:
          # Sway has a "scratchpad", which is a bag of holding for windows.
          # You can send windows there and get them back later.

          # Move the currently focused window to the scratchpad
          bindsym $mod+Shift+Tab move scratchpad

          # Show the next scratchpad window or hide the focused scratchpad window.
          # If there are multiple scratchpad windows, this command cycles through them.
          bindsym $mod+Tab scratchpad show

      # Resizing containers:
          #mode "resize" {
          # left will shrink the containers width
          # right will grow the containers width
          # up will shrink the containers height
          # down will grow the containers height
          set $move_amount 150px

          bindsym $mod+Control+$left resize grow width $move_amount
          bindsym $mod+Control+$down resize shrink height $move_amount
          bindsym $mod+Control+$up resize grow height $move_amount
          bindsym $mod+Control+$right resize shrink width $move_amount

          bindsym $mod+Control+Left resize grow width $move_amount
          bindsym $mod+Control+Down resize shrink height $move_amount
          bindsym $mod+Control+Up resize grow height $move_amount
          bindsym $mod+Control+Right resize shrink width $move_amount

      # Return to default mode
          # bindsym Return mode "default"
          # bindsym Escape mode "default"
          # bindsym $mod+r mode "resize"
    '';
  };
}
