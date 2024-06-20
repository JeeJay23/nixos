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
    kdeplasma.enable = lib.mkEnableOption "enable KDE plasma";
  };

  config = lib.mkIf config.kdeplasma.enable {
    services.displayManager.sddm.enable = true;
    services.desktopManager.plasma6.enable = true;
    services.xserver.displayManager.defaultSession = "plasmax11";
  };
}