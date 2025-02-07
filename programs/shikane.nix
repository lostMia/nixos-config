{...}: {
  home.file = {
    ".config/shikane/config.toml".text = ''
      [[profile]]
      name = "home"

      [[profile.output]]
      enable = true
      search = ["m=LG Ultra HD", "s=0x00054C29", "v=LG Electronics"]
      mode = "3840x2160@30Hz"
      position = "616,1011"
      scale = 1.0
      transform = "normal"
      adaptive_sync = false

      [[profile.output]]
      enable = true
      search = ["m=0x0BCA", "s=", "v=BOE"]
      mode = "2256x1504@59.999Hz"
      position = "1417,3171"
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
    '';
  };
}
