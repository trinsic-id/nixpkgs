{ stdenv, lib, fetchFromGitHub, fetchpatch, cmake, flex, bison, systemd
, boost, openssl, patchelf, mariadb-connector-c, postgresql, zlib
# Databases
, withMysql ? true, withPostgresql ? false
# Features
, withChecker ? true, withCompat ? false, withLivestatus ? false
, withNotification ? true, withPerfdata ? true, withIcingadb ? true
, nameSuffix ? "" }:

stdenv.mkDerivation rec {
  pname = "icinga2${nameSuffix}";
  version = "2.13.2";

  src = fetchFromGitHub {
    owner = "icinga";
    repo = "icinga2";
    rev = "v${version}";
    sha256 = "sha256:1ijvav2ymgq1i8jycrqbp2y4r54y0dkwjnwxc20bmcixxh877zdn";
  };

  patches = [
    ./etc-icinga2.patch # Makes /etc/icinga2 relative to / instead of the store path
    ./no-systemd-service.patch # Prevent systemd service from being written to /usr
    ./no-var-directories.patch # Prevent /var directories from being created
    # Fix the non-unity build
    (fetchpatch {
      url = "https://github.com/Icinga/icinga2/commit/2ad0a4b8c3852ad937fec9fc85780230257c821e.patch";
      sha256 = "sha256:06qn7x73zbccmd8ycj46a29x2rr6qjwg0rr831wc2gc6q2k9d2g0";
    })
  ];

  cmakeFlags = let
    mkFeatureFlag = label: value: "-DICINGA2_WITH_${label}=${if value then "ON" else "OFF"}";
  in [
    # Paths
    "-DCMAKE_INSTALL_SYSCONFDIR=etc"
    "-DCMAKE_INSTALL_LOCALSTATEDIR=/var"
    "-DCMAKE_INSTALL_FULL_SBINDIR=bin"
    "-DICINGA2_RUNDIR=/run"
    "-DMYSQL_INCLUDE_DIR=${mariadb-connector-c.dev}/include/mariadb"
    "-DMYSQL_LIB=${mariadb-connector-c.out}/lib/mariadb/libmysqlclient.a"
    "-DICINGA2_PLUGINDIR=bin"
    "-DICINGA2_UNITY_BUILD=no"
    # Features
    (mkFeatureFlag "MYSQL" withMysql)
    (mkFeatureFlag "PGSQL" withPostgresql)
    (mkFeatureFlag "CHECKER" withChecker)
    (mkFeatureFlag "COMPAT" withCompat)
    (mkFeatureFlag "LIVESTATUS" withLivestatus)
    (mkFeatureFlag "NOTIFICATION" withNotification)
    (mkFeatureFlag "PERFDATA" withPerfdata)
    (mkFeatureFlag "ICINGADB" withIcingadb)
    # Misc.
    "-DICINGA2_USER=icinga2"
    "-DICINGA2_GROUP=icinga2"
    "-DICINGA2_GIT_VERSION_INFO=OFF"
    "-DICINGA2_WITH_TESTS=OFF"
    "-DUSE_SYSTEMD=ON"
  ];

  buildInputs = [ boost openssl systemd ]
    ++ lib.optional withPostgresql postgresql;

  nativeBuildInputs = [ cmake flex bison patchelf ];

  postFixup = ''
    rm -r $out/etc/logrotate.d $out/etc/sysconfig $out/lib/icinga2/prepare-dirs

    # Fix hardcoded paths
    sed -i 's:/usr/bin/::g' $out/etc/icinga2/scripts/*

    # Cleanup sbin
    sed -i 's/sbin/bin/g' $out/lib/icinga2/safe-reload
    rm $out/sbin

    ${lib.optionalString withMysql ''
      # Add dependencies of the MySQL shim to the shared library
      patchelf --add-needed ${zlib.out}/lib/libz.so $(readlink -f $out/lib/icinga2/libmysql_shim.so)

      # Make Icinga find the MySQL shim
      icinga2Bin=$out/lib/icinga2/sbin/icinga2
      patchelf --set-rpath $out/lib/icinga2:$(patchelf --print-rpath $icinga2Bin) $icinga2Bin
    ''}
  '';

  vim = stdenv.mkDerivation {
    pname = "vim-icinga2";
    inherit version src;

    dontConfigure = true;
    dontBuild = true;

    installPhase = ''
      mkdir -p $out/share/vim-plugins
      cp -r tools/syntax/vim $out/share/vim-plugins/icinga2
    '';
  };

  meta = {
    description = "Open source monitoring system";
    homepage = "https://www.icinga.com";
    license = lib.licenses.gpl2Plus;
    platforms = lib.platforms.linux;
    maintainers = with lib.maintainers; [ das_j ];
  };
}
