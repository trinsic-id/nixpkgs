/* Generated file. */
args @ { fetchurl, ... }:
rec {
  baseName = "dexador";
  version = "20210807-git";

  description = "Yet another HTTP client for Common Lisp";

  deps = [ args."alexandria" args."babel" args."bordeaux-threads" args."cffi" args."cffi-grovel" args."cffi-toolchain" args."chipz" args."chunga" args."cl_plus_ssl" args."cl-base64" args."cl-cookie" args."cl-ppcre" args."cl-reexport" args."cl-utilities" args."fast-http" args."fast-io" args."flexi-streams" args."local-time" args."proc-parse" args."quri" args."smart-buffer" args."split-sequence" args."static-vectors" args."trivial-features" args."trivial-garbage" args."trivial-gray-streams" args."trivial-mimes" args."usocket" args."xsubseq" ];

  src = fetchurl {
    url = "http://beta.quicklisp.org/archive/dexador/2021-08-07/dexador-20210807-git.tgz";
    sha256 = "04x29nr2h70b08yail6mf2pgpcgqwx3zxdizkzrj4mv6mi8pdy29";
  };

  packageName = "dexador";

  asdFilesToKeep = ["dexador.asd"];
  overrides = x: x;
}
/* (SYSTEM dexador DESCRIPTION Yet another HTTP client for Common Lisp SHA256
    04x29nr2h70b08yail6mf2pgpcgqwx3zxdizkzrj4mv6mi8pdy29 URL
    http://beta.quicklisp.org/archive/dexador/2021-08-07/dexador-20210807-git.tgz
    MD5 92b460917f8fa1c668c770fa850de5c7 NAME dexador FILENAME dexador DEPS
    ((NAME alexandria FILENAME alexandria) (NAME babel FILENAME babel)
     (NAME bordeaux-threads FILENAME bordeaux-threads)
     (NAME cffi FILENAME cffi) (NAME cffi-grovel FILENAME cffi-grovel)
     (NAME cffi-toolchain FILENAME cffi-toolchain) (NAME chipz FILENAME chipz)
     (NAME chunga FILENAME chunga) (NAME cl+ssl FILENAME cl_plus_ssl)
     (NAME cl-base64 FILENAME cl-base64) (NAME cl-cookie FILENAME cl-cookie)
     (NAME cl-ppcre FILENAME cl-ppcre) (NAME cl-reexport FILENAME cl-reexport)
     (NAME cl-utilities FILENAME cl-utilities)
     (NAME fast-http FILENAME fast-http) (NAME fast-io FILENAME fast-io)
     (NAME flexi-streams FILENAME flexi-streams)
     (NAME local-time FILENAME local-time)
     (NAME proc-parse FILENAME proc-parse) (NAME quri FILENAME quri)
     (NAME smart-buffer FILENAME smart-buffer)
     (NAME split-sequence FILENAME split-sequence)
     (NAME static-vectors FILENAME static-vectors)
     (NAME trivial-features FILENAME trivial-features)
     (NAME trivial-garbage FILENAME trivial-garbage)
     (NAME trivial-gray-streams FILENAME trivial-gray-streams)
     (NAME trivial-mimes FILENAME trivial-mimes)
     (NAME usocket FILENAME usocket) (NAME xsubseq FILENAME xsubseq))
    DEPENDENCIES
    (alexandria babel bordeaux-threads cffi cffi-grovel cffi-toolchain chipz
     chunga cl+ssl cl-base64 cl-cookie cl-ppcre cl-reexport cl-utilities
     fast-http fast-io flexi-streams local-time proc-parse quri smart-buffer
     split-sequence static-vectors trivial-features trivial-garbage
     trivial-gray-streams trivial-mimes usocket xsubseq)
    VERSION 20210807-git SIBLINGS (dexador-test) PARASITES NIL) */
