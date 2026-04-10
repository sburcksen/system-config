{ config, lib, ... }:

{
  options.desktop.audio.enable = lib.mkSubOption config.desktop.enable "audio interface";

  config = lib.mkIf config.desktop.audio.enable {
    services.pipewire = {
      enable = true;
      audio.enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
  };
}
