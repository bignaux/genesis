{ stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  pname = "rasm";
  version = "1.3";

  src = fetchFromGitHub {
    owner = "EdouardBERGE";
    repo = "rasm";
    rev = "v${version}";
    sha256 = "18q75vkaqpg96kki99zwmgc3px6sr094jzqv91cdd7xr053kyqmv";
  };

  makeFlags = [ "EXEC=rasm" ];
  installPhase = ''
    install -Dt $out/bin rasm
  '';

  meta = with stdenv.lib; {
    homepage = "http://www.roudoudou.com/rasm/";
    description = "Z80 assembler";
    # use -n option to display all licenses
    license = licenses.mit; # expat version
    maintainers = [ maintainers.genesis ];
    platforms = platforms.linux;
  };
}
