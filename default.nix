{ stdenv, cmake, test_libyo}:

stdenv.mkDerivation rec {
  pname = "test_app";
  version = "0.1.0";
  src = ./.;
  cmakeBuildType = "Debug";
  nativeBuildInputs = [ cmake test_libyo ];
  propagatedBuildInputs = [ ];
  patchPhase = ''
    pwd
    pwd
    cp ${test_libyo}/debug/test_lib_source_dir.env .
  '';
  dontFixup = true;
  dontStrip = true;
  # dontPatchELF = true;
}
