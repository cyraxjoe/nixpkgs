{ stdenv, fetchFromGitHub, fetchpatch, kernel, bc }:

stdenv.mkDerivation rec {
  name = "rtl8822bu-${kernel.version}-${version}";
  version = "5.2.4_master";

  src = fetchFromGitHub {
    owner = "ulli-kroll";
    repo = "rtl8822bu";
    rev = "425cd247da56678f46153a88b728dc603e85374d";
    sha256 = "0mph5ssvbz140w2rrw3f4wvy6amg7i0nk59qssxs2z2y9z02gfwz";
  };

  nativeBuildInputs = [ bc ];
  buildInputs = kernel.moduleBuildDependencies;

  hardeningDisable = [ "pic" "format" ];

  patches = [ ./Makefile.patch ];

  postPatch = ''
    substituteInPlace ./Makefile --replace /lib/modules/ "${kernel.dev}/lib/modules/"
    substituteInPlace ./Makefile --replace '$(shell uname -r)' "${kernel.modDirVersion}"
    substituteInPlace ./Makefile --replace '$(MODDESTDIR)' "$out/lib/modules/${kernel.modDirVersion}/kernel/net/wireless/"
  '';

  preInstall = ''
    mkdir -p "$out/lib/modules/${kernel.modDirVersion}/kernel/net/wireless/"
  '';

  meta = with stdenv.lib; {
    description = "Linux kernel driver for Realtek Wireless Dual-Band USB Adapter rtl8822bu/rtl8812bu ";
    homepage = https://github.com/ulli-kroll/rtl8822bu;
    license = licenses.gpl2;
    platforms = [ "x86_64-linux" "i686-linux" ];
  };
}
