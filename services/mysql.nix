{pkgs, ...}: {
  services.mysql = {
    enable = true;
    package = pkgs.mariadb;
    initialScript = pkgs.writeText "mariadb-init.sql" ''
      -- Regular Testing Database
      CREATE DATABASE IF NOT EXISTS mydb;
      CREATE USER IF NOT EXISTS 'mia'@'localhost' BY 'supersecure';
      GRANT ALL PRIVILEGES ON mydb.* TO 'mia'@'localhost';
      FLUSH PRIVILEGES;
    '';
  };
}
