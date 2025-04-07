{pkgs, ...}: {
  services.mysql = {
    enable = true;
    package = pkgs.mariadb;
    initialScript = pkgs.writeText "mariadb-init.sql" ''
      CREATE DATABASE IF NOT EXISTS mydb;
      CREATE USER IF NOT EXISTS 'mia'@'localhost' IDENTIFIED WITH mysql_native_password BY 'supersecure';
      GRANT ALL PRIVILEGES ON mydb.* TO 'mia'@'localhost';
      FLUSH PRIVILEGES;
    '';
  };
}
