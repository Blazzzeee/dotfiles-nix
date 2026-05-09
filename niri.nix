{
  config,
  lib,
  niriEnabled,
  ...
}:
lib.mkIf niriEnabled {
  xdg.configFile."niri/config.kdl".source = ./niri/config.kdl;
}
