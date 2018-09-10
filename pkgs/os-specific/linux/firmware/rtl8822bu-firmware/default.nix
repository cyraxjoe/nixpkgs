{ stdenv, lib, linuxPackages }:

with lib;

stdenv.mkDerivation rec {
  name = "rtl8822bu_firmware-${linuxPackages.rtlwifi_new.version}";
  inherit (linuxPackages.rtl8822bu) src;

  dontBuild = true;

  installPhase = ''
    mkdir -p "$out/lib/firmware/rtlwifi"
    cp -f  firmware/* "$out/lib/firmware/rtlwifi"
  '';

  meta = {
    description = "Firmware for the Realtek 8822bu";
    inherit (src.meta) homepage;
    license = licenses.unfreeRedistributableFirmware;
    platforms = with platforms; linux;
  };
}
