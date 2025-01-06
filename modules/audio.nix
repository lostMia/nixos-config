{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    pavucontrol
    pwvucontrol
    pamixer
    pipewire
    wireplumber
  ];

  # Disable pulseaudio.
  hardware.pulseaudio.enable = false;

  # Enabel pipewire.
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
}
