{...}: {
  services.cron = {
    enable = true;
    systemCronJobs = [
      "* * * * *  test   ls -l / > /tmp/cronout 2>&1"
      "* * * * *  eelco  echo Hello World > /home/eelco/cronout"
    ];
  };
}
