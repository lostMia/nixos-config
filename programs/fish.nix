{...}: {
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set -x UUID_KEY "0D15-EA5E"
      set -x UUID_BACKUP "1D15-EA5E"
      set -x UUID_BACKUP2 "2D15-EA5E"

      eval (dircolors -c ~/.config/nixos/resources/.dircolors)

      export VISUAL=neovide
      export EDITOR=$VISUAL
      #export NIX_LD="$(nix-build '<nixpkgs>' -A nix-ld)/bin/nix-ld"

      thefuck --alias | source
      zoxide init fish | source
      # any-nix-shell fish --info-right | source

      #echo -e "\e[1m/ᐠ - ˕ -マ"
      echo -e "\e[1m ᨐ "
    '';

    shellAliases = {
      "flex" = "fastfetch | dotacat";
      "neofetch" = "fastfetch";
      "c" = "cd .."; # thanks sebi
      "n" = "neovide";
      "bored" = "fortune | cowsay | dotacat -p 1.5";
      "wise" = "fortune | cowsay | wl-copy";
      "ff" = "nvim ~/.config/nixos/programs/fish.nix";
      "hib" = "systemctl hibernate && exit";
      "grub-update" = "sudo grub-mkconfig -o /boot/grub/grub.cfg";
      "virt" = "sudo systemctl start libvirtd.socket libvirtd libvirtd.service";
      "m" = "math";
      "noran" = "setarch x86_64 -R /run/current-system/sw/bin/fish";
      "conf" = "nvim ~/.config/nixos/programs/sway.nix";
      "mpm" = "~/.config/nixos/scripts/mpm.sh";
      "rank-mirrors" = "curl -s 'https://archlinux.org/mirrorlist/?country=DE&country=GB&country=AT&protocol=https&use_mirror_status=on' | sed -e 's/^#Server/Server/' -e '/^#/d' | rankmirrors -n 5 -";
      "bat" = "cat /sys/class/power_supply/BAT1/capacity";
      "bs" = "cat /sys/class/power_supply/BAT1/status";
      "bl" = "sudo ectool fwchargelimit";
      "mirror" = "wl-mirror 'eDP-1' & disown & exit";
      "dockerstart" = "sudo systemctl start docker";
      "dockerstop" = "sudo systemctl stop docker.socket docker.service";
      "fixtime" = "sudo timedatectl set-timezone Europe/Vienna; sudo timedatectl set-ntp true";
      "fixteams" = "sudo timedatectl set-local-rtc 0";
      "fixscreen" = "swaymsg 'output * dpms off' && sleep 1 && swaymsg 'output * dpms on'";
      "sd" = "shutdown now";
      "rb" = "reboot";
      "fixwifi" = "sudo modprobe -r mt7921e && sudo modprobe mt7921e";
      "lorem" = "tr -dc a-z1-4 </dev/urandom | tr 1-2 ' \n' | awk 'length==0 || length>50' | tr 3-4 ' ' | sed 's/^ *//' | cat -s | sed 's/ / /g' |fmt";
      "utf" = "python ~/Documents/PyProjects/UTF-Message-Encoder-Decoder/UTF16.py";
      "drain" = "stress --cpu 16 --io 4 --vm 5";
      "nv" = "neovide";
      "py" = "/run/current-system/sw/bin/python";
      "r" = "~/.config/nixos/scripts/repeat.fish";
      "eoc" = "~/.config/nixos/scripts/execute_on_change.fish";
      "mon" = "sudo airmon-ng check kill; sudo airmon-ng start wlan0; sleep 1; sudo airodump-ng -w ~/Work/Network/Capture.cap wlan0mon";
      "monstop" = "sudo airmon-ng stop wlan0mon; sudo systemctl start NetworkManager";
      "snake" = "putty -serial /dev/ttyACM0 -sercfg 921600,8,n,1,N -fn 'client:Hack Nerd Font 14' & disown & exit";
      "ser" = "putty -serial /dev/ttyUSB0 -sercfg 115200,8,n,1,N -fn 'client:Hack Nerd Font 14' & disown & exit";
      "raspi" = "ssh lostmia@192.168.1.66 -p 22122 -i ~/.ssh/raspi";
      "server" = "ssh mia@192.168.1.166 -p 22122 -i ~/.ssh/server";
      "int" = "ping 1.1.1.1";
      "todo" = "nvim ~/Documents/todo.md";
      "sa" = "libreoffice ~/Documents/Diplomarbeit/Stundenanzahl.ods & disown & exit";
      "ala" = "alacritty & disown";
      "timer" = "~/.config/nixos/scripts/waybar-timer.sh";
      "hollywood" = "sudo systemctl start docker; sudo docker run --rm -it bcbcarl/hollywood";
      "bridge" = "sudo ip link add name br0 type bridge; sudo ip link set br0 up; sudo ip link set enp195s0f3u1 master br0; sudo ip address add dev br0 10.255.255.80/24";
      "nixc" = "~/.config/nixos/scripts/nix_rebuild.sh";
      "nixr" = "sudo nixos-rebuild switch --flake ~/.config/nixos/#ming --impure";
      # generate on-the-fly automatic rebuild (for) nixOS
      "goarnix" = "sudo nixos-rebuild switch --flake ~/.config/nixos";
      "homer" = "home-manager switch --flake ~/.config/nixos --impure";
      "backup" = "~/.config/nixos/scripts/backup.sh & disown";
      "poweroff" = "sudo ectool led power off";
      "powernormal" = "sudo ectool led power auto";
      "tty" = "ls /dev/tty*";
      "f" = "fuck";
      "getinput" = "bash ~/.config/nixos/scripts/get_aoc_input.sh";
      "ai" = "ollama run llama3.2";
      "where" = "grep -ri";
      "picker" = "set -x message (hyprpicker -a) && notify-send -u low $message";
      "!!" = "history | head -n 1 | wl-copy";
      "projinit" = "~/.config/nixos/scripts/project_init.sh";
      "w" = "python ~/.config/nixos/scripts/w.py";
      "pi" = "curl https://ipseeker.io -s | cut -d'\"' -f 4 "; # Get the public ip
      "vpne" = "sudo systemctl start wg-quick-home.service";
      "vpnd" = "sudo systemctl stop wg-quick-home.service";
      "ns" = "nix-shell -p";
      "quote" = "bash ~/.config/nixos/scripts/edit_zitate.sh";
      # "ls" = "eza -g";
    };

    functions = {
      "cd" = ''
        set dir $argv[1]
        if [ "dir" = "" ]
          builtin cd $HOME
            else
          builtin cd $dir
        end
        ls
      '';

      "fish_prompt" = ''
        set -l last_status $status

        set -l normal (set_color normal)
        set -l usercolor (set_color $fish_color_user)

        #set -l delim \U25BA
        set -l delim ">"
        # If we don't have unicode use a simpler delimiter
        string match -qi "*.utf-8" -- $LANG $LC_CTYPE $LC_ALL; or set delim ">"

        fish_is_root_user; and set delim "#"

        set -l cwd (set_color $fish_color_cwd)
        if command -sq cksum
          # randomized cwd color
          # We hash the physical PWD and turn that into a color. That means directories (usually) get different colors,
          # but every directory always gets the same color. It's deterministic.
          # We use cksum because 1. it's fast, 2. it's in POSIX, so it should be available everywhere.
          set -l shas (pwd -P | cksum | string split -f1 ' ' | math --base=hex | string sub -s 3 | string pad -c 0 -w 6 | string match -ra ..)
          set -l col 0x$shas[1..3]

          # If the (simplified idea of) luminance is below 120 (out of 255), add some more.
          # (this runs at most twice because we add 60)
          while test (math 0.2126 x $col[1] + 0.7152 x $col[2] + 0.0722 x $col[3]) -lt 120
            set col[1] (math --base=hex "min(255, $col[1] + 60)")
            set col[2] (math --base=hex "min(255, $col[2] + 60)")
            set col[3] (math --base=hex "min(255, $col[3] + 60)")
          end
          set -l col (string replace 0x "" $col | string pad -c 0 -w 2 | string join "")

          set cwd (set_color $col)
        end

        # Prompt status only if it's not 0
        set -l prompt_status
        test $last_status -ne 0; and set prompt_status (set_color $fish_color_status)"[$last_status]$normal"

        # Only show host if in SSH or container
        # Store this in a global variable because it's slow and unchanging
        if not set -q prompt_host
          set -g prompt_host ""
          if set -q SSH_TTY
            or begin
              command -sq systemd-detect-virt
              and systemd-detect-virt -q
            end
            set prompt_host $usercolor$USER$normal@(set_color $fish_color_host)$hostname$normal":"
          end
        end

        # Shorten pwd if prompt is too long
        set -l pwd (prompt_pwd)

        echo -n -s $prompt_host $cwd $pwd $normal $prompt_status $delim " "
      '';

      "fish_right_prompt" = ''
        set -g __fish_git_prompt_showdirtystate 1
        set -g __fish_git_prompt_showuntrackedfiles 1
        set -g __fish_git_prompt_showupstream informative
        set -g __fish_git_prompt_showcolorhints 1
        set -g __fish_git_prompt_use_informative_chars 1
        # Unfortunately this only works if we have a sensible locale
        string match -qi "*.utf-8" -- $LANG $LC_CTYPE $LC_ALL
        and set -g __fish_git_prompt_char_dirtystate \U1F4a9
        set -g __fish_git_prompt_char_untrackedfiles "?"

        # The git prompt's default format is ' (%s)'.
        # We don't want the leading space.
        set -l vcs (fish_vcs_prompt '(%s)' 2>/dev/null)

        set -l d (set_color brgrey)(date "+%R")(set_color normal)

        set -l duration "$cmd_duration$CMD_DURATION"
        if test $duration -gt 100
          set duration (math $duration / 1000)s
        else
          set duration
        end

        set -q VIRTUAL_ENV_DISABLE_PROMPT
        or set -g VIRTUAL_ENV_DISABLE_PROMPT true
        set -q VIRTUAL_ENV
        and set -l venv (string replace -r '.*/' "" -- "$VIRTUAL_ENV")

        set_color normal
        string join " " -- $venv $duration $vcs $d
      '';
    };
  };
}
