{ stdenv
, fetchurl
, intltool
, pkgconfig
, gtk3
, ibus
, libhangul
, python3
}:

stdenv.mkDerivation rec {
  pname = "ibus-hangul";
  version = "1.5.1";

  src = fetchurl {
    url = "https://github.com/choehwanjin/ibus-hangul/releases/download/${version}/${pname}-${version}.tar.gz";
    sha256 = "0gha8dfdf54rx8fv3yfikbgdg6lqq6l883lhg7q68ybvkjx9bwbs";
  };

  nativeBuildInputs = [
    intltool
    pkgconfig
    python3.pkgs.wrapPython
  ];

  buildInputs = [
    gtk3
    ibus
    libhangul
    python3
  ];

  postFixup = "wrapPythonPrograms";

  meta = with stdenv.lib; {
    isIbusEngine = true;
    description = "Ibus Hangul engine";
    homepage = https://github.com/choehwanjin/ibus-hangul;
    license = licenses.gpl2;
    maintainers = with maintainers; [ ericsagnes ];
    platforms = platforms.linux;
  };
}
