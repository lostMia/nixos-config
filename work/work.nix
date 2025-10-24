{pkgs, ...}: {
  services.mysql = {
    initialScript = pkgs.writeText "mariadb-init.sql" ''
      -- Work Testing Database
      CREATE DATABASE IF NOT EXISTS BikeFux;
      CREATE USER IF NOT EXISTS 'bikefux'@'localhost' IDENTIFIED BY 'supersecure';
      GRANT ALL PRIVILEGES ON *.* TO 'bikefux'@'localhost' WITH GRANT OPTION;
      FLUSH PRIVILEGES;
    '';
  };
}
