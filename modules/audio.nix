{pkgs, ...}: {
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
