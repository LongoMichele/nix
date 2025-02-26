{
  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = false;
    };
  };

  services = {
    pipewire = {
      wireplumber.extraConfig.bluetoothEnhancements = {
        "monitor.bluez.properties" = {
          "bluez5.enable-sbc-xq" = true;
          "bluez5.enable-msbc" = true;
          "bluez5.enable-hw-volume" = true;
          "bluez5.roles" = [ "hsp_hs" "hsp_ag" "hfp_hf" "hfp_ag" ];
        };
      };
    };

    blueman.enable = true;
  };
}
