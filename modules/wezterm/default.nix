{ self, ... }@inputs:
{ options, config, lib, pkgs, ... }:
let
  cfg = config.programs.wezterm;
  inherit (lib) mkEnableOption mkIf mkMerge;

in
{
  options.programs.wezterm = {
    enable = mkEnableOption "Yoru AwesomeWM rice";
  };

  config = mkMerge [
    (mkIf cfg.enable {
      home.packages = [ pkgs.wezterm pkgs.aesthetic-iosevka ];
      xdg.configFile."wezterm/wezterm.lua".source = ../../config/wezterm/wezterm.lua;
    })
  ];
}
