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
      name = "work"

      [[profile.output]]
      enable = true
      search = ["m=0x0BCA", "s=", "v=BOE"]
      mode = "2256x1504@59.999Hz"
      position = "0,1858"
      scale = 1.0
      transform = "normal"
      adaptive_sync = false

      [[profile.output]]
      enable = true
      search = ["m=U34G2G4R3", "s=0x00000D5E", "v=AOC"]
      mode = "3440x1440@59.973Hz"
      position = "2256,777"
      scale = 1.0
      transform = "normal"
      adaptive_sync = false

      [[profile.output]]
      enable = true
      search = ["m=PL2792Q", "s=1152104402146", "v=Iiyama North America"]
      mode = "2560x1440@59.951Hz"
      position = "5696,777"
      scale = 1.0
      transform = "normal"
      adaptive_sync = false
    '';
  };
}
