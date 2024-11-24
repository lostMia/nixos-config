{
  config,
  pkgs,
  ...
}: {
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
    '';
  };
}
