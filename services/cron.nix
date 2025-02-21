{...}: {
  services.cron = {
    enable = true;
    systemCronJobs = [
      "0 0 * * Sat  mia  bash /home/mia/.config/nixos/scripts/SL_saturday_my_dudes.sh"
      "* * * * *  mia  bash /home/mia/.config/nixos/scripts/SL_saturday_my_dudes.sh"
    ];
  };
}
