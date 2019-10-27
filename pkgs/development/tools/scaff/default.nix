{ lib, rustPlatform, fetchFromGitLab, pkgconfig, openssl }:

rustPlatform.buildRustPackage rec {
  pname = "scaff";
  version = "0.1.1";

  src = fetchFromGitLab {
    owner = "jD91mZM2";
    repo = pname;
    rev = version;

    sha256 = "1s5v50205l2h33pccyafrjv3a6lpb62inhm8z81hkvx53bqifvd7";
  };

  cargoSha256 = "17rnzwlgrpr6isbajaccxa83msvvskxyqrc4cirgjmc7aqa0ilbh";

  nativeBuildInputs = [ pkgconfig ];
  buildInputs = [ openssl ];

  meta = with lib; {
    description = "Painless and powerful scaffolding of projects";
    license = licenses.mit;
    maintainers = with maintainers; [ jD91mZM2 ];
    platforms = platforms.unix;
  };
}
