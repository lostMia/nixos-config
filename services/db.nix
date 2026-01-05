{pkgs, ...}: {
  services.mysql = {
    enable = true;
    package = pkgs.mariadb;
    settings = {
      mysqld = {
        lower_case_table_names = 1;
      };
    };
    # initialScript = pkgs.writeText "mariadb-init.sql" ''
    #   -- Regular Testing Database
    #   CREATE DATABASE IF NOT EXISTS mydb;
    #   CREATE USER IF NOT EXISTS 'mia'@'localhost' BY 'supersecure';
    #   GRANT ALL PRIVILEGES ON mydb.* TO 'mia'@'localhost';
    #   FLUSH PRIVILEGES;
    # '';
  };
}
