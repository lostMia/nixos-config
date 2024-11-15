{
  config,
  pkgs,
  unstable,
  ...
}: {
  services.blueman.enable = true;

  hardware.bluetooth.enable = true;
  hardware.bluetooth.settings = {
    General = {
      Enable = "Source,Sink,Media,Socket";
    };
  };
}
