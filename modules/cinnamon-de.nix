{ 
    config, 
    pkgs, 
    pkgs-stable,
    inputs,
    lib,
    ... 
}:

{
  options = {
    cinnamon.enable = lib.mkEnableOption "enable Cinnamon";
  };

  config = lib.mkIf config.cinnamon.enable {
    services.xserver.displayManager.lightdm.enable = true;
    services.xserver.desktopManager.cinnamon.enable = true;
    services.cinnamon.apps.enable = true;
  };
}