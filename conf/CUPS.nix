{ config, pkgs, ... }:
{
  services.printing = {
    enable = true;
    drivers = with pkgs; [ hplipWithPlugin epson-escpr gutenprint splix cups-bjnp
                           gutenprintBin samsungUnifiedLinuxDriver ghostscript ]; };
}
