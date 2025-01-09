{
  stdenvNoCC,
  fetchFromGitHub,
  lib,
}:
stdenvNoCC.mkDerivation {
  pname = "illinois-mono";
  version = "0.0.1";
  src = fetchFromGitHub {
    owner = "MadSimple";
    repo = "illinois-mono";
    rev = "67c38f56eaa0fa437d6484d734ed23233f2932d6";
    hash = "sha256-Q4aJZRTz/rSQ0c+NRorP6X09j3QHW2sTKqzVn5QlnWs=";
  };

  installPhase = ''
    install -Dm644 -t $out/share/fonts/truetype/ *.ttf
  '';

  meta = with lib; {
    description = "Illinois Mono";
    homepage = "https://github.com/MadSimple/illinois-mono";
    platforms = platforms.all;
  };
}
