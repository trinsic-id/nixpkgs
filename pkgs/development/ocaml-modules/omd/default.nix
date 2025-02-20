{ stdenv, lib, fetchurl, ocaml, findlib, ocamlbuild }:

stdenv.mkDerivation {
  name = "ocaml${ocaml.version}-omd-1.3.1";
  src = fetchurl {
    url = "https://github.com/Chris00/omd/releases/download/1.3.1/omd-1.3.1.tar.gz";
    sha256 = "1sgdgzpx96br7npj8mh91cli5mqmzsjpngwm7x4212n3k1d0ivwa";
  };

  buildInputs = [ ocaml findlib ocamlbuild ];

  createFindlibDestdir = true;

  configurePhase = ''
    runHook preConfigure
    ocaml setup.ml -configure --prefix $out
    runHook postConfigure
  '';

  meta = {
    description = "Extensible Markdown library and tool in OCaml";
    homepage = "https://github.com/ocaml/omd";
    license = lib.licenses.isc;
    maintainers = [ lib.maintainers.vbgl ];
    inherit (ocaml.meta) platforms;
  };
}
