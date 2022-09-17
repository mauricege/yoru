{ self, ... }@inputs:
{ options, config, lib, pkgs, ... }:
let
  cfg = config.programs.yoru;
  inherit (lib) literalExample mkEnableOption mkIf mkMerge mkOption optional types;

in
{
  options.programs.yoru = {
      enable = mkEnableOption "Yoru AwesomeWM rice";
    };

  config = mkMerge [
    (mkIf cfg.enable {
      programs.wezterm.enable = true;
    })
  ];
}
