{...}: {
  services.cron = {
    enable = true;
    systemCronJobs = [
      "* * * * *  test   ls -l / > /tmp/cronout 2>&1"
      "* * * * *  mia  echo Hello World > /home/mia/cronout"
    ];
  };
}
