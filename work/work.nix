{pkgs, ...}: {
  services.mysql = {
    initialScript = pkgs.writeText "initial-script" ''
      CREATE DATABASE IF NOT EXISTS `bikefux_junit`;
      CREATE USER IF NOT EXISTS 'bike'@'%' IDENTIFIED WITH mysql_native_password;
      ALTER USER 'bike'@'%' IDENTIFIED BY 'bike4u';
      GRANT ALL PRIVILEGES ON *.* TO 'bike'@'%' IDENTIFIED BY "bike4u" WITH GRANT OPTION;
    '';
    # initialScript = pkgs.writeText "mariadb-init.sql" ''
    #   -- Work Testing Database
    #   CREATE DATABASE IF NOT EXISTS BikeFux;
    #   CREATE USER IF NOT EXISTS 'bike'@'localhost' IDENTIFIED BY 'supersecure';
    #   GRANT ALL PRIVILEGES ON *.* TO 'bikefux'@'localhost' WITH GRANT OPTION;
    #   FLUSH PRIVILEGES;
    # '';
  };
}
