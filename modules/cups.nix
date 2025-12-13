{pkgs, ...}: {
  services.printing = {
    enable = true;
    drivers = with pkgs; [
      gutenprint
      cnijfilter2
      cnijfilter_4_00
      cnijfilter_2_80
      # labelife-label-printer
      lprint
    ];
  };
}
