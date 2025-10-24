{...}: {
  home.file = {
    ".config/shikane/config.toml".text = ''
      [[profile]]
      name = "home"

      [[profile.output]]
      enable = true
      search = ["m=LG Ultra HD", "s=0x00054C29", "v=LG Electronics"]
      mode = "2560x1440@59.951Hz"
      position = "2256,0"
      scale = 1.0
      transform = "normal"
      adaptive_sync = false

      [[profile.output]]
      enable = true
      search = ["m=0x0BCA", "s=", "v=BOE"]
      mode = "2256x1504@59.999Hz"
      position = "2394,1440"
      scale = 1.0
      transform = "normal"
      adaptive_sync = false


      [[profile]]
      name = "htlec"

      [[profile.output]]
      enable = true
      search = ["m=0x0BCA", "s=", "v=BOE"]
      mode = "2256x1504@59.999Hz"
      position = "1766,1430"
      scale = 1.0
      transform = "normal"
      adaptive_sync = false

      [[profile.output]]
      enable = true
      search = ["m=S22C450", "s=H4FG601321", "v=Samsung Electric Company"]
      mode = "1920x1080@60Hz"
      position = "1954,350"
      scale = 1.0
      transform = "normal"
      adaptive_sync = false

      [[profile]]
      name = "htlec2"

      [[profile.output]]
      enable = true
      search = ["m=0x0BCA", "s=", "v=BOE"]
      mode = "2256x1504@59.999Hz"
      position = "1317,1363"
      scale = 1.0
      transform = "normal"
      adaptive_sync = false

      [[profile.output]]
      enable = true
      search = ["m=S22C450", "s=H4MG202424", "v=Samsung Electric Company"]
      mode = "1680x1050@59.954Hz"
      position = "1595,313"
      scale = 1.0
      transform = "normal"
      adaptive_sync = false

      [[profile]]
      name = "htlec-server"

      [[profile.output]]
      enable = true
      search = ["m=0x0BCA", "s=", "v=BOE"]
      mode = "2256x1504@59.999Hz"
      position = "1232,1438"
      scale = 1.0
      transform = "normal"
      adaptive_sync = false

      [[profile.output]]
      enable = true
      search = ["m=E22W-5", "s=YV2C200835", "v=Fujitsu Siemens Computers GmbH"]
      mode = "1680x1050@59.954Hz"
      position = "1538,388"
      scale = 1.0
      transform = "normal"
      adaptive_sync = false

      [[profile]]
      name = "htlec-dual-monitor"

      [[profile.output]]
      enable = true
      search = ["m=S22C450", "s=H4MG202424", "v=Samsung Electric Company"]
      mode = "1680x1050@59.954Hz"
      position = "3160,1093"
      scale = 1.0
      transform = "normal"
      adaptive_sync = false

      [[profile.output]]
      enable = true
      search = ["m=0x0BCA", "s=", "v=BOE"]
      mode = "2256x1504@59.999Hz"
      position = "2882,2143"
      scale = 1.0
      transform = "normal"
      adaptive_sync = false

      [[profile.output]]
      enable = true
      search = ["m=B226WL", "s=LXVEE0018510", "v=Acer Technologies"]
      mode = "1680x1050@59.975Hz"
      position = "1480,1093"
      scale = 1.0
      transform = "normal"
      adaptive_sync = false

      [[profile]]
      name = "work"

      [[profile.output]]
      enable = true
      search = ["m=U34G2G4R3", "s=0x00000D5E", "v=AOC"]
      mode = "3440x1440@59.973Hz"
      position = "1110,687"
      scale = 1.0
      transform = "normal"
      adaptive_sync = false

      [[profile.output]]
      enable = true
      search = ["m=0x0BCA", "s=", "v=BOE"]
      mode = "2256x1504@59.999Hz"
      position = "1700,2127"
      scale = 1.0
      transform = "normal"
      adaptive_sync = false
    '';
  };
}
