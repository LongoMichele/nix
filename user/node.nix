{ config, lib, pkgs, userSettings, ... }:
let
  npmGlobalDir = "${userSettings.home}/.npm-global";
in {
  home = {
    packages = [ pkgs.nodejs_22 ];
    sessionVariables.NPM_CONFIG_PREFIX = npmGlobalDir;
    sessionPath = [ "${npmGlobalDir}/bin" ];
    activation = {
      init = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        mkdir -p ${npmGlobalDir}/bin
      '';
    };
  };
}
