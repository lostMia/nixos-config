{...}: {
  services.cron = {
    enable = true;
    systemCronJobs = [
      "* * * * *  mia  echo Hello World > /home/mia/cronout"
    ];
  };
}
