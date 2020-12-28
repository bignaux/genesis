{ stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  version = "unstable-2020-28-07";
  pname = "hdl_dump";

  src = fetchFromGitHub {
    owner = "ps2homebrew";
    repo = "hdl-dump";
    rev = "976033b8da3f55be612d085d38ef4d21117136ee";
    sha256 = "0f8ifahvlzq7ds57c7m84vzpaj9ik8j53i2xkx4nqkg86kpm7nsi";
  };

  installPhase = ''
    install -Dm755 hdl_dump -t $out/bin
  '';

  meta = with stdenv.lib; {
    inherit (src.meta) homepage;
    description = "PlayStation 2 HDLoader image dump/install utility";
    platforms = platforms.linux;
    license = licenses.gpl2;
    maintainers = with maintainers; [ genesis ];
  };
}
