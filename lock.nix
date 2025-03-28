{ fetchurl }:
let
  fetchMaven = { name, urls, hash, installPath }: with builtins;
    let
      firstUrl = head urls;
      otherUrls = filter (elem: elem != firstUrl) urls;
    in
    fetchurl {
      inherit name hash;
      passthru = { inherit installPath; };
      url = firstUrl;
      recursiveHash = true;
      downloadToTemp = true;
      postFetch = ''
        mkdir -p "$out"
        cp -v "$downloadedFile" "$out/${baseNameOf firstUrl}"
      '' + concatStringsSep "\n"
        (map
          (elem:
            let filename = baseNameOf elem; in ''
              downloadedFile=$TMPDIR/${filename}
              tryDownload ${elem}
              cp -v "$TMPDIR/${filename}" "$out/"
            '')
          otherUrls);
    };
in
{

  "commons-codec_commons-codec-1.17.0" = fetchMaven {
    name = "commons-codec_commons-codec-1.17.0";
    urls = [ "https://repo1.maven.org/maven2/commons-codec/commons-codec/1.17.0/commons-codec-1.17.0.jar" "https://repo1.maven.org/maven2/commons-codec/commons-codec/1.17.0/commons-codec-1.17.0.pom" ];
    hash = "sha256-rNXCmSoMZ3Hx493sMGpc4SCAgPOJ8TBZNlPtmFMGw5M=";
    installPath = "https/repo1.maven.org/maven2/commons-codec/commons-codec/1.17.0";
  };

  "commons-io_commons-io-2.18.0" = fetchMaven {
    name = "commons-io_commons-io-2.18.0";
    urls = [ "https://repo1.maven.org/maven2/commons-io/commons-io/2.18.0/commons-io-2.18.0.jar" "https://repo1.maven.org/maven2/commons-io/commons-io/2.18.0/commons-io-2.18.0.pom" ];
    hash = "sha256-VrNF9aYN/xZddMiPVnJgXu9Pbv3leLTX+h31aBWzEUY=";
    installPath = "https/repo1.maven.org/maven2/commons-io/commons-io/2.18.0";
  };

  "com.eed3si9n_shaded-jawn-parser_2.13-1.3.2" = fetchMaven {
    name = "com.eed3si9n_shaded-jawn-parser_2.13-1.3.2";
    urls = [ "https://repo1.maven.org/maven2/com/eed3si9n/shaded-jawn-parser_2.13/1.3.2/shaded-jawn-parser_2.13-1.3.2.jar" "https://repo1.maven.org/maven2/com/eed3si9n/shaded-jawn-parser_2.13/1.3.2/shaded-jawn-parser_2.13-1.3.2.pom" ];
    hash = "sha256-k0UsS5J5CXho/H4FngEcxAkNJ2ZjpecqDmKBvxIMuBs=";
    installPath = "https/repo1.maven.org/maven2/com/eed3si9n/shaded-jawn-parser_2.13/1.3.2";
  };

  "com.eed3si9n_shaded-scalajson_2.13-1.0.0-M4" = fetchMaven {
    name = "com.eed3si9n_shaded-scalajson_2.13-1.0.0-M4";
    urls = [ "https://repo1.maven.org/maven2/com/eed3si9n/shaded-scalajson_2.13/1.0.0-M4/shaded-scalajson_2.13-1.0.0-M4.jar" "https://repo1.maven.org/maven2/com/eed3si9n/shaded-scalajson_2.13/1.0.0-M4/shaded-scalajson_2.13-1.0.0-M4.pom" ];
    hash = "sha256-JyvPek41KleFIS5g4bqLm+qUw5FlX51/rnvv/BT2pk0=";
    installPath = "https/repo1.maven.org/maven2/com/eed3si9n/shaded-scalajson_2.13/1.0.0-M4";
  };

  "com.eed3si9n_sjson-new-core_2.13-0.10.1" = fetchMaven {
    name = "com.eed3si9n_sjson-new-core_2.13-0.10.1";
    urls = [ "https://repo1.maven.org/maven2/com/eed3si9n/sjson-new-core_2.13/0.10.1/sjson-new-core_2.13-0.10.1.jar" "https://repo1.maven.org/maven2/com/eed3si9n/sjson-new-core_2.13/0.10.1/sjson-new-core_2.13-0.10.1.pom" ];
    hash = "sha256-sFHoDAQBTHju2EgUOPuO9tM/SLAdb8X/oNSnar0iYoQ=";
    installPath = "https/repo1.maven.org/maven2/com/eed3si9n/sjson-new-core_2.13/0.10.1";
  };

  "com.eed3si9n_sjson-new-core_2.13-0.9.0" = fetchMaven {
    name = "com.eed3si9n_sjson-new-core_2.13-0.9.0";
    urls = [ "https://repo1.maven.org/maven2/com/eed3si9n/sjson-new-core_2.13/0.9.0/sjson-new-core_2.13-0.9.0.pom" ];
    hash = "sha256-WlJsXRKj77jzoFN6d1V/+jAEl37mxggg85F3o8oD+bY=";
    installPath = "https/repo1.maven.org/maven2/com/eed3si9n/sjson-new-core_2.13/0.9.0";
  };

  "com.eed3si9n_sjson-new-scalajson_2.13-0.10.1" = fetchMaven {
    name = "com.eed3si9n_sjson-new-scalajson_2.13-0.10.1";
    urls = [ "https://repo1.maven.org/maven2/com/eed3si9n/sjson-new-scalajson_2.13/0.10.1/sjson-new-scalajson_2.13-0.10.1.jar" "https://repo1.maven.org/maven2/com/eed3si9n/sjson-new-scalajson_2.13/0.10.1/sjson-new-scalajson_2.13-0.10.1.pom" ];
    hash = "sha256-DBGJ34c7lyt3m4o5ULwsRk1xPqtHHHKcNgU4nlO/dJY=";
    installPath = "https/repo1.maven.org/maven2/com/eed3si9n/sjson-new-scalajson_2.13/0.10.1";
  };

  "com.fasterxml_oss-parent-41" = fetchMaven {
    name = "com.fasterxml_oss-parent-41";
    urls = [ "https://repo1.maven.org/maven2/com/fasterxml/oss-parent/41/oss-parent-41.pom" ];
    hash = "sha256-Lz63NGj0J8xjePtb7p69ACd08meStmdjmgtoh9zp2tQ=";
    installPath = "https/repo1.maven.org/maven2/com/fasterxml/oss-parent/41";
  };

  "com.fasterxml_oss-parent-50" = fetchMaven {
    name = "com.fasterxml_oss-parent-50";
    urls = [ "https://repo1.maven.org/maven2/com/fasterxml/oss-parent/50/oss-parent-50.pom" ];
    hash = "sha256-2z6+ukMOEKSrgEACAV2Qo5AF5bBFbMhoZVekS4VelPQ=";
    installPath = "https/repo1.maven.org/maven2/com/fasterxml/oss-parent/50";
  };

  "com.fasterxml_oss-parent-58" = fetchMaven {
    name = "com.fasterxml_oss-parent-58";
    urls = [ "https://repo1.maven.org/maven2/com/fasterxml/oss-parent/58/oss-parent-58.pom" ];
    hash = "sha256-wVCyn9u4Q5PMWSigrfRD2c90jacWbffIBxjXZq/VOSw=";
    installPath = "https/repo1.maven.org/maven2/com/fasterxml/oss-parent/58";
  };

  "com.fasterxml_oss-parent-61" = fetchMaven {
    name = "com.fasterxml_oss-parent-61";
    urls = [ "https://repo1.maven.org/maven2/com/fasterxml/oss-parent/61/oss-parent-61.pom" ];
    hash = "sha256-lZ8EM5Hz6HV9EYjiL2vc9lP5ORQVR/utOZ5Dc18O6TA=";
    installPath = "https/repo1.maven.org/maven2/com/fasterxml/oss-parent/61";
  };

  "com.lihaoyi_fansi_2.13-0.5.0" = fetchMaven {
    name = "com.lihaoyi_fansi_2.13-0.5.0";
    urls = [ "https://repo1.maven.org/maven2/com/lihaoyi/fansi_2.13/0.5.0/fansi_2.13-0.5.0.jar" "https://repo1.maven.org/maven2/com/lihaoyi/fansi_2.13/0.5.0/fansi_2.13-0.5.0.pom" ];
    hash = "sha256-iRaKoBsS7VOiQA0yj/wRNKo2NCHWteW0gM99kKObdns=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/fansi_2.13/0.5.0";
  };

  "com.lihaoyi_geny_2.13-1.1.1" = fetchMaven {
    name = "com.lihaoyi_geny_2.13-1.1.1";
    urls = [ "https://repo1.maven.org/maven2/com/lihaoyi/geny_2.13/1.1.1/geny_2.13-1.1.1.jar" "https://repo1.maven.org/maven2/com/lihaoyi/geny_2.13/1.1.1/geny_2.13-1.1.1.pom" ];
    hash = "sha256-+gQ8X4oSRU30RdF5kE2Gn8nxmo3RJEShiEyyzUJd088=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/geny_2.13/1.1.1";
  };

  "com.lihaoyi_geny_3-1.1.0" = fetchMaven {
    name = "com.lihaoyi_geny_3-1.1.0";
    urls = [ "https://repo1.maven.org/maven2/com/lihaoyi/geny_3/1.1.0/geny_3-1.1.0.jar" "https://repo1.maven.org/maven2/com/lihaoyi/geny_3/1.1.0/geny_3-1.1.0.pom" ];
    hash = "sha256-Vckcyv1W77OjMiIqE6SHkCMkyCF9wiPy5YBWG6owrsU=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/geny_3/1.1.0";
  };

  "com.lihaoyi_mainargs_2.13-0.7.6" = fetchMaven {
    name = "com.lihaoyi_mainargs_2.13-0.7.6";
    urls = [ "https://repo1.maven.org/maven2/com/lihaoyi/mainargs_2.13/0.7.6/mainargs_2.13-0.7.6.jar" "https://repo1.maven.org/maven2/com/lihaoyi/mainargs_2.13/0.7.6/mainargs_2.13-0.7.6.pom" ];
    hash = "sha256-3VNPfYCWjDt/Sln9JRJ3/aqxZT72ZqwdVdE7ONtpGXM=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/mainargs_2.13/0.7.6";
  };

  "com.lihaoyi_mainargs_3-0.5.0" = fetchMaven {
    name = "com.lihaoyi_mainargs_3-0.5.0";
    urls = [ "https://repo1.maven.org/maven2/com/lihaoyi/mainargs_3/0.5.0/mainargs_3-0.5.0.jar" "https://repo1.maven.org/maven2/com/lihaoyi/mainargs_3/0.5.0/mainargs_3-0.5.0.pom" ];
    hash = "sha256-Oh+m4R9bw/gniF2OSJDlzj3dw9jJjHaClbtCY0w2bDs=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/mainargs_3/0.5.0";
  };

  "com.lihaoyi_mill-main-api_2.13-0.12.8-1-46e216" = fetchMaven {
    name = "com.lihaoyi_mill-main-api_2.13-0.12.8-1-46e216";
    urls = [ "https://repo1.maven.org/maven2/com/lihaoyi/mill-main-api_2.13/0.12.8-1-46e216/mill-main-api_2.13-0.12.8-1-46e216.jar" "https://repo1.maven.org/maven2/com/lihaoyi/mill-main-api_2.13/0.12.8-1-46e216/mill-main-api_2.13-0.12.8-1-46e216.pom" ];
    hash = "sha256-4uPDK4pTRGogIMWaYpRhWg+D8C2gDvaX88/x47X06Ls=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/mill-main-api_2.13/0.12.8-1-46e216";
  };

  "com.lihaoyi_mill-main-client-0.12.8-1-46e216" = fetchMaven {
    name = "com.lihaoyi_mill-main-client-0.12.8-1-46e216";
    urls = [ "https://repo1.maven.org/maven2/com/lihaoyi/mill-main-client/0.12.8-1-46e216/mill-main-client-0.12.8-1-46e216.jar" "https://repo1.maven.org/maven2/com/lihaoyi/mill-main-client/0.12.8-1-46e216/mill-main-client-0.12.8-1-46e216.pom" ];
    hash = "sha256-YMhZ7tABUyMCFXru2tjJK9IA73Z11n5w/RH5r4ia3q8=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/mill-main-client/0.12.8-1-46e216";
  };

  "com.lihaoyi_mill-moduledefs_2.13-0.11.2" = fetchMaven {
    name = "com.lihaoyi_mill-moduledefs_2.13-0.11.2";
    urls = [ "https://repo1.maven.org/maven2/com/lihaoyi/mill-moduledefs_2.13/0.11.2/mill-moduledefs_2.13-0.11.2.jar" "https://repo1.maven.org/maven2/com/lihaoyi/mill-moduledefs_2.13/0.11.2/mill-moduledefs_2.13-0.11.2.pom" ];
    hash = "sha256-aTQtCHGjdmdIWSZgyv6EllswGet1c2gKJ0nuGxu+TpA=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/mill-moduledefs_2.13/0.11.2";
  };

  "com.lihaoyi_mill-runner-linenumbers_2.13-0.12.8-1-46e216" = fetchMaven {
    name = "com.lihaoyi_mill-runner-linenumbers_2.13-0.12.8-1-46e216";
    urls = [ "https://repo1.maven.org/maven2/com/lihaoyi/mill-runner-linenumbers_2.13/0.12.8-1-46e216/mill-runner-linenumbers_2.13-0.12.8-1-46e216.jar" "https://repo1.maven.org/maven2/com/lihaoyi/mill-runner-linenumbers_2.13/0.12.8-1-46e216/mill-runner-linenumbers_2.13-0.12.8-1-46e216.pom" ];
    hash = "sha256-87nmecp5r+JPxSGxJIQz0wLptyW3yTilDK4CQaQlcsY=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/mill-runner-linenumbers_2.13/0.12.8-1-46e216";
  };

  "com.lihaoyi_mill-scala-compiler-bridge_2.13.15-0.0.1" = fetchMaven {
    name = "com.lihaoyi_mill-scala-compiler-bridge_2.13.15-0.0.1";
    urls = [ "https://repo1.maven.org/maven2/com/lihaoyi/mill-scala-compiler-bridge_2.13.15/0.0.1/mill-scala-compiler-bridge_2.13.15-0.0.1.jar" "https://repo1.maven.org/maven2/com/lihaoyi/mill-scala-compiler-bridge_2.13.15/0.0.1/mill-scala-compiler-bridge_2.13.15-0.0.1.pom" ];
    hash = "sha256-uTyXjgTJGlaKl8jCUp9A6uDdma97ixL65GNVD9l9oOw=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/mill-scala-compiler-bridge_2.13.15/0.0.1";
  };

  "com.lihaoyi_mill-scalalib-api_2.13-0.12.8-1-46e216" = fetchMaven {
    name = "com.lihaoyi_mill-scalalib-api_2.13-0.12.8-1-46e216";
    urls = [ "https://repo1.maven.org/maven2/com/lihaoyi/mill-scalalib-api_2.13/0.12.8-1-46e216/mill-scalalib-api_2.13-0.12.8-1-46e216.jar" "https://repo1.maven.org/maven2/com/lihaoyi/mill-scalalib-api_2.13/0.12.8-1-46e216/mill-scalalib-api_2.13-0.12.8-1-46e216.pom" ];
    hash = "sha256-8xD1JkQ+PyCOCEYO/mlpmkQ1PpqIRjHnlwjI46Q/TNY=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/mill-scalalib-api_2.13/0.12.8-1-46e216";
  };

  "com.lihaoyi_mill-scalalib-worker_2.13-0.12.8-1-46e216" = fetchMaven {
    name = "com.lihaoyi_mill-scalalib-worker_2.13-0.12.8-1-46e216";
    urls = [ "https://repo1.maven.org/maven2/com/lihaoyi/mill-scalalib-worker_2.13/0.12.8-1-46e216/mill-scalalib-worker_2.13-0.12.8-1-46e216.jar" "https://repo1.maven.org/maven2/com/lihaoyi/mill-scalalib-worker_2.13/0.12.8-1-46e216/mill-scalalib-worker_2.13-0.12.8-1-46e216.pom" ];
    hash = "sha256-SJG7mGWhe+4a2xkmFWQqn/QUBb+RYMpSdB7b1jv7JQw=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/mill-scalalib-worker_2.13/0.12.8-1-46e216";
  };

  "com.lihaoyi_os-lib_2.13-0.11.4-M6" = fetchMaven {
    name = "com.lihaoyi_os-lib_2.13-0.11.4-M6";
    urls = [ "https://repo1.maven.org/maven2/com/lihaoyi/os-lib_2.13/0.11.4-M6/os-lib_2.13-0.11.4-M6.jar" "https://repo1.maven.org/maven2/com/lihaoyi/os-lib_2.13/0.11.4-M6/os-lib_2.13-0.11.4-M6.pom" ];
    hash = "sha256-Xfo/y+4tKe7wAUFY1nyyh9is8M0l4sYU4OnheEljEL8=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/os-lib_2.13/0.11.4-M6";
  };

  "com.lihaoyi_os-lib_3-0.10.0" = fetchMaven {
    name = "com.lihaoyi_os-lib_3-0.10.0";
    urls = [ "https://repo1.maven.org/maven2/com/lihaoyi/os-lib_3/0.10.0/os-lib_3-0.10.0.jar" "https://repo1.maven.org/maven2/com/lihaoyi/os-lib_3/0.10.0/os-lib_3-0.10.0.pom" ];
    hash = "sha256-EB9xqrVDVwK52Zrmy4cCe3nwm74Cl5mnghe8CnWX9hA=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/os-lib_3/0.10.0";
  };

  "com.lihaoyi_pprint_2.13-0.9.0" = fetchMaven {
    name = "com.lihaoyi_pprint_2.13-0.9.0";
    urls = [ "https://repo1.maven.org/maven2/com/lihaoyi/pprint_2.13/0.9.0/pprint_2.13-0.9.0.jar" "https://repo1.maven.org/maven2/com/lihaoyi/pprint_2.13/0.9.0/pprint_2.13-0.9.0.pom" ];
    hash = "sha256-RUmk2jO7irTaoMYgRK6Ui/SeyLEFCAspCehIccoQoeE=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/pprint_2.13/0.9.0";
  };

  "com.lihaoyi_scalac-mill-moduledefs-plugin_2.13.15-0.11.2" = fetchMaven {
    name = "com.lihaoyi_scalac-mill-moduledefs-plugin_2.13.15-0.11.2";
    urls = [ "https://repo1.maven.org/maven2/com/lihaoyi/scalac-mill-moduledefs-plugin_2.13.15/0.11.2/scalac-mill-moduledefs-plugin_2.13.15-0.11.2.jar" "https://repo1.maven.org/maven2/com/lihaoyi/scalac-mill-moduledefs-plugin_2.13.15/0.11.2/scalac-mill-moduledefs-plugin_2.13.15-0.11.2.pom" ];
    hash = "sha256-l+0NBdEWKEMILT44bK6ohiaon09cQvORWtDrCjUkn0A=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/scalac-mill-moduledefs-plugin_2.13.15/0.11.2";
  };

  "com.lihaoyi_sourcecode_2.13-0.3.0" = fetchMaven {
    name = "com.lihaoyi_sourcecode_2.13-0.3.0";
    urls = [ "https://repo1.maven.org/maven2/com/lihaoyi/sourcecode_2.13/0.3.0/sourcecode_2.13-0.3.0.jar" "https://repo1.maven.org/maven2/com/lihaoyi/sourcecode_2.13/0.3.0/sourcecode_2.13-0.3.0.pom" ];
    hash = "sha256-Y+QhWVO6t2oYpWS/s2aG1fHO+QZ726LyJYaGh3SL4ko=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/sourcecode_2.13/0.3.0";
  };

  "com.lihaoyi_sourcecode_2.13-0.4.0" = fetchMaven {
    name = "com.lihaoyi_sourcecode_2.13-0.4.0";
    urls = [ "https://repo1.maven.org/maven2/com/lihaoyi/sourcecode_2.13/0.4.0/sourcecode_2.13-0.4.0.jar" "https://repo1.maven.org/maven2/com/lihaoyi/sourcecode_2.13/0.4.0/sourcecode_2.13-0.4.0.pom" ];
    hash = "sha256-pi/E3F43hJcUYTx3hqUfOa/SGWmIcCl7z+3vCWDDrXc=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/sourcecode_2.13/0.4.0";
  };

  "com.lihaoyi_ujson_2.13-3.3.1" = fetchMaven {
    name = "com.lihaoyi_ujson_2.13-3.3.1";
    urls = [ "https://repo1.maven.org/maven2/com/lihaoyi/ujson_2.13/3.3.1/ujson_2.13-3.3.1.jar" "https://repo1.maven.org/maven2/com/lihaoyi/ujson_2.13/3.3.1/ujson_2.13-3.3.1.pom" ];
    hash = "sha256-tS5BVFeMdRfzGHUlrAywtQb4mG6oel56ooMEtlsWGjI=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/ujson_2.13/3.3.1";
  };

  "com.lihaoyi_ujson_3-3.3.1" = fetchMaven {
    name = "com.lihaoyi_ujson_3-3.3.1";
    urls = [ "https://repo1.maven.org/maven2/com/lihaoyi/ujson_3/3.3.1/ujson_3-3.3.1.jar" "https://repo1.maven.org/maven2/com/lihaoyi/ujson_3/3.3.1/ujson_3-3.3.1.pom" ];
    hash = "sha256-WBrFmNnzUHJCiuLnaN1JnZAFYKGoD7gbzeFrMljtWj8=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/ujson_3/3.3.1";
  };

  "com.lihaoyi_upack_2.13-3.3.1" = fetchMaven {
    name = "com.lihaoyi_upack_2.13-3.3.1";
    urls = [ "https://repo1.maven.org/maven2/com/lihaoyi/upack_2.13/3.3.1/upack_2.13-3.3.1.jar" "https://repo1.maven.org/maven2/com/lihaoyi/upack_2.13/3.3.1/upack_2.13-3.3.1.pom" ];
    hash = "sha256-rbWiMl6+OXfWP2HjpMbvkToBzWhuW2hsJD/4dd+XmOs=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/upack_2.13/3.3.1";
  };

  "com.lihaoyi_upack_3-3.3.1" = fetchMaven {
    name = "com.lihaoyi_upack_3-3.3.1";
    urls = [ "https://repo1.maven.org/maven2/com/lihaoyi/upack_3/3.3.1/upack_3-3.3.1.jar" "https://repo1.maven.org/maven2/com/lihaoyi/upack_3/3.3.1/upack_3-3.3.1.pom" ];
    hash = "sha256-5I+QJF9ahoCA1znfnsfSDwGHhRMh08cjyKNiYw6VGqE=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/upack_3/3.3.1";
  };

  "com.lihaoyi_upickle-core_2.13-3.3.1" = fetchMaven {
    name = "com.lihaoyi_upickle-core_2.13-3.3.1";
    urls = [ "https://repo1.maven.org/maven2/com/lihaoyi/upickle-core_2.13/3.3.1/upickle-core_2.13-3.3.1.jar" "https://repo1.maven.org/maven2/com/lihaoyi/upickle-core_2.13/3.3.1/upickle-core_2.13-3.3.1.pom" ];
    hash = "sha256-+vXjTD3FY+FMlDpvsOkhwycDbvhnIY0SOcHKOYc+StM=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/upickle-core_2.13/3.3.1";
  };

  "com.lihaoyi_upickle-core_3-3.3.1" = fetchMaven {
    name = "com.lihaoyi_upickle-core_3-3.3.1";
    urls = [ "https://repo1.maven.org/maven2/com/lihaoyi/upickle-core_3/3.3.1/upickle-core_3-3.3.1.jar" "https://repo1.maven.org/maven2/com/lihaoyi/upickle-core_3/3.3.1/upickle-core_3-3.3.1.pom" ];
    hash = "sha256-ilLrjctjuOu0Qs1RAbjy9uezHXUOfgvMaVuh6ZCNflw=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/upickle-core_3/3.3.1";
  };

  "com.lihaoyi_upickle-implicits_2.13-3.3.1" = fetchMaven {
    name = "com.lihaoyi_upickle-implicits_2.13-3.3.1";
    urls = [ "https://repo1.maven.org/maven2/com/lihaoyi/upickle-implicits_2.13/3.3.1/upickle-implicits_2.13-3.3.1.jar" "https://repo1.maven.org/maven2/com/lihaoyi/upickle-implicits_2.13/3.3.1/upickle-implicits_2.13-3.3.1.pom" ];
    hash = "sha256-LKWPAok7DL+YyfLv6yTwuyAG8z/74mzMrsqgUvUw9bM=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/upickle-implicits_2.13/3.3.1";
  };

  "com.lihaoyi_upickle-implicits_3-3.3.1" = fetchMaven {
    name = "com.lihaoyi_upickle-implicits_3-3.3.1";
    urls = [ "https://repo1.maven.org/maven2/com/lihaoyi/upickle-implicits_3/3.3.1/upickle-implicits_3-3.3.1.jar" "https://repo1.maven.org/maven2/com/lihaoyi/upickle-implicits_3/3.3.1/upickle-implicits_3-3.3.1.pom" ];
    hash = "sha256-woCFgGb/JC+nZala0DL0reBbVXtdDUaa/lTG219HOHk=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/upickle-implicits_3/3.3.1";
  };

  "com.lihaoyi_upickle_2.13-3.3.1" = fetchMaven {
    name = "com.lihaoyi_upickle_2.13-3.3.1";
    urls = [ "https://repo1.maven.org/maven2/com/lihaoyi/upickle_2.13/3.3.1/upickle_2.13-3.3.1.jar" "https://repo1.maven.org/maven2/com/lihaoyi/upickle_2.13/3.3.1/upickle_2.13-3.3.1.pom" ];
    hash = "sha256-1vHU3mGQey3zvyUHK9uCx+9pUnpnWe3zEMlyb8QqUFc=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/upickle_2.13/3.3.1";
  };

  "com.lihaoyi_upickle_3-3.3.1" = fetchMaven {
    name = "com.lihaoyi_upickle_3-3.3.1";
    urls = [ "https://repo1.maven.org/maven2/com/lihaoyi/upickle_3/3.3.1/upickle_3-3.3.1.jar" "https://repo1.maven.org/maven2/com/lihaoyi/upickle_3/3.3.1/upickle_3-3.3.1.pom" ];
    hash = "sha256-pug2T74XKw35S+3WAI3URsvG6Eq/B8MoAFYM4hvNPPs=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/upickle_3/3.3.1";
  };

  "com.lihaoyi_utest_3-0.8.5" = fetchMaven {
    name = "com.lihaoyi_utest_3-0.8.5";
    urls = [ "https://repo1.maven.org/maven2/com/lihaoyi/utest_3/0.8.5/utest_3-0.8.5.jar" "https://repo1.maven.org/maven2/com/lihaoyi/utest_3/0.8.5/utest_3-0.8.5.pom" ];
    hash = "sha256-B5AF8dcOLe3tUgJDjf+7irZwy0ATlprPcXqLPM5jcrk=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/utest_3/0.8.5";
  };

  "com.lmax_disruptor-3.4.2" = fetchMaven {
    name = "com.lmax_disruptor-3.4.2";
    urls = [ "https://repo1.maven.org/maven2/com/lmax/disruptor/3.4.2/disruptor-3.4.2.jar" "https://repo1.maven.org/maven2/com/lmax/disruptor/3.4.2/disruptor-3.4.2.pom" ];
    hash = "sha256-nbZsn6zL8HaJOrkMiWwvCuHQumcNQYA8e6QrAjXKKKg=";
    installPath = "https/repo1.maven.org/maven2/com/lmax/disruptor/3.4.2";
  };

  "com.swoval_file-tree-views-2.1.12" = fetchMaven {
    name = "com.swoval_file-tree-views-2.1.12";
    urls = [ "https://repo1.maven.org/maven2/com/swoval/file-tree-views/2.1.12/file-tree-views-2.1.12.jar" "https://repo1.maven.org/maven2/com/swoval/file-tree-views/2.1.12/file-tree-views-2.1.12.pom" ];
    hash = "sha256-QhJJFQt5LS2THa8AyPLrj0suht4eCiAEl2sf7QsZU3I=";
    installPath = "https/repo1.maven.org/maven2/com/swoval/file-tree-views/2.1.12";
  };

  "io.airlift_airbase-112" = fetchMaven {
    name = "io.airlift_airbase-112";
    urls = [ "https://repo1.maven.org/maven2/io/airlift/airbase/112/airbase-112.pom" ];
    hash = "sha256-I3jUuyAfPGbPcF0yDH+fa8l5rouZdvucoXg8tMLt174=";
    installPath = "https/repo1.maven.org/maven2/io/airlift/airbase/112";
  };

  "io.airlift_aircompressor-0.27" = fetchMaven {
    name = "io.airlift_aircompressor-0.27";
    urls = [ "https://repo1.maven.org/maven2/io/airlift/aircompressor/0.27/aircompressor-0.27.jar" "https://repo1.maven.org/maven2/io/airlift/aircompressor/0.27/aircompressor-0.27.pom" ];
    hash = "sha256-mxNNsdJ5O/jd2kv4pEyG7kFfnxLqrYDMPtxys0c1wuM=";
    installPath = "https/repo1.maven.org/maven2/io/airlift/aircompressor/0.27";
  };

  "io.get-coursier_cache-util-2.1.25-M3" = fetchMaven {
    name = "io.get-coursier_cache-util-2.1.25-M3";
    urls = [ "https://repo1.maven.org/maven2/io/get-coursier/cache-util/2.1.25-M3/cache-util-2.1.25-M3.jar" "https://repo1.maven.org/maven2/io/get-coursier/cache-util/2.1.25-M3/cache-util-2.1.25-M3.pom" ];
    hash = "sha256-YY8vX5+gwJAGlzR7YQG4fRY3lpZn7XZFPIQpYa4P5Sc=";
    installPath = "https/repo1.maven.org/maven2/io/get-coursier/cache-util/2.1.25-M3";
  };

  "io.get-coursier_coursier-cache_2.13-2.1.25-M3" = fetchMaven {
    name = "io.get-coursier_coursier-cache_2.13-2.1.25-M3";
    urls = [ "https://repo1.maven.org/maven2/io/get-coursier/coursier-cache_2.13/2.1.25-M3/coursier-cache_2.13-2.1.25-M3.jar" "https://repo1.maven.org/maven2/io/get-coursier/coursier-cache_2.13/2.1.25-M3/coursier-cache_2.13-2.1.25-M3.pom" ];
    hash = "sha256-hZqc6lcJCcD/qDXMJjwFrH23A5XeIU8eBp3MoseGoA4=";
    installPath = "https/repo1.maven.org/maven2/io/get-coursier/coursier-cache_2.13/2.1.25-M3";
  };

  "io.get-coursier_coursier-core_2.13-2.1.25-M3" = fetchMaven {
    name = "io.get-coursier_coursier-core_2.13-2.1.25-M3";
    urls = [ "https://repo1.maven.org/maven2/io/get-coursier/coursier-core_2.13/2.1.25-M3/coursier-core_2.13-2.1.25-M3.jar" "https://repo1.maven.org/maven2/io/get-coursier/coursier-core_2.13/2.1.25-M3/coursier-core_2.13-2.1.25-M3.pom" ];
    hash = "sha256-lIK9YT96EoWrShoDgB5hM+4Z86zHdOKM50ybDebdXd4=";
    installPath = "https/repo1.maven.org/maven2/io/get-coursier/coursier-core_2.13/2.1.25-M3";
  };

  "io.get-coursier_coursier-proxy-setup-2.1.25-M3" = fetchMaven {
    name = "io.get-coursier_coursier-proxy-setup-2.1.25-M3";
    urls = [ "https://repo1.maven.org/maven2/io/get-coursier/coursier-proxy-setup/2.1.25-M3/coursier-proxy-setup-2.1.25-M3.jar" "https://repo1.maven.org/maven2/io/get-coursier/coursier-proxy-setup/2.1.25-M3/coursier-proxy-setup-2.1.25-M3.pom" ];
    hash = "sha256-S/GqtrX5mO8aDeDVR0TAbxx6B3G8+cu1deiQidf72CQ=";
    installPath = "https/repo1.maven.org/maven2/io/get-coursier/coursier-proxy-setup/2.1.25-M3";
  };

  "io.get-coursier_coursier-util_2.13-2.1.25-M3" = fetchMaven {
    name = "io.get-coursier_coursier-util_2.13-2.1.25-M3";
    urls = [ "https://repo1.maven.org/maven2/io/get-coursier/coursier-util_2.13/2.1.25-M3/coursier-util_2.13-2.1.25-M3.jar" "https://repo1.maven.org/maven2/io/get-coursier/coursier-util_2.13/2.1.25-M3/coursier-util_2.13-2.1.25-M3.pom" ];
    hash = "sha256-ODV3Dv69HQ4EZ67YsUJOhEPjr1MllhHyGaPPmSC7PBY=";
    installPath = "https/repo1.maven.org/maven2/io/get-coursier/coursier-util_2.13/2.1.25-M3";
  };

  "io.get-coursier_coursier_2.13-2.1.25-M3" = fetchMaven {
    name = "io.get-coursier_coursier_2.13-2.1.25-M3";
    urls = [ "https://repo1.maven.org/maven2/io/get-coursier/coursier_2.13/2.1.25-M3/coursier_2.13-2.1.25-M3.jar" "https://repo1.maven.org/maven2/io/get-coursier/coursier_2.13/2.1.25-M3/coursier_2.13-2.1.25-M3.pom" ];
    hash = "sha256-wiyYxZaZtuSAdR/0Ckf2IBc2X20UkZVlyxBbIvSaQcs=";
    installPath = "https/repo1.maven.org/maven2/io/get-coursier/coursier_2.13/2.1.25-M3";
  };

  "io.get-coursier_dependency_2.13-0.3.2" = fetchMaven {
    name = "io.get-coursier_dependency_2.13-0.3.2";
    urls = [ "https://repo1.maven.org/maven2/io/get-coursier/dependency_2.13/0.3.2/dependency_2.13-0.3.2.jar" "https://repo1.maven.org/maven2/io/get-coursier/dependency_2.13/0.3.2/dependency_2.13-0.3.2.pom" ];
    hash = "sha256-kLCTLMEFNrY74GFqcr7Vw/qEbR7CPpskXrpzbbH0gMg=";
    installPath = "https/repo1.maven.org/maven2/io/get-coursier/dependency_2.13/0.3.2";
  };

  "io.get-coursier_versions_2.13-0.5.1" = fetchMaven {
    name = "io.get-coursier_versions_2.13-0.5.1";
    urls = [ "https://repo1.maven.org/maven2/io/get-coursier/versions_2.13/0.5.1/versions_2.13-0.5.1.jar" "https://repo1.maven.org/maven2/io/get-coursier/versions_2.13/0.5.1/versions_2.13-0.5.1.pom" ];
    hash = "sha256-1ryxcGeeUu18sLY4gL2cDVfOkh59oRPmNnIA0N2G1/Y=";
    installPath = "https/repo1.maven.org/maven2/io/get-coursier/versions_2.13/0.5.1";
  };

  "io.netty_netty-bom-4.1.117.Final" = fetchMaven {
    name = "io.netty_netty-bom-4.1.117.Final";
    urls = [ "https://repo1.maven.org/maven2/io/netty/netty-bom/4.1.117.Final/netty-bom-4.1.117.Final.pom" ];
    hash = "sha256-Ej4z3zNHEg2xiuYyNcdq+UJT7XC01ITGAlWCyc5V6cU=";
    installPath = "https/repo1.maven.org/maven2/io/netty/netty-bom/4.1.117.Final";
  };

  "jakarta.platform_jakarta.jakartaee-bom-9.1.0" = fetchMaven {
    name = "jakarta.platform_jakarta.jakartaee-bom-9.1.0";
    urls = [ "https://repo1.maven.org/maven2/jakarta/platform/jakarta.jakartaee-bom/9.1.0/jakarta.jakartaee-bom-9.1.0.pom" ];
    hash = "sha256-kstGe15Yw9oF6LQ3Vovx1PcCUfQtNaEM7T8E5Upp1gg=";
    installPath = "https/repo1.maven.org/maven2/jakarta/platform/jakarta.jakartaee-bom/9.1.0";
  };

  "jakarta.platform_jakartaee-api-parent-9.1.0" = fetchMaven {
    name = "jakarta.platform_jakartaee-api-parent-9.1.0";
    urls = [ "https://repo1.maven.org/maven2/jakarta/platform/jakartaee-api-parent/9.1.0/jakartaee-api-parent-9.1.0.pom" ];
    hash = "sha256-FrD7N30UkkRSQtD3+FPOC1fH2qrNnJw6UZQ/hNFXWrA=";
    installPath = "https/repo1.maven.org/maven2/jakarta/platform/jakartaee-api-parent/9.1.0";
  };

  "javax.inject_javax.inject-1" = fetchMaven {
    name = "javax.inject_javax.inject-1";
    urls = [ "https://repo1.maven.org/maven2/javax/inject/javax.inject/1/javax.inject-1.jar" "https://repo1.maven.org/maven2/javax/inject/javax.inject/1/javax.inject-1.pom" ];
    hash = "sha256-CZm6Lb7D5az8nprqBvjNerGQjB0xPaY56/RvKwSZIxE=";
    installPath = "https/repo1.maven.org/maven2/javax/inject/javax.inject/1";
  };

  "net.openhft_java-parent-pom-1.1.28" = fetchMaven {
    name = "net.openhft_java-parent-pom-1.1.28";
    urls = [ "https://repo1.maven.org/maven2/net/openhft/java-parent-pom/1.1.28/java-parent-pom-1.1.28.pom" ];
    hash = "sha256-d7bOKP/hHJElmDQtIbblYDHRc8LCpqkt5Zl8aHp7l88=";
    installPath = "https/repo1.maven.org/maven2/net/openhft/java-parent-pom/1.1.28";
  };

  "net.openhft_root-parent-pom-1.2.12" = fetchMaven {
    name = "net.openhft_root-parent-pom-1.2.12";
    urls = [ "https://repo1.maven.org/maven2/net/openhft/root-parent-pom/1.2.12/root-parent-pom-1.2.12.pom" ];
    hash = "sha256-D/M1qN+njmMZWqS5h27fl83Q+zWgIFjaYQkCpD2Oy/M=";
    installPath = "https/repo1.maven.org/maven2/net/openhft/root-parent-pom/1.2.12";
  };

  "net.openhft_zero-allocation-hashing-0.16" = fetchMaven {
    name = "net.openhft_zero-allocation-hashing-0.16";
    urls = [ "https://repo1.maven.org/maven2/net/openhft/zero-allocation-hashing/0.16/zero-allocation-hashing-0.16.jar" "https://repo1.maven.org/maven2/net/openhft/zero-allocation-hashing/0.16/zero-allocation-hashing-0.16.pom" ];
    hash = "sha256-QkNOGkyP/OFWM+pv40hqR+ii4GBAcv0bbIrpG66YDMo=";
    installPath = "https/repo1.maven.org/maven2/net/openhft/zero-allocation-hashing/0.16";
  };

  "nl.big-o_liqp-0.8.2" = fetchMaven {
    name = "nl.big-o_liqp-0.8.2";
    urls = [ "https://repo1.maven.org/maven2/nl/big-o/liqp/0.8.2/liqp-0.8.2.jar" "https://repo1.maven.org/maven2/nl/big-o/liqp/0.8.2/liqp-0.8.2.pom" ];
    hash = "sha256-yamgRk2t6//LGTLwLSNJ28rGL0mQFOU1XCThtpWwmMM=";
    installPath = "https/repo1.maven.org/maven2/nl/big-o/liqp/0.8.2";
  };

  "org.antlr_antlr4-master-4.7.2" = fetchMaven {
    name = "org.antlr_antlr4-master-4.7.2";
    urls = [ "https://repo1.maven.org/maven2/org/antlr/antlr4-master/4.7.2/antlr4-master-4.7.2.pom" ];
    hash = "sha256-Z+4f52KXe+J8mvu6l3IryRrYdsxjwj4Cztrn0OEs2dM=";
    installPath = "https/repo1.maven.org/maven2/org/antlr/antlr4-master/4.7.2";
  };

  "org.antlr_antlr4-runtime-4.7.2" = fetchMaven {
    name = "org.antlr_antlr4-runtime-4.7.2";
    urls = [ "https://repo1.maven.org/maven2/org/antlr/antlr4-runtime/4.7.2/antlr4-runtime-4.7.2.jar" "https://repo1.maven.org/maven2/org/antlr/antlr4-runtime/4.7.2/antlr4-runtime-4.7.2.pom" ];
    hash = "sha256-orSo+dX/By8iQ7guGqi/mScUKmFeAp2TizPRFWLVUvY=";
    installPath = "https/repo1.maven.org/maven2/org/antlr/antlr4-runtime/4.7.2";
  };

  "org.apache_apache-30" = fetchMaven {
    name = "org.apache_apache-30";
    urls = [ "https://repo1.maven.org/maven2/org/apache/apache/30/apache-30.pom" ];
    hash = "sha256-Wo5syVryUH2A6IG2gydSxmAb8DYNxV6MmKxGHd1FxcE=";
    installPath = "https/repo1.maven.org/maven2/org/apache/apache/30";
  };

  "org.apache_apache-31" = fetchMaven {
    name = "org.apache_apache-31";
    urls = [ "https://repo1.maven.org/maven2/org/apache/apache/31/apache-31.pom" ];
    hash = "sha256-Evktp+xRZ2C/VvG0UDTcFRSEvvSJINCtIe0Rom2159s=";
    installPath = "https/repo1.maven.org/maven2/org/apache/apache/31";
  };

  "org.apache_apache-33" = fetchMaven {
    name = "org.apache_apache-33";
    urls = [ "https://repo1.maven.org/maven2/org/apache/apache/33/apache-33.pom" ];
    hash = "sha256-Hwj0S/ETiRxq9ObIzy9OGjGShFgbWuJOEoV6skSMQzI=";
    installPath = "https/repo1.maven.org/maven2/org/apache/apache/33";
  };

  "org.apache_apache-6" = fetchMaven {
    name = "org.apache_apache-6";
    urls = [ "https://repo1.maven.org/maven2/org/apache/apache/6/apache-6.pom" ];
    hash = "sha256-A7aDRlGjS4P3/QlZmvMRdVHhP4yqTFL4wZbRnp1lJ9U=";
    installPath = "https/repo1.maven.org/maven2/org/apache/apache/6";
  };

  "org.fusesource_fusesource-pom-1.12" = fetchMaven {
    name = "org.fusesource_fusesource-pom-1.12";
    urls = [ "https://repo1.maven.org/maven2/org/fusesource/fusesource-pom/1.12/fusesource-pom-1.12.pom" ];
    hash = "sha256-NUD5PZ1FYYOq8yumvT5i29Vxd2ZCI6PXImXfLe4mE30=";
    installPath = "https/repo1.maven.org/maven2/org/fusesource/fusesource-pom/1.12";
  };

  "org.jetbrains_annotations-15.0" = fetchMaven {
    name = "org.jetbrains_annotations-15.0";
    urls = [ "https://repo1.maven.org/maven2/org/jetbrains/annotations/15.0/annotations-15.0.jar" "https://repo1.maven.org/maven2/org/jetbrains/annotations/15.0/annotations-15.0.pom" ];
    hash = "sha256-zKx9CDgM9iLkt5SFNiSgDzJu9AxFNPjCFWwMi9copnI=";
    installPath = "https/repo1.maven.org/maven2/org/jetbrains/annotations/15.0";
  };

  "org.jline_jline-3.26.3" = fetchMaven {
    name = "org.jline_jline-3.26.3";
    urls = [ "https://repo1.maven.org/maven2/org/jline/jline/3.26.3/jline-3.26.3.jar" "https://repo1.maven.org/maven2/org/jline/jline/3.26.3/jline-3.26.3.pom" ];
    hash = "sha256-CVg5HR6GRYVCZ+0Y3yMsCUlgFCzd7MhgMqaZIQZEus0=";
    installPath = "https/repo1.maven.org/maven2/org/jline/jline/3.26.3";
  };

  "org.jline_jline-native-3.27.1" = fetchMaven {
    name = "org.jline_jline-native-3.27.1";
    urls = [ "https://repo1.maven.org/maven2/org/jline/jline-native/3.27.1/jline-native-3.27.1.jar" "https://repo1.maven.org/maven2/org/jline/jline-native/3.27.1/jline-native-3.27.1.pom" ];
    hash = "sha256-XyhCZMcwu/OXdQ8BTM+qGgjGzMano5DJoghn1+/yr+Q=";
    installPath = "https/repo1.maven.org/maven2/org/jline/jline-native/3.27.1";
  };

  "org.jline_jline-parent-3.19.0" = fetchMaven {
    name = "org.jline_jline-parent-3.19.0";
    urls = [ "https://repo1.maven.org/maven2/org/jline/jline-parent/3.19.0/jline-parent-3.19.0.pom" ];
    hash = "sha256-+mzsNCct3XevO2H6GuvRBMPOOeKU1tbZsOVZyzqnphU=";
    installPath = "https/repo1.maven.org/maven2/org/jline/jline-parent/3.19.0";
  };

  "org.jline_jline-parent-3.27.1" = fetchMaven {
    name = "org.jline_jline-parent-3.27.1";
    urls = [ "https://repo1.maven.org/maven2/org/jline/jline-parent/3.27.1/jline-parent-3.27.1.pom" ];
    hash = "sha256-Oa5DgBvf5JwZH68PDIyNkEQtm7IL04ujoeniH6GZas8=";
    installPath = "https/repo1.maven.org/maven2/org/jline/jline-parent/3.27.1";
  };

  "org.jline_jline-reader-3.19.0" = fetchMaven {
    name = "org.jline_jline-reader-3.19.0";
    urls = [ "https://repo1.maven.org/maven2/org/jline/jline-reader/3.19.0/jline-reader-3.19.0.jar" "https://repo1.maven.org/maven2/org/jline/jline-reader/3.19.0/jline-reader-3.19.0.pom" ];
    hash = "sha256-BhriYLrCDi8D4STJn8OkuenkzuX3wWzy7GGiEaFHaPg=";
    installPath = "https/repo1.maven.org/maven2/org/jline/jline-reader/3.19.0";
  };

  "org.jline_jline-terminal-3.19.0" = fetchMaven {
    name = "org.jline_jline-terminal-3.19.0";
    urls = [ "https://repo1.maven.org/maven2/org/jline/jline-terminal/3.19.0/jline-terminal-3.19.0.jar" "https://repo1.maven.org/maven2/org/jline/jline-terminal/3.19.0/jline-terminal-3.19.0.pom" ];
    hash = "sha256-8F11Dw3/pQMOVunnEu29xwnflUXlXwhPYkfjTB0QA6k=";
    installPath = "https/repo1.maven.org/maven2/org/jline/jline-terminal/3.19.0";
  };

  "org.jline_jline-terminal-3.27.1" = fetchMaven {
    name = "org.jline_jline-terminal-3.27.1";
    urls = [ "https://repo1.maven.org/maven2/org/jline/jline-terminal/3.27.1/jline-terminal-3.27.1.jar" "https://repo1.maven.org/maven2/org/jline/jline-terminal/3.27.1/jline-terminal-3.27.1.pom" ];
    hash = "sha256-WV77BAEncauTljUBrlYi9v3GxDDeskqQpHHD9Fdbqjw=";
    installPath = "https/repo1.maven.org/maven2/org/jline/jline-terminal/3.27.1";
  };

  "org.jline_jline-terminal-jna-3.19.0" = fetchMaven {
    name = "org.jline_jline-terminal-jna-3.19.0";
    urls = [ "https://repo1.maven.org/maven2/org/jline/jline-terminal-jna/3.19.0/jline-terminal-jna-3.19.0.jar" "https://repo1.maven.org/maven2/org/jline/jline-terminal-jna/3.19.0/jline-terminal-jna-3.19.0.pom" ];
    hash = "sha256-RYPfEF1poc5Fp35We6VidZBC4a/3tl6MEYzOkrGGyD8=";
    installPath = "https/repo1.maven.org/maven2/org/jline/jline-terminal-jna/3.19.0";
  };

  "org.jline_jline-terminal-jni-3.27.1" = fetchMaven {
    name = "org.jline_jline-terminal-jni-3.27.1";
    urls = [ "https://repo1.maven.org/maven2/org/jline/jline-terminal-jni/3.27.1/jline-terminal-jni-3.27.1.jar" "https://repo1.maven.org/maven2/org/jline/jline-terminal-jni/3.27.1/jline-terminal-jni-3.27.1.pom" ];
    hash = "sha256-AWKC7imb/rnF39PAo3bVIW430zPkyj9WozKGkPlTTBE=";
    installPath = "https/repo1.maven.org/maven2/org/jline/jline-terminal-jni/3.27.1";
  };

  "org.jsoup_jsoup-1.17.2" = fetchMaven {
    name = "org.jsoup_jsoup-1.17.2";
    urls = [ "https://repo1.maven.org/maven2/org/jsoup/jsoup/1.17.2/jsoup-1.17.2.jar" "https://repo1.maven.org/maven2/org/jsoup/jsoup/1.17.2/jsoup-1.17.2.pom" ];
    hash = "sha256-aex/2xWBJBV0CVGOIoNvOcnYi6sVTd3CwBJhM5ZUISU=";
    installPath = "https/repo1.maven.org/maven2/org/jsoup/jsoup/1.17.2";
  };

  "org.junit_junit-bom-5.10.0" = fetchMaven {
    name = "org.junit_junit-bom-5.10.0";
    urls = [ "https://repo1.maven.org/maven2/org/junit/junit-bom/5.10.0/junit-bom-5.10.0.pom" ];
    hash = "sha256-luQjQgOITEqh2Y+/2XwfXzgggI8aRglNmIXZGpcJEgY=";
    installPath = "https/repo1.maven.org/maven2/org/junit/junit-bom/5.10.0";
  };

  "org.junit_junit-bom-5.10.2" = fetchMaven {
    name = "org.junit_junit-bom-5.10.2";
    urls = [ "https://repo1.maven.org/maven2/org/junit/junit-bom/5.10.2/junit-bom-5.10.2.pom" ];
    hash = "sha256-AlDFqi7NIm0J1UoA6JCUM3Rhq5cNwsXq/I8viZmWLEg=";
    installPath = "https/repo1.maven.org/maven2/org/junit/junit-bom/5.10.2";
  };

  "org.junit_junit-bom-5.10.3" = fetchMaven {
    name = "org.junit_junit-bom-5.10.3";
    urls = [ "https://repo1.maven.org/maven2/org/junit/junit-bom/5.10.3/junit-bom-5.10.3.pom" ];
    hash = "sha256-V+Pp8ndKoaD1fkc4oK9oU0+rrJ5hFRyuVcUnD0LI2Fw=";
    installPath = "https/repo1.maven.org/maven2/org/junit/junit-bom/5.10.3";
  };

  "org.junit_junit-bom-5.11.2" = fetchMaven {
    name = "org.junit_junit-bom-5.11.2";
    urls = [ "https://repo1.maven.org/maven2/org/junit/junit-bom/5.11.2/junit-bom-5.11.2.pom" ];
    hash = "sha256-cGHayaCE9Q75/hyJE3iFhnmKFYtzLY/MLSHDid0QSHY=";
    installPath = "https/repo1.maven.org/maven2/org/junit/junit-bom/5.11.2";
  };

  "org.junit_junit-bom-5.11.4" = fetchMaven {
    name = "org.junit_junit-bom-5.11.4";
    urls = [ "https://repo1.maven.org/maven2/org/junit/junit-bom/5.11.4/junit-bom-5.11.4.pom" ];
    hash = "sha256-nbbdpbMILETuwuXYxim5wKdWe4U5JhdP8wechYIZuZQ=";
    installPath = "https/repo1.maven.org/maven2/org/junit/junit-bom/5.11.4";
  };

  "org.junit_junit-bom-5.8.0-M1" = fetchMaven {
    name = "org.junit_junit-bom-5.8.0-M1";
    urls = [ "https://repo1.maven.org/maven2/org/junit/junit-bom/5.8.0-M1/junit-bom-5.8.0-M1.pom" ];
    hash = "sha256-3suC6i7s+f+GrkY/p8I8TXqZnkP6Vz5/iHplYFZPIk4=";
    installPath = "https/repo1.maven.org/maven2/org/junit/junit-bom/5.8.0-M1";
  };

  "org.junit_junit-bom-5.9.2" = fetchMaven {
    name = "org.junit_junit-bom-5.9.2";
    urls = [ "https://repo1.maven.org/maven2/org/junit/junit-bom/5.9.2/junit-bom-5.9.2.pom" ];
    hash = "sha256-uGn68+1/ScKIRXjMgUllMofOsjFTxO1mfwrpSVBpP6E=";
    installPath = "https/repo1.maven.org/maven2/org/junit/junit-bom/5.9.2";
  };

  "org.mockito_mockito-bom-4.11.0" = fetchMaven {
    name = "org.mockito_mockito-bom-4.11.0";
    urls = [ "https://repo1.maven.org/maven2/org/mockito/mockito-bom/4.11.0/mockito-bom-4.11.0.pom" ];
    hash = "sha256-jtuaGRrHXNkevtfBAzk3OA+n5RNtrDQ0MQSqSRxUIfc=";
    installPath = "https/repo1.maven.org/maven2/org/mockito/mockito-bom/4.11.0";
  };

  "org.scala-lang_scala-compiler-2.13.15" = fetchMaven {
    name = "org.scala-lang_scala-compiler-2.13.15";
    urls = [ "https://repo1.maven.org/maven2/org/scala-lang/scala-compiler/2.13.15/scala-compiler-2.13.15.jar" "https://repo1.maven.org/maven2/org/scala-lang/scala-compiler/2.13.15/scala-compiler-2.13.15.pom" ];
    hash = "sha256-kvqWoFLNy3LGIbD6l67f66OyJq/K2L4rTStLiDzIzm8=";
    installPath = "https/repo1.maven.org/maven2/org/scala-lang/scala-compiler/2.13.15";
  };

  "org.scala-lang_scala-library-2.13.12" = fetchMaven {
    name = "org.scala-lang_scala-library-2.13.12";
    urls = [ "https://repo1.maven.org/maven2/org/scala-lang/scala-library/2.13.12/scala-library-2.13.12.jar" "https://repo1.maven.org/maven2/org/scala-lang/scala-library/2.13.12/scala-library-2.13.12.pom" ];
    hash = "sha256-lXKrUcaYvYFyltW8AxZb1apsFCr5H/5I8oF8/QWDOKQ=";
    installPath = "https/repo1.maven.org/maven2/org/scala-lang/scala-library/2.13.12";
  };

  "org.scala-lang_scala-library-2.13.15" = fetchMaven {
    name = "org.scala-lang_scala-library-2.13.15";
    urls = [ "https://repo1.maven.org/maven2/org/scala-lang/scala-library/2.13.15/scala-library-2.13.15.jar" "https://repo1.maven.org/maven2/org/scala-lang/scala-library/2.13.15/scala-library-2.13.15.pom" ];
    hash = "sha256-JnbDGZQKZZswRZuxauQywH/4rXzwzn++kMB4lw3OfPI=";
    installPath = "https/repo1.maven.org/maven2/org/scala-lang/scala-library/2.13.15";
  };

  "org.scala-lang_scala-library-2.13.16" = fetchMaven {
    name = "org.scala-lang_scala-library-2.13.16";
    urls = [ "https://repo1.maven.org/maven2/org/scala-lang/scala-library/2.13.16/scala-library-2.13.16.jar" "https://repo1.maven.org/maven2/org/scala-lang/scala-library/2.13.16/scala-library-2.13.16.pom" ];
    hash = "sha256-7/NvAxKKPtghJ/+pTNxvmIAiAdtQXRTUvDwGGXwpnpU=";
    installPath = "https/repo1.maven.org/maven2/org/scala-lang/scala-library/2.13.16";
  };

  "org.scala-lang_scala-reflect-2.13.15" = fetchMaven {
    name = "org.scala-lang_scala-reflect-2.13.15";
    urls = [ "https://repo1.maven.org/maven2/org/scala-lang/scala-reflect/2.13.15/scala-reflect-2.13.15.jar" "https://repo1.maven.org/maven2/org/scala-lang/scala-reflect/2.13.15/scala-reflect-2.13.15.pom" ];
    hash = "sha256-zmUU4hTEf5HC311UaNIHmzjSwWSbjXn6DyPP7ZzFy/8=";
    installPath = "https/repo1.maven.org/maven2/org/scala-lang/scala-reflect/2.13.15";
  };

  "org.scala-lang_scala3-compiler_3-3.3.3" = fetchMaven {
    name = "org.scala-lang_scala3-compiler_3-3.3.3";
    urls = [ "https://repo1.maven.org/maven2/org/scala-lang/scala3-compiler_3/3.3.3/scala3-compiler_3-3.3.3.jar" "https://repo1.maven.org/maven2/org/scala-lang/scala3-compiler_3/3.3.3/scala3-compiler_3-3.3.3.pom" ];
    hash = "sha256-92h7lk0HzRY196TWvz0WC+mzvsMhKTX3Kw1VQmQ0J2U=";
    installPath = "https/repo1.maven.org/maven2/org/scala-lang/scala3-compiler_3/3.3.3";
  };

  "org.scala-lang_scala3-interfaces-3.3.3" = fetchMaven {
    name = "org.scala-lang_scala3-interfaces-3.3.3";
    urls = [ "https://repo1.maven.org/maven2/org/scala-lang/scala3-interfaces/3.3.3/scala3-interfaces-3.3.3.jar" "https://repo1.maven.org/maven2/org/scala-lang/scala3-interfaces/3.3.3/scala3-interfaces-3.3.3.pom" ];
    hash = "sha256-mhWI7z4UNPcHKKUSk8Zj10VI4wyWl0ZmQdTogQYbaig=";
    installPath = "https/repo1.maven.org/maven2/org/scala-lang/scala3-interfaces/3.3.3";
  };

  "org.scala-lang_scala3-library_3-3.3.3" = fetchMaven {
    name = "org.scala-lang_scala3-library_3-3.3.3";
    urls = [ "https://repo1.maven.org/maven2/org/scala-lang/scala3-library_3/3.3.3/scala3-library_3-3.3.3.jar" "https://repo1.maven.org/maven2/org/scala-lang/scala3-library_3/3.3.3/scala3-library_3-3.3.3.pom" ];
    hash = "sha256-FP9HXhGNrMqWvFOiZd4DzFySPzoKLjw19HsVFNFd/EU=";
    installPath = "https/repo1.maven.org/maven2/org/scala-lang/scala3-library_3/3.3.3";
  };

  "org.scala-lang_scala3-sbt-bridge-3.3.3" = fetchMaven {
    name = "org.scala-lang_scala3-sbt-bridge-3.3.3";
    urls = [ "https://repo1.maven.org/maven2/org/scala-lang/scala3-sbt-bridge/3.3.3/scala3-sbt-bridge-3.3.3.jar" "https://repo1.maven.org/maven2/org/scala-lang/scala3-sbt-bridge/3.3.3/scala3-sbt-bridge-3.3.3.pom" ];
    hash = "sha256-UoQFVHgo+ozy13xPO0APB7MMsbBiPNrEemJ/X7hXVbo=";
    installPath = "https/repo1.maven.org/maven2/org/scala-lang/scala3-sbt-bridge/3.3.3";
  };

  "org.scala-lang_scala3-tasty-inspector_3-3.3.3" = fetchMaven {
    name = "org.scala-lang_scala3-tasty-inspector_3-3.3.3";
    urls = [ "https://repo1.maven.org/maven2/org/scala-lang/scala3-tasty-inspector_3/3.3.3/scala3-tasty-inspector_3-3.3.3.jar" "https://repo1.maven.org/maven2/org/scala-lang/scala3-tasty-inspector_3/3.3.3/scala3-tasty-inspector_3-3.3.3.pom" ];
    hash = "sha256-0iZf0Y8GaPX00hFmnEMV9CsjBnatYb2r3Rj3TycvQ1o=";
    installPath = "https/repo1.maven.org/maven2/org/scala-lang/scala3-tasty-inspector_3/3.3.3";
  };

  "org.scala-lang_scaladoc_3-3.3.3" = fetchMaven {
    name = "org.scala-lang_scaladoc_3-3.3.3";
    urls = [ "https://repo1.maven.org/maven2/org/scala-lang/scaladoc_3/3.3.3/scaladoc_3-3.3.3.jar" "https://repo1.maven.org/maven2/org/scala-lang/scaladoc_3/3.3.3/scaladoc_3-3.3.3.pom" ];
    hash = "sha256-nLhLFKJxDAZdpyNRyGubAc3KO5m09znF9C/zcddnkHc=";
    installPath = "https/repo1.maven.org/maven2/org/scala-lang/scaladoc_3/3.3.3";
  };

  "org.scala-lang_scalap-2.13.15" = fetchMaven {
    name = "org.scala-lang_scalap-2.13.15";
    urls = [ "https://repo1.maven.org/maven2/org/scala-lang/scalap/2.13.15/scalap-2.13.15.jar" "https://repo1.maven.org/maven2/org/scala-lang/scalap/2.13.15/scalap-2.13.15.pom" ];
    hash = "sha256-JMnmdCcFUakGj+seqTp15VYMzcq90jGjQPmKbCzY28A=";
    installPath = "https/repo1.maven.org/maven2/org/scala-lang/scalap/2.13.15";
  };

  "org.scala-lang_tasty-core_3-3.3.3" = fetchMaven {
    name = "org.scala-lang_tasty-core_3-3.3.3";
    urls = [ "https://repo1.maven.org/maven2/org/scala-lang/tasty-core_3/3.3.3/tasty-core_3-3.3.3.jar" "https://repo1.maven.org/maven2/org/scala-lang/tasty-core_3/3.3.3/tasty-core_3-3.3.3.pom" ];
    hash = "sha256-EpC3+u+yvlc/bEUOKASRrQf9DqB3d7OrM2I0Y3ECSL0=";
    installPath = "https/repo1.maven.org/maven2/org/scala-lang/tasty-core_3/3.3.3";
  };

  "org.scala-sbt_collections_2.13-1.10.7" = fetchMaven {
    name = "org.scala-sbt_collections_2.13-1.10.7";
    urls = [ "https://repo1.maven.org/maven2/org/scala-sbt/collections_2.13/1.10.7/collections_2.13-1.10.7.jar" "https://repo1.maven.org/maven2/org/scala-sbt/collections_2.13/1.10.7/collections_2.13-1.10.7.pom" ];
    hash = "sha256-y4FuwehuxB+70YBIKj5jH9L8tQpHrWFpPc9VrBUzM6Y=";
    installPath = "https/repo1.maven.org/maven2/org/scala-sbt/collections_2.13/1.10.7";
  };

  "org.scala-sbt_compiler-bridge_2.13-1.10.7" = fetchMaven {
    name = "org.scala-sbt_compiler-bridge_2.13-1.10.7";
    urls = [ "https://repo1.maven.org/maven2/org/scala-sbt/compiler-bridge_2.13/1.10.7/compiler-bridge_2.13-1.10.7.jar" "https://repo1.maven.org/maven2/org/scala-sbt/compiler-bridge_2.13/1.10.7/compiler-bridge_2.13-1.10.7.pom" ];
    hash = "sha256-9l1vxfLu6JEyJKdPaBO6RkEn/KoiW7d59C/xAQdeb+Y=";
    installPath = "https/repo1.maven.org/maven2/org/scala-sbt/compiler-bridge_2.13/1.10.7";
  };

  "org.scala-sbt_compiler-interface-1.10.3" = fetchMaven {
    name = "org.scala-sbt_compiler-interface-1.10.3";
    urls = [ "https://repo1.maven.org/maven2/org/scala-sbt/compiler-interface/1.10.3/compiler-interface-1.10.3.jar" "https://repo1.maven.org/maven2/org/scala-sbt/compiler-interface/1.10.3/compiler-interface-1.10.3.pom" ];
    hash = "sha256-eUpVhTZhe/6qSWs+XkD7bDhrqCv893HCNme7G4yPyeg=";
    installPath = "https/repo1.maven.org/maven2/org/scala-sbt/compiler-interface/1.10.3";
  };

  "org.scala-sbt_compiler-interface-1.10.7" = fetchMaven {
    name = "org.scala-sbt_compiler-interface-1.10.7";
    urls = [ "https://repo1.maven.org/maven2/org/scala-sbt/compiler-interface/1.10.7/compiler-interface-1.10.7.jar" "https://repo1.maven.org/maven2/org/scala-sbt/compiler-interface/1.10.7/compiler-interface-1.10.7.pom" ];
    hash = "sha256-nFVs4vEVTEPSiGce3C77TTjvffSU+SMrn9KgV9xGVP0=";
    installPath = "https/repo1.maven.org/maven2/org/scala-sbt/compiler-interface/1.10.7";
  };

  "org.scala-sbt_compiler-interface-1.9.3" = fetchMaven {
    name = "org.scala-sbt_compiler-interface-1.9.3";
    urls = [ "https://repo1.maven.org/maven2/org/scala-sbt/compiler-interface/1.9.3/compiler-interface-1.9.3.jar" "https://repo1.maven.org/maven2/org/scala-sbt/compiler-interface/1.9.3/compiler-interface-1.9.3.pom" ];
    hash = "sha256-DNLv/1XHJtlITUoZrAu0b7UqTGlyN38sjTUf7cGgvZE=";
    installPath = "https/repo1.maven.org/maven2/org/scala-sbt/compiler-interface/1.9.3";
  };

  "org.scala-sbt_core-macros_2.13-1.10.7" = fetchMaven {
    name = "org.scala-sbt_core-macros_2.13-1.10.7";
    urls = [ "https://repo1.maven.org/maven2/org/scala-sbt/core-macros_2.13/1.10.7/core-macros_2.13-1.10.7.jar" "https://repo1.maven.org/maven2/org/scala-sbt/core-macros_2.13/1.10.7/core-macros_2.13-1.10.7.pom" ];
    hash = "sha256-rsDP4K+yiTgLhmdDP7G5iL3i43v+Dwki9pKXPeWUp4c=";
    installPath = "https/repo1.maven.org/maven2/org/scala-sbt/core-macros_2.13/1.10.7";
  };

  "org.scala-sbt_io_2.13-1.10.3" = fetchMaven {
    name = "org.scala-sbt_io_2.13-1.10.3";
    urls = [ "https://repo1.maven.org/maven2/org/scala-sbt/io_2.13/1.10.3/io_2.13-1.10.3.jar" "https://repo1.maven.org/maven2/org/scala-sbt/io_2.13/1.10.3/io_2.13-1.10.3.pom" ];
    hash = "sha256-+v1VvZGVtuyxaFCTxa66IGrvdqCDSJXPBAtHwDmdNQI=";
    installPath = "https/repo1.maven.org/maven2/org/scala-sbt/io_2.13/1.10.3";
  };

  "org.scala-sbt_launcher-interface-1.4.4" = fetchMaven {
    name = "org.scala-sbt_launcher-interface-1.4.4";
    urls = [ "https://repo1.maven.org/maven2/org/scala-sbt/launcher-interface/1.4.4/launcher-interface-1.4.4.jar" "https://repo1.maven.org/maven2/org/scala-sbt/launcher-interface/1.4.4/launcher-interface-1.4.4.pom" ];
    hash = "sha256-HWiEWRS8Grm7uQME6o7FYZFhWvJgvrvyxKXMATB0Z7E=";
    installPath = "https/repo1.maven.org/maven2/org/scala-sbt/launcher-interface/1.4.4";
  };

  "org.scala-sbt_sbinary_2.13-0.5.1" = fetchMaven {
    name = "org.scala-sbt_sbinary_2.13-0.5.1";
    urls = [ "https://repo1.maven.org/maven2/org/scala-sbt/sbinary_2.13/0.5.1/sbinary_2.13-0.5.1.jar" "https://repo1.maven.org/maven2/org/scala-sbt/sbinary_2.13/0.5.1/sbinary_2.13-0.5.1.pom" ];
    hash = "sha256-+TrjPjSy8WVXq3IYHkHHIzttvHQbgwMLkwwWBys/ryw=";
    installPath = "https/repo1.maven.org/maven2/org/scala-sbt/sbinary_2.13/0.5.1";
  };

  "org.scala-sbt_test-interface-1.0" = fetchMaven {
    name = "org.scala-sbt_test-interface-1.0";
    urls = [ "https://repo1.maven.org/maven2/org/scala-sbt/test-interface/1.0/test-interface-1.0.jar" "https://repo1.maven.org/maven2/org/scala-sbt/test-interface/1.0/test-interface-1.0.pom" ];
    hash = "sha256-Cc5Q+4mULLHRdw+7Wjx6spCLbKrckXHeNYjIibw4LWw=";
    installPath = "https/repo1.maven.org/maven2/org/scala-sbt/test-interface/1.0";
  };

  "org.scala-sbt_util-control_2.13-1.10.7" = fetchMaven {
    name = "org.scala-sbt_util-control_2.13-1.10.7";
    urls = [ "https://repo1.maven.org/maven2/org/scala-sbt/util-control_2.13/1.10.7/util-control_2.13-1.10.7.jar" "https://repo1.maven.org/maven2/org/scala-sbt/util-control_2.13/1.10.7/util-control_2.13-1.10.7.pom" ];
    hash = "sha256-CCG/nXpVyd7YrtCYr47tPYIQs/G6vzb/3fCyZ21drhM=";
    installPath = "https/repo1.maven.org/maven2/org/scala-sbt/util-control_2.13/1.10.7";
  };

  "org.scala-sbt_util-interface-1.10.3" = fetchMaven {
    name = "org.scala-sbt_util-interface-1.10.3";
    urls = [ "https://repo1.maven.org/maven2/org/scala-sbt/util-interface/1.10.3/util-interface-1.10.3.jar" "https://repo1.maven.org/maven2/org/scala-sbt/util-interface/1.10.3/util-interface-1.10.3.pom" ];
    hash = "sha256-uu+2jvXfm2FaHkvJb44uRGdelrtS9pLfolU977MMQj0=";
    installPath = "https/repo1.maven.org/maven2/org/scala-sbt/util-interface/1.10.3";
  };

  "org.scala-sbt_util-interface-1.10.7" = fetchMaven {
    name = "org.scala-sbt_util-interface-1.10.7";
    urls = [ "https://repo1.maven.org/maven2/org/scala-sbt/util-interface/1.10.7/util-interface-1.10.7.jar" "https://repo1.maven.org/maven2/org/scala-sbt/util-interface/1.10.7/util-interface-1.10.7.pom" ];
    hash = "sha256-cIOD5+vCDptOP6jwds5yG+23h2H54npBzGu3jrCQlvQ=";
    installPath = "https/repo1.maven.org/maven2/org/scala-sbt/util-interface/1.10.7";
  };

  "org.scala-sbt_util-interface-1.9.2" = fetchMaven {
    name = "org.scala-sbt_util-interface-1.9.2";
    urls = [ "https://repo1.maven.org/maven2/org/scala-sbt/util-interface/1.9.2/util-interface-1.9.2.jar" "https://repo1.maven.org/maven2/org/scala-sbt/util-interface/1.9.2/util-interface-1.9.2.pom" ];
    hash = "sha256-A9Nf8+YZOXa5DBozMLu0hMRdTwGZvsqHi10OUUHd77s=";
    installPath = "https/repo1.maven.org/maven2/org/scala-sbt/util-interface/1.9.2";
  };

  "org.scala-sbt_util-logging_2.13-1.10.7" = fetchMaven {
    name = "org.scala-sbt_util-logging_2.13-1.10.7";
    urls = [ "https://repo1.maven.org/maven2/org/scala-sbt/util-logging_2.13/1.10.7/util-logging_2.13-1.10.7.jar" "https://repo1.maven.org/maven2/org/scala-sbt/util-logging_2.13/1.10.7/util-logging_2.13-1.10.7.pom" ];
    hash = "sha256-WfmccbZodef+h77nl7kEe6VxAsyzYlaHudZX0iyTRAs=";
    installPath = "https/repo1.maven.org/maven2/org/scala-sbt/util-logging_2.13/1.10.7";
  };

  "org.scala-sbt_util-position_2.13-1.10.7" = fetchMaven {
    name = "org.scala-sbt_util-position_2.13-1.10.7";
    urls = [ "https://repo1.maven.org/maven2/org/scala-sbt/util-position_2.13/1.10.7/util-position_2.13-1.10.7.jar" "https://repo1.maven.org/maven2/org/scala-sbt/util-position_2.13/1.10.7/util-position_2.13-1.10.7.pom" ];
    hash = "sha256-hhRemdHTn5rI6IpViSG7KUxU/F2idL0AQf9CdNrF6xA=";
    installPath = "https/repo1.maven.org/maven2/org/scala-sbt/util-position_2.13/1.10.7";
  };

  "org.scala-sbt_util-relation_2.13-1.10.7" = fetchMaven {
    name = "org.scala-sbt_util-relation_2.13-1.10.7";
    urls = [ "https://repo1.maven.org/maven2/org/scala-sbt/util-relation_2.13/1.10.7/util-relation_2.13-1.10.7.jar" "https://repo1.maven.org/maven2/org/scala-sbt/util-relation_2.13/1.10.7/util-relation_2.13-1.10.7.pom" ];
    hash = "sha256-r2kRBeuvusfdZwqZsRRuwp1Sr1PjWDuchmXbVPcSUOM=";
    installPath = "https/repo1.maven.org/maven2/org/scala-sbt/util-relation_2.13/1.10.7";
  };

  "org.scala-sbt_zinc-apiinfo_2.13-1.10.7" = fetchMaven {
    name = "org.scala-sbt_zinc-apiinfo_2.13-1.10.7";
    urls = [ "https://repo1.maven.org/maven2/org/scala-sbt/zinc-apiinfo_2.13/1.10.7/zinc-apiinfo_2.13-1.10.7.jar" "https://repo1.maven.org/maven2/org/scala-sbt/zinc-apiinfo_2.13/1.10.7/zinc-apiinfo_2.13-1.10.7.pom" ];
    hash = "sha256-nRr38N6FO18MM0+mlb9lK2EOhfl7GZ1y7ez6Eg3Ip8w=";
    installPath = "https/repo1.maven.org/maven2/org/scala-sbt/zinc-apiinfo_2.13/1.10.7";
  };

  "org.scala-sbt_zinc-classfile_2.13-1.10.7" = fetchMaven {
    name = "org.scala-sbt_zinc-classfile_2.13-1.10.7";
    urls = [ "https://repo1.maven.org/maven2/org/scala-sbt/zinc-classfile_2.13/1.10.7/zinc-classfile_2.13-1.10.7.jar" "https://repo1.maven.org/maven2/org/scala-sbt/zinc-classfile_2.13/1.10.7/zinc-classfile_2.13-1.10.7.pom" ];
    hash = "sha256-0UOFRvovrzzXFILxniSzo5MHr/XmSDGP4o3wh05uCxE=";
    installPath = "https/repo1.maven.org/maven2/org/scala-sbt/zinc-classfile_2.13/1.10.7";
  };

  "org.scala-sbt_zinc-classpath_2.13-1.10.7" = fetchMaven {
    name = "org.scala-sbt_zinc-classpath_2.13-1.10.7";
    urls = [ "https://repo1.maven.org/maven2/org/scala-sbt/zinc-classpath_2.13/1.10.7/zinc-classpath_2.13-1.10.7.jar" "https://repo1.maven.org/maven2/org/scala-sbt/zinc-classpath_2.13/1.10.7/zinc-classpath_2.13-1.10.7.pom" ];
    hash = "sha256-ozsxGbCrycacvLvk8tf0SHjdR9DU+5+494IJdkotRjg=";
    installPath = "https/repo1.maven.org/maven2/org/scala-sbt/zinc-classpath_2.13/1.10.7";
  };

  "org.scala-sbt_zinc-compile-core_2.13-1.10.7" = fetchMaven {
    name = "org.scala-sbt_zinc-compile-core_2.13-1.10.7";
    urls = [ "https://repo1.maven.org/maven2/org/scala-sbt/zinc-compile-core_2.13/1.10.7/zinc-compile-core_2.13-1.10.7.jar" "https://repo1.maven.org/maven2/org/scala-sbt/zinc-compile-core_2.13/1.10.7/zinc-compile-core_2.13-1.10.7.pom" ];
    hash = "sha256-E7vR41TZnHQWM6FyVr48WDhplRHFfFta4E4JEl8/CtQ=";
    installPath = "https/repo1.maven.org/maven2/org/scala-sbt/zinc-compile-core_2.13/1.10.7";
  };

  "org.scala-sbt_zinc-core_2.13-1.10.7" = fetchMaven {
    name = "org.scala-sbt_zinc-core_2.13-1.10.7";
    urls = [ "https://repo1.maven.org/maven2/org/scala-sbt/zinc-core_2.13/1.10.7/zinc-core_2.13-1.10.7.jar" "https://repo1.maven.org/maven2/org/scala-sbt/zinc-core_2.13/1.10.7/zinc-core_2.13-1.10.7.pom" ];
    hash = "sha256-eQFUHHuNND26t29kyYz7vbAscVCJej/Lc8eQRktDTGA=";
    installPath = "https/repo1.maven.org/maven2/org/scala-sbt/zinc-core_2.13/1.10.7";
  };

  "org.scala-sbt_zinc-persist-core-assembly-1.10.7" = fetchMaven {
    name = "org.scala-sbt_zinc-persist-core-assembly-1.10.7";
    urls = [ "https://repo1.maven.org/maven2/org/scala-sbt/zinc-persist-core-assembly/1.10.7/zinc-persist-core-assembly-1.10.7.jar" "https://repo1.maven.org/maven2/org/scala-sbt/zinc-persist-core-assembly/1.10.7/zinc-persist-core-assembly-1.10.7.pom" ];
    hash = "sha256-KNr16Jjhbu3hrKUn/rTpEiEqWV/mC/iFhbO0YmToUCA=";
    installPath = "https/repo1.maven.org/maven2/org/scala-sbt/zinc-persist-core-assembly/1.10.7";
  };

  "org.scala-sbt_zinc-persist_2.13-1.10.7" = fetchMaven {
    name = "org.scala-sbt_zinc-persist_2.13-1.10.7";
    urls = [ "https://repo1.maven.org/maven2/org/scala-sbt/zinc-persist_2.13/1.10.7/zinc-persist_2.13-1.10.7.jar" "https://repo1.maven.org/maven2/org/scala-sbt/zinc-persist_2.13/1.10.7/zinc-persist_2.13-1.10.7.pom" ];
    hash = "sha256-aO6mPsEjKHbl0ZqB/a/hZ/FArCqXpR63D8y86bxkwpU=";
    installPath = "https/repo1.maven.org/maven2/org/scala-sbt/zinc-persist_2.13/1.10.7";
  };

  "org.scala-sbt_zinc_2.13-1.10.7" = fetchMaven {
    name = "org.scala-sbt_zinc_2.13-1.10.7";
    urls = [ "https://repo1.maven.org/maven2/org/scala-sbt/zinc_2.13/1.10.7/zinc_2.13-1.10.7.jar" "https://repo1.maven.org/maven2/org/scala-sbt/zinc_2.13/1.10.7/zinc_2.13-1.10.7.pom" ];
    hash = "sha256-G87j0JvuTu7cEu4gUZ268vxJ79vs7qR0p8J1wT+wwD4=";
    installPath = "https/repo1.maven.org/maven2/org/scala-sbt/zinc_2.13/1.10.7";
  };

  "org.slf4j_slf4j-api-2.0.16" = fetchMaven {
    name = "org.slf4j_slf4j-api-2.0.16";
    urls = [ "https://repo1.maven.org/maven2/org/slf4j/slf4j-api/2.0.16/slf4j-api-2.0.16.jar" "https://repo1.maven.org/maven2/org/slf4j/slf4j-api/2.0.16/slf4j-api-2.0.16.pom" ];
    hash = "sha256-DTTfHW73wo7guf3qls7YCCtxLOW+nQfBtC8iGlngIhg=";
    installPath = "https/repo1.maven.org/maven2/org/slf4j/slf4j-api/2.0.16";
  };

  "org.slf4j_slf4j-bom-2.0.16" = fetchMaven {
    name = "org.slf4j_slf4j-bom-2.0.16";
    urls = [ "https://repo1.maven.org/maven2/org/slf4j/slf4j-bom/2.0.16/slf4j-bom-2.0.16.pom" ];
    hash = "sha256-57CmnZTTjeAyWOFnpSVmPT8waKxeOQosvvyHZDdDHg0=";
    installPath = "https/repo1.maven.org/maven2/org/slf4j/slf4j-bom/2.0.16";
  };

  "org.slf4j_slf4j-parent-2.0.16" = fetchMaven {
    name = "org.slf4j_slf4j-parent-2.0.16";
    urls = [ "https://repo1.maven.org/maven2/org/slf4j/slf4j-parent/2.0.16/slf4j-parent-2.0.16.pom" ];
    hash = "sha256-PHcUu7tbYLAd/qhe6V7TCF1I5d4Fs+nQqjM3wwYYEUc=";
    installPath = "https/repo1.maven.org/maven2/org/slf4j/slf4j-parent/2.0.16";
  };

  "org.springframework_spring-framework-bom-5.3.39" = fetchMaven {
    name = "org.springframework_spring-framework-bom-5.3.39";
    urls = [ "https://repo1.maven.org/maven2/org/springframework/spring-framework-bom/5.3.39/spring-framework-bom-5.3.39.pom" ];
    hash = "sha256-V+sR9AvokPz2NrvEFCxdLHl3jrW2o9dP3gisCDAUUDA=";
    installPath = "https/repo1.maven.org/maven2/org/springframework/spring-framework-bom/5.3.39";
  };

  "org.testcontainers_testcontainers-bom-1.20.4" = fetchMaven {
    name = "org.testcontainers_testcontainers-bom-1.20.4";
    urls = [ "https://repo1.maven.org/maven2/org/testcontainers/testcontainers-bom/1.20.4/testcontainers-bom-1.20.4.pom" ];
    hash = "sha256-yavsJKtF6CSRlOeCgZY/Zik+Qiqv1gZvtj367B6buiM=";
    installPath = "https/repo1.maven.org/maven2/org/testcontainers/testcontainers-bom/1.20.4";
  };

  "org.tukaani_xz-1.9" = fetchMaven {
    name = "org.tukaani_xz-1.9";
    urls = [ "https://repo1.maven.org/maven2/org/tukaani/xz/1.9/xz-1.9.jar" "https://repo1.maven.org/maven2/org/tukaani/xz/1.9/xz-1.9.pom" ];
    hash = "sha256-qS7mXrLbWChlkYWhtNTIEPFzgTW6ZMdLoD2a2HzwrHo=";
    installPath = "https/repo1.maven.org/maven2/org/tukaani/xz/1.9";
  };

  "org.yaml_snakeyaml-2.0" = fetchMaven {
    name = "org.yaml_snakeyaml-2.0";
    urls = [ "https://repo1.maven.org/maven2/org/yaml/snakeyaml/2.0/snakeyaml-2.0.jar" "https://repo1.maven.org/maven2/org/yaml/snakeyaml/2.0/snakeyaml-2.0.pom" ];
    hash = "sha256-4/5l8lMWWNxqv1JGr0n8QtEo0KGAUGULj7lmdy9TODI=";
    installPath = "https/repo1.maven.org/maven2/org/yaml/snakeyaml/2.0";
  };

  "com.fasterxml.jackson_jackson-base-2.12.1" = fetchMaven {
    name = "com.fasterxml.jackson_jackson-base-2.12.1";
    urls = [ "https://repo1.maven.org/maven2/com/fasterxml/jackson/jackson-base/2.12.1/jackson-base-2.12.1.pom" ];
    hash = "sha256-QdwEWejSbiS//t8L9WxLqUxc0QQMY90a7ckBf6YzS2M=";
    installPath = "https/repo1.maven.org/maven2/com/fasterxml/jackson/jackson-base/2.12.1";
  };

  "com.fasterxml.jackson_jackson-base-2.15.1" = fetchMaven {
    name = "com.fasterxml.jackson_jackson-base-2.15.1";
    urls = [ "https://repo1.maven.org/maven2/com/fasterxml/jackson/jackson-base/2.15.1/jackson-base-2.15.1.pom" ];
    hash = "sha256-DEG+wnRgBDaKE+g5oWHRRWcpgUH3rSj+eex3MKkiDYA=";
    installPath = "https/repo1.maven.org/maven2/com/fasterxml/jackson/jackson-base/2.15.1";
  };

  "com.fasterxml.jackson_jackson-bom-2.12.1" = fetchMaven {
    name = "com.fasterxml.jackson_jackson-bom-2.12.1";
    urls = [ "https://repo1.maven.org/maven2/com/fasterxml/jackson/jackson-bom/2.12.1/jackson-bom-2.12.1.pom" ];
    hash = "sha256-IVTSEkQzRB352EzD1i+FXx8n+HSzPMD5TGq4Ez0VTzc=";
    installPath = "https/repo1.maven.org/maven2/com/fasterxml/jackson/jackson-bom/2.12.1";
  };

  "com.fasterxml.jackson_jackson-bom-2.15.1" = fetchMaven {
    name = "com.fasterxml.jackson_jackson-bom-2.15.1";
    urls = [ "https://repo1.maven.org/maven2/com/fasterxml/jackson/jackson-bom/2.15.1/jackson-bom-2.15.1.pom" ];
    hash = "sha256-xTY1hTkw6E3dYAMDZnockm2fm43WPMcIRt0k2oxO2O8=";
    installPath = "https/repo1.maven.org/maven2/com/fasterxml/jackson/jackson-bom/2.15.1";
  };

  "com.fasterxml.jackson_jackson-bom-2.17.2" = fetchMaven {
    name = "com.fasterxml.jackson_jackson-bom-2.17.2";
    urls = [ "https://repo1.maven.org/maven2/com/fasterxml/jackson/jackson-bom/2.17.2/jackson-bom-2.17.2.pom" ];
    hash = "sha256-uAhCPZKxSJE8I5PhUlyXZOF9QVS/Xh+BQiYGmUYA86E=";
    installPath = "https/repo1.maven.org/maven2/com/fasterxml/jackson/jackson-bom/2.17.2";
  };

  "com.fasterxml.jackson_jackson-bom-2.18.2" = fetchMaven {
    name = "com.fasterxml.jackson_jackson-bom-2.18.2";
    urls = [ "https://repo1.maven.org/maven2/com/fasterxml/jackson/jackson-bom/2.18.2/jackson-bom-2.18.2.pom" ];
    hash = "sha256-zlMHW6EQjXX1QrKglhNEmTuf3hRA6LNpzBcoh3FGWxY=";
    installPath = "https/repo1.maven.org/maven2/com/fasterxml/jackson/jackson-bom/2.18.2";
  };

  "com.fasterxml.jackson_jackson-parent-2.12" = fetchMaven {
    name = "com.fasterxml.jackson_jackson-parent-2.12";
    urls = [ "https://repo1.maven.org/maven2/com/fasterxml/jackson/jackson-parent/2.12/jackson-parent-2.12.pom" ];
    hash = "sha256-1XZX837v+3OgmuIWerAxNmHU3KA9W6GDs10dtM+w11o=";
    installPath = "https/repo1.maven.org/maven2/com/fasterxml/jackson/jackson-parent/2.12";
  };

  "com.fasterxml.jackson_jackson-parent-2.15" = fetchMaven {
    name = "com.fasterxml.jackson_jackson-parent-2.15";
    urls = [ "https://repo1.maven.org/maven2/com/fasterxml/jackson/jackson-parent/2.15/jackson-parent-2.15.pom" ];
    hash = "sha256-Rybw8nineMf0Xjlc5GhV4ayVQMYocW1rCXiNhgdXiXc=";
    installPath = "https/repo1.maven.org/maven2/com/fasterxml/jackson/jackson-parent/2.15";
  };

  "com.fasterxml.jackson_jackson-parent-2.17" = fetchMaven {
    name = "com.fasterxml.jackson_jackson-parent-2.17";
    urls = [ "https://repo1.maven.org/maven2/com/fasterxml/jackson/jackson-parent/2.17/jackson-parent-2.17.pom" ];
    hash = "sha256-bwpdlIPUrYpG6AmpG+vbSgz7gRpEaUy7i1k2ZxRlYGc=";
    installPath = "https/repo1.maven.org/maven2/com/fasterxml/jackson/jackson-parent/2.17";
  };

  "com.fasterxml.jackson_jackson-parent-2.18.1" = fetchMaven {
    name = "com.fasterxml.jackson_jackson-parent-2.18.1";
    urls = [ "https://repo1.maven.org/maven2/com/fasterxml/jackson/jackson-parent/2.18.1/jackson-parent-2.18.1.pom" ];
    hash = "sha256-jogHcaIlfuIF8p3Pn6pQ7VJGEx1aKhBFLVdg2l+coOQ=";
    installPath = "https/repo1.maven.org/maven2/com/fasterxml/jackson/jackson-parent/2.18.1";
  };

  "com.github.luben_zstd-jni-1.5.6-3" = fetchMaven {
    name = "com.github.luben_zstd-jni-1.5.6-3";
    urls = [ "https://repo1.maven.org/maven2/com/github/luben/zstd-jni/1.5.6-3/zstd-jni-1.5.6-3.jar" "https://repo1.maven.org/maven2/com/github/luben/zstd-jni/1.5.6-3/zstd-jni-1.5.6-3.pom" ];
    hash = "sha256-G2XN0zZUVQXAfKdRU6CY25kmyWAsu0RY3dlZ44zG208=";
    installPath = "https/repo1.maven.org/maven2/com/github/luben/zstd-jni/1.5.6-3";
  };

  "com.vladsch.flexmark_flexmark-0.62.2" = fetchMaven {
    name = "com.vladsch.flexmark_flexmark-0.62.2";
    urls = [ "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark/0.62.2/flexmark-0.62.2.jar" "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark/0.62.2/flexmark-0.62.2.pom" ];
    hash = "sha256-CMbMcOs3cMmCu7+sAh6qiwj63tMDlJ6qIrZRbHF2gDE=";
    installPath = "https/repo1.maven.org/maven2/com/vladsch/flexmark/flexmark/0.62.2";
  };

  "com.vladsch.flexmark_flexmark-ext-anchorlink-0.62.2" = fetchMaven {
    name = "com.vladsch.flexmark_flexmark-ext-anchorlink-0.62.2";
    urls = [ "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-anchorlink/0.62.2/flexmark-ext-anchorlink-0.62.2.jar" "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-anchorlink/0.62.2/flexmark-ext-anchorlink-0.62.2.pom" ];
    hash = "sha256-weHNR6k/69NjAg2Vs72ce1wOZ1rwBicv4TMLDS9jnGE=";
    installPath = "https/repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-anchorlink/0.62.2";
  };

  "com.vladsch.flexmark_flexmark-ext-autolink-0.62.2" = fetchMaven {
    name = "com.vladsch.flexmark_flexmark-ext-autolink-0.62.2";
    urls = [ "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-autolink/0.62.2/flexmark-ext-autolink-0.62.2.jar" "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-autolink/0.62.2/flexmark-ext-autolink-0.62.2.pom" ];
    hash = "sha256-15OH05RylvbLSzEu47GBdhtKZvyP3ibjXETb+3Sn5+Y=";
    installPath = "https/repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-autolink/0.62.2";
  };

  "com.vladsch.flexmark_flexmark-ext-emoji-0.62.2" = fetchMaven {
    name = "com.vladsch.flexmark_flexmark-ext-emoji-0.62.2";
    urls = [ "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-emoji/0.62.2/flexmark-ext-emoji-0.62.2.jar" "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-emoji/0.62.2/flexmark-ext-emoji-0.62.2.pom" ];
    hash = "sha256-UHbh+WMLnLqFzhE9GIdc3pwFEBy94rNpWT6olRGnIvI=";
    installPath = "https/repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-emoji/0.62.2";
  };

  "com.vladsch.flexmark_flexmark-ext-gfm-strikethrough-0.62.2" = fetchMaven {
    name = "com.vladsch.flexmark_flexmark-ext-gfm-strikethrough-0.62.2";
    urls = [ "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-gfm-strikethrough/0.62.2/flexmark-ext-gfm-strikethrough-0.62.2.jar" "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-gfm-strikethrough/0.62.2/flexmark-ext-gfm-strikethrough-0.62.2.pom" ];
    hash = "sha256-1l/E13+s+Pc/CVD28MVSrqRUkkrfwKD6K0+2zvCQX8o=";
    installPath = "https/repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-gfm-strikethrough/0.62.2";
  };

  "com.vladsch.flexmark_flexmark-ext-gfm-tasklist-0.62.2" = fetchMaven {
    name = "com.vladsch.flexmark_flexmark-ext-gfm-tasklist-0.62.2";
    urls = [ "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-gfm-tasklist/0.62.2/flexmark-ext-gfm-tasklist-0.62.2.jar" "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-gfm-tasklist/0.62.2/flexmark-ext-gfm-tasklist-0.62.2.pom" ];
    hash = "sha256-gtACK+9qTISC22QYuWoyvgNeTXmuSOZxXuojXESKAvE=";
    installPath = "https/repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-gfm-tasklist/0.62.2";
  };

  "com.vladsch.flexmark_flexmark-ext-ins-0.62.2" = fetchMaven {
    name = "com.vladsch.flexmark_flexmark-ext-ins-0.62.2";
    urls = [ "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-ins/0.62.2/flexmark-ext-ins-0.62.2.jar" "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-ins/0.62.2/flexmark-ext-ins-0.62.2.pom" ];
    hash = "sha256-VIKNuMXAxAbmNWnk2nWPgpSzbkoGfpA6miKQuvOUmF4=";
    installPath = "https/repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-ins/0.62.2";
  };

  "com.vladsch.flexmark_flexmark-ext-superscript-0.62.2" = fetchMaven {
    name = "com.vladsch.flexmark_flexmark-ext-superscript-0.62.2";
    urls = [ "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-superscript/0.62.2/flexmark-ext-superscript-0.62.2.jar" "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-superscript/0.62.2/flexmark-ext-superscript-0.62.2.pom" ];
    hash = "sha256-pfRu434uIlDIkwSEaFwxZFwcUjTnU5cbuSfsG578PC4=";
    installPath = "https/repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-superscript/0.62.2";
  };

  "com.vladsch.flexmark_flexmark-ext-tables-0.62.2" = fetchMaven {
    name = "com.vladsch.flexmark_flexmark-ext-tables-0.62.2";
    urls = [ "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-tables/0.62.2/flexmark-ext-tables-0.62.2.jar" "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-tables/0.62.2/flexmark-ext-tables-0.62.2.pom" ];
    hash = "sha256-3Fef3ZHc6jjwTHjvOGsVvLAMbRMwJHlZ5X7SKIaCj6w=";
    installPath = "https/repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-tables/0.62.2";
  };

  "com.vladsch.flexmark_flexmark-ext-wikilink-0.62.2" = fetchMaven {
    name = "com.vladsch.flexmark_flexmark-ext-wikilink-0.62.2";
    urls = [ "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-wikilink/0.62.2/flexmark-ext-wikilink-0.62.2.jar" "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-wikilink/0.62.2/flexmark-ext-wikilink-0.62.2.pom" ];
    hash = "sha256-NQtfUT4F3p6+nGk6o07EwlX1kZvkXarCfWw07QQgYyE=";
    installPath = "https/repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-wikilink/0.62.2";
  };

  "com.vladsch.flexmark_flexmark-ext-yaml-front-matter-0.62.2" = fetchMaven {
    name = "com.vladsch.flexmark_flexmark-ext-yaml-front-matter-0.62.2";
    urls = [ "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-yaml-front-matter/0.62.2/flexmark-ext-yaml-front-matter-0.62.2.jar" "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-yaml-front-matter/0.62.2/flexmark-ext-yaml-front-matter-0.62.2.pom" ];
    hash = "sha256-tc0KpVAhnflMmVlFUXFqwocYsXuL3PiXeFtdO+p9Ta4=";
    installPath = "https/repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-yaml-front-matter/0.62.2";
  };

  "com.vladsch.flexmark_flexmark-java-0.62.2" = fetchMaven {
    name = "com.vladsch.flexmark_flexmark-java-0.62.2";
    urls = [ "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-java/0.62.2/flexmark-java-0.62.2.pom" ];
    hash = "sha256-DlxcWCry0vUFs1L54guu8FLGgpuYD9+ksL2x5sv6E9c=";
    installPath = "https/repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-java/0.62.2";
  };

  "com.vladsch.flexmark_flexmark-jira-converter-0.62.2" = fetchMaven {
    name = "com.vladsch.flexmark_flexmark-jira-converter-0.62.2";
    urls = [ "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-jira-converter/0.62.2/flexmark-jira-converter-0.62.2.jar" "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-jira-converter/0.62.2/flexmark-jira-converter-0.62.2.pom" ];
    hash = "sha256-k4eeiCIqq4fE5F0MPS9FMDEdlWEb+Gd36pDNxQSFMFY=";
    installPath = "https/repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-jira-converter/0.62.2";
  };

  "com.vladsch.flexmark_flexmark-util-0.62.2" = fetchMaven {
    name = "com.vladsch.flexmark_flexmark-util-0.62.2";
    urls = [ "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-util/0.62.2/flexmark-util-0.62.2.jar" "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-util/0.62.2/flexmark-util-0.62.2.pom" ];
    hash = "sha256-A3coPMDIx8qFH4WcoKFEcAY6MDeICS9olH/SPgIEbeI=";
    installPath = "https/repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-util/0.62.2";
  };

  "com.vladsch.flexmark_flexmark-util-ast-0.62.2" = fetchMaven {
    name = "com.vladsch.flexmark_flexmark-util-ast-0.62.2";
    urls = [ "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-util-ast/0.62.2/flexmark-util-ast-0.62.2.jar" "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-util-ast/0.62.2/flexmark-util-ast-0.62.2.pom" ];
    hash = "sha256-bT7Cqm3k63wFdcC63M3WAtz5p0QqArmmCvpfPGuvDjw=";
    installPath = "https/repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-util-ast/0.62.2";
  };

  "com.vladsch.flexmark_flexmark-util-builder-0.62.2" = fetchMaven {
    name = "com.vladsch.flexmark_flexmark-util-builder-0.62.2";
    urls = [ "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-util-builder/0.62.2/flexmark-util-builder-0.62.2.jar" "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-util-builder/0.62.2/flexmark-util-builder-0.62.2.pom" ];
    hash = "sha256-+kjX932WxGRANJw+UPDyy8MJB6wKUXI7tf+PyOAYbJM=";
    installPath = "https/repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-util-builder/0.62.2";
  };

  "com.vladsch.flexmark_flexmark-util-collection-0.62.2" = fetchMaven {
    name = "com.vladsch.flexmark_flexmark-util-collection-0.62.2";
    urls = [ "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-util-collection/0.62.2/flexmark-util-collection-0.62.2.jar" "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-util-collection/0.62.2/flexmark-util-collection-0.62.2.pom" ];
    hash = "sha256-vsdaPDU/TcTKnim4MAWhcXp4P0upYTWIMLMSCeg6Wx4=";
    installPath = "https/repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-util-collection/0.62.2";
  };

  "com.vladsch.flexmark_flexmark-util-data-0.62.2" = fetchMaven {
    name = "com.vladsch.flexmark_flexmark-util-data-0.62.2";
    urls = [ "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-util-data/0.62.2/flexmark-util-data-0.62.2.jar" "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-util-data/0.62.2/flexmark-util-data-0.62.2.pom" ];
    hash = "sha256-m3S05kD1HNXWdGXPwXapNqzLv4g2WicpuaNUJjvZDW4=";
    installPath = "https/repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-util-data/0.62.2";
  };

  "com.vladsch.flexmark_flexmark-util-dependency-0.62.2" = fetchMaven {
    name = "com.vladsch.flexmark_flexmark-util-dependency-0.62.2";
    urls = [ "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-util-dependency/0.62.2/flexmark-util-dependency-0.62.2.jar" "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-util-dependency/0.62.2/flexmark-util-dependency-0.62.2.pom" ];
    hash = "sha256-nSFsXZXFD67UbxMv6hAZEjv6VfCmewH9PsP6zk7vLR4=";
    installPath = "https/repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-util-dependency/0.62.2";
  };

  "com.vladsch.flexmark_flexmark-util-format-0.62.2" = fetchMaven {
    name = "com.vladsch.flexmark_flexmark-util-format-0.62.2";
    urls = [ "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-util-format/0.62.2/flexmark-util-format-0.62.2.jar" "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-util-format/0.62.2/flexmark-util-format-0.62.2.pom" ];
    hash = "sha256-j7GbAIjjp00wTPbuXCTO//af5J5JooOPmHh2Da3jBd0=";
    installPath = "https/repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-util-format/0.62.2";
  };

  "com.vladsch.flexmark_flexmark-util-html-0.62.2" = fetchMaven {
    name = "com.vladsch.flexmark_flexmark-util-html-0.62.2";
    urls = [ "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-util-html/0.62.2/flexmark-util-html-0.62.2.jar" "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-util-html/0.62.2/flexmark-util-html-0.62.2.pom" ];
    hash = "sha256-9MSBM5awDcqrCDRtRKKCrxD35X5DYf+U7NmUR8OOW94=";
    installPath = "https/repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-util-html/0.62.2";
  };

  "com.vladsch.flexmark_flexmark-util-misc-0.62.2" = fetchMaven {
    name = "com.vladsch.flexmark_flexmark-util-misc-0.62.2";
    urls = [ "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-util-misc/0.62.2/flexmark-util-misc-0.62.2.jar" "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-util-misc/0.62.2/flexmark-util-misc-0.62.2.pom" ];
    hash = "sha256-VfG2y0OgXWkcDF0VNHFTnOsf1jjmZtSZThZABQ0yc5A=";
    installPath = "https/repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-util-misc/0.62.2";
  };

  "com.vladsch.flexmark_flexmark-util-options-0.62.2" = fetchMaven {
    name = "com.vladsch.flexmark_flexmark-util-options-0.62.2";
    urls = [ "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-util-options/0.62.2/flexmark-util-options-0.62.2.jar" "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-util-options/0.62.2/flexmark-util-options-0.62.2.pom" ];
    hash = "sha256-Px6MK19ozVJLQGj3fCpDhMTUtrWLzhiqdDDRdBpf8i8=";
    installPath = "https/repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-util-options/0.62.2";
  };

  "com.vladsch.flexmark_flexmark-util-sequence-0.62.2" = fetchMaven {
    name = "com.vladsch.flexmark_flexmark-util-sequence-0.62.2";
    urls = [ "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-util-sequence/0.62.2/flexmark-util-sequence-0.62.2.jar" "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-util-sequence/0.62.2/flexmark-util-sequence-0.62.2.pom" ];
    hash = "sha256-J8ZXFheFBaMP+b9VMZ02j5Sonvtf26k6DR7C5AspxVg=";
    installPath = "https/repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-util-sequence/0.62.2";
  };

  "com.vladsch.flexmark_flexmark-util-visitor-0.62.2" = fetchMaven {
    name = "com.vladsch.flexmark_flexmark-util-visitor-0.62.2";
    urls = [ "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-util-visitor/0.62.2/flexmark-util-visitor-0.62.2.jar" "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-util-visitor/0.62.2/flexmark-util-visitor-0.62.2.pom" ];
    hash = "sha256-sGUXA1qXnyVQTMPXJoAh4L1+L895QeeW7oazG3/NqyI=";
    installPath = "https/repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-util-visitor/0.62.2";
  };

  "io.get-coursier.jniutils_windows-jni-utils-0.3.3" = fetchMaven {
    name = "io.get-coursier.jniutils_windows-jni-utils-0.3.3";
    urls = [ "https://repo1.maven.org/maven2/io/get-coursier/jniutils/windows-jni-utils/0.3.3/windows-jni-utils-0.3.3.jar" "https://repo1.maven.org/maven2/io/get-coursier/jniutils/windows-jni-utils/0.3.3/windows-jni-utils-0.3.3.pom" ];
    hash = "sha256-OgBT8ULqeyvpNMGSmXrwpYXR4VOAlmSIMs+BejCP56c=";
    installPath = "https/repo1.maven.org/maven2/io/get-coursier/jniutils/windows-jni-utils/0.3.3";
  };

  "io.github.alexarchambault_concurrent-reference-hash-map-1.1.0" = fetchMaven {
    name = "io.github.alexarchambault_concurrent-reference-hash-map-1.1.0";
    urls = [ "https://repo1.maven.org/maven2/io/github/alexarchambault/concurrent-reference-hash-map/1.1.0/concurrent-reference-hash-map-1.1.0.jar" "https://repo1.maven.org/maven2/io/github/alexarchambault/concurrent-reference-hash-map/1.1.0/concurrent-reference-hash-map-1.1.0.pom" ];
    hash = "sha256-949g3dbXxz773bZlkiK2Xh3XiY5Ofc+1k6i8LM6s+yI=";
    installPath = "https/repo1.maven.org/maven2/io/github/alexarchambault/concurrent-reference-hash-map/1.1.0";
  };

  "io.github.alexarchambault_is-terminal-0.1.2" = fetchMaven {
    name = "io.github.alexarchambault_is-terminal-0.1.2";
    urls = [ "https://repo1.maven.org/maven2/io/github/alexarchambault/is-terminal/0.1.2/is-terminal-0.1.2.jar" "https://repo1.maven.org/maven2/io/github/alexarchambault/is-terminal/0.1.2/is-terminal-0.1.2.pom" ];
    hash = "sha256-j9aW4Y/zyD4aYu2XykzfEpdGUXideUCkVTFSvtzlH48=";
    installPath = "https/repo1.maven.org/maven2/io/github/alexarchambault/is-terminal/0.1.2";
  };

  "io.github.java-diff-utils_java-diff-utils-4.12" = fetchMaven {
    name = "io.github.java-diff-utils_java-diff-utils-4.12";
    urls = [ "https://repo1.maven.org/maven2/io/github/java-diff-utils/java-diff-utils/4.12/java-diff-utils-4.12.jar" "https://repo1.maven.org/maven2/io/github/java-diff-utils/java-diff-utils/4.12/java-diff-utils-4.12.pom" ];
    hash = "sha256-SMNRfv+BvfxjgwFH0fHU16fd1bDn/QMrPQN8Eyb6deA=";
    installPath = "https/repo1.maven.org/maven2/io/github/java-diff-utils/java-diff-utils/4.12";
  };

  "io.github.java-diff-utils_java-diff-utils-parent-4.12" = fetchMaven {
    name = "io.github.java-diff-utils_java-diff-utils-parent-4.12";
    urls = [ "https://repo1.maven.org/maven2/io/github/java-diff-utils/java-diff-utils-parent/4.12/java-diff-utils-parent-4.12.pom" ];
    hash = "sha256-l9MekOAkDQrHpgMMLkbZQJtiaSmyE7h0XneiHciAFOI=";
    installPath = "https/repo1.maven.org/maven2/io/github/java-diff-utils/java-diff-utils-parent/4.12";
  };

  "org.apache.commons_commons-compress-1.26.2" = fetchMaven {
    name = "org.apache.commons_commons-compress-1.26.2";
    urls = [ "https://repo1.maven.org/maven2/org/apache/commons/commons-compress/1.26.2/commons-compress-1.26.2.jar" "https://repo1.maven.org/maven2/org/apache/commons/commons-compress/1.26.2/commons-compress-1.26.2.pom" ];
    hash = "sha256-5D5lx07bmuJYoxLZUVG2SuSIuqwwWux50VCge+WmwiA=";
    installPath = "https/repo1.maven.org/maven2/org/apache/commons/commons-compress/1.26.2";
  };

  "org.apache.commons_commons-lang3-3.14.0" = fetchMaven {
    name = "org.apache.commons_commons-lang3-3.14.0";
    urls = [ "https://repo1.maven.org/maven2/org/apache/commons/commons-lang3/3.14.0/commons-lang3-3.14.0.jar" "https://repo1.maven.org/maven2/org/apache/commons/commons-lang3/3.14.0/commons-lang3-3.14.0.pom" ];
    hash = "sha256-b5ZfCjrVKvpTFeW1SMtspKLtvI/uZuczaizc6Oj0xsI=";
    installPath = "https/repo1.maven.org/maven2/org/apache/commons/commons-lang3/3.14.0";
  };

  "org.apache.commons_commons-parent-64" = fetchMaven {
    name = "org.apache.commons_commons-parent-64";
    urls = [ "https://repo1.maven.org/maven2/org/apache/commons/commons-parent/64/commons-parent-64.pom" ];
    hash = "sha256-Q6095muAB/pbFjv41RzuqBbVSWMz8zN47Okjv96TqWI=";
    installPath = "https/repo1.maven.org/maven2/org/apache/commons/commons-parent/64";
  };

  "org.apache.commons_commons-parent-69" = fetchMaven {
    name = "org.apache.commons_commons-parent-69";
    urls = [ "https://repo1.maven.org/maven2/org/apache/commons/commons-parent/69/commons-parent-69.pom" ];
    hash = "sha256-XDFSOofSIPQI87JPu4s21bhzz9SDiYXZ4rIoURJ4feI=";
    installPath = "https/repo1.maven.org/maven2/org/apache/commons/commons-parent/69";
  };

  "org.apache.commons_commons-parent-78" = fetchMaven {
    name = "org.apache.commons_commons-parent-78";
    urls = [ "https://repo1.maven.org/maven2/org/apache/commons/commons-parent/78/commons-parent-78.pom" ];
    hash = "sha256-0aJAoMZMen5VZmg8WT/tz9MMHFaXx6DgdiAVpYrCsac=";
    installPath = "https/repo1.maven.org/maven2/org/apache/commons/commons-parent/78";
  };

  "org.apache.cxf_cxf-4.0.6" = fetchMaven {
    name = "org.apache.cxf_cxf-4.0.6";
    urls = [ "https://repo1.maven.org/maven2/org/apache/cxf/cxf/4.0.6/cxf-4.0.6.pom" ];
    hash = "sha256-P/nmU+pQ5HiJp0i3fqQVYypc+1AFeWCdOBGozTZRiSM=";
    installPath = "https/repo1.maven.org/maven2/org/apache/cxf/cxf/4.0.6";
  };

  "org.apache.cxf_cxf-bom-4.0.6" = fetchMaven {
    name = "org.apache.cxf_cxf-bom-4.0.6";
    urls = [ "https://repo1.maven.org/maven2/org/apache/cxf/cxf-bom/4.0.6/cxf-bom-4.0.6.pom" ];
    hash = "sha256-w1H9G+T3S+LWfJ/dVX7JnLwPsi3tGJlFHlde0ZyKVE4=";
    installPath = "https/repo1.maven.org/maven2/org/apache/cxf/cxf-bom/4.0.6";
  };

  "org.apache.groovy_groovy-bom-4.0.22" = fetchMaven {
    name = "org.apache.groovy_groovy-bom-4.0.22";
    urls = [ "https://repo1.maven.org/maven2/org/apache/groovy/groovy-bom/4.0.22/groovy-bom-4.0.22.pom" ];
    hash = "sha256-9hsejVx5kj/oQtf+JvuKqOuzRfJIJbPoys04ArDEu9o=";
    installPath = "https/repo1.maven.org/maven2/org/apache/groovy/groovy-bom/4.0.22";
  };

  "org.apache.logging_logging-parent-11.3.0" = fetchMaven {
    name = "org.apache.logging_logging-parent-11.3.0";
    urls = [ "https://repo1.maven.org/maven2/org/apache/logging/logging-parent/11.3.0/logging-parent-11.3.0.pom" ];
    hash = "sha256-06rPgZ5cRXf8cg84KMl7HVR3vcgvV0ThY76UsgAFf+w=";
    installPath = "https/repo1.maven.org/maven2/org/apache/logging/logging-parent/11.3.0";
  };

  "org.apache.tika_tika-core-3.1.0" = fetchMaven {
    name = "org.apache.tika_tika-core-3.1.0";
    urls = [ "https://repo1.maven.org/maven2/org/apache/tika/tika-core/3.1.0/tika-core-3.1.0.jar" "https://repo1.maven.org/maven2/org/apache/tika/tika-core/3.1.0/tika-core-3.1.0.pom" ];
    hash = "sha256-NnIdgEccFyNqv8HIciO0d8vVAcbEaQ5typuaYi9aUjo=";
    installPath = "https/repo1.maven.org/maven2/org/apache/tika/tika-core/3.1.0";
  };

  "org.apache.tika_tika-parent-3.1.0" = fetchMaven {
    name = "org.apache.tika_tika-parent-3.1.0";
    urls = [ "https://repo1.maven.org/maven2/org/apache/tika/tika-parent/3.1.0/tika-parent-3.1.0.pom" ];
    hash = "sha256-r4SO6kcvuQSLepEsjrJmnGOQ7cyAjpxRVvc4krj6Sh4=";
    installPath = "https/repo1.maven.org/maven2/org/apache/tika/tika-parent/3.1.0";
  };

  "org.apache.xbean_xbean-3.7" = fetchMaven {
    name = "org.apache.xbean_xbean-3.7";
    urls = [ "https://repo1.maven.org/maven2/org/apache/xbean/xbean/3.7/xbean-3.7.pom" ];
    hash = "sha256-7moEcdxl+B1i7xstWBlWabSFr9QLszuciySggKYvpAE=";
    installPath = "https/repo1.maven.org/maven2/org/apache/xbean/xbean/3.7";
  };

  "org.apache.xbean_xbean-reflect-3.7" = fetchMaven {
    name = "org.apache.xbean_xbean-reflect-3.7";
    urls = [ "https://repo1.maven.org/maven2/org/apache/xbean/xbean-reflect/3.7/xbean-reflect-3.7.jar" "https://repo1.maven.org/maven2/org/apache/xbean/xbean-reflect/3.7/xbean-reflect-3.7.pom" ];
    hash = "sha256-Zp97nk/YwipUj92NnhjU5tKNXgUmPWh2zWic2FoS434=";
    installPath = "https/repo1.maven.org/maven2/org/apache/xbean/xbean-reflect/3.7";
  };

  "org.codehaus.plexus_plexus-17" = fetchMaven {
    name = "org.codehaus.plexus_plexus-17";
    urls = [ "https://repo1.maven.org/maven2/org/codehaus/plexus/plexus/17/plexus-17.pom" ];
    hash = "sha256-IeF8wVVWksgiGA2oX3NdIalO+qYNKpGcqY2hVOBKGy4=";
    installPath = "https/repo1.maven.org/maven2/org/codehaus/plexus/plexus/17";
  };

  "org.codehaus.plexus_plexus-18" = fetchMaven {
    name = "org.codehaus.plexus_plexus-18";
    urls = [ "https://repo1.maven.org/maven2/org/codehaus/plexus/plexus/18/plexus-18.pom" ];
    hash = "sha256-MW5t8h+IK6i4Gm58Lz3ucsEXD1GRupWWNKcizh2Osr0=";
    installPath = "https/repo1.maven.org/maven2/org/codehaus/plexus/plexus/18";
  };

  "org.codehaus.plexus_plexus-5.1" = fetchMaven {
    name = "org.codehaus.plexus_plexus-5.1";
    urls = [ "https://repo1.maven.org/maven2/org/codehaus/plexus/plexus/5.1/plexus-5.1.pom" ];
    hash = "sha256-ywTicwjHcL7BzKPO3XzXpc9pE0M0j7Khcop85G3XqDI=";
    installPath = "https/repo1.maven.org/maven2/org/codehaus/plexus/plexus/5.1";
  };

  "org.codehaus.plexus_plexus-6.5" = fetchMaven {
    name = "org.codehaus.plexus_plexus-6.5";
    urls = [ "https://repo1.maven.org/maven2/org/codehaus/plexus/plexus/6.5/plexus-6.5.pom" ];
    hash = "sha256-6Hhmat92ApFn7ze2iYyOusDxXMYp98v1GNqAvKypKSQ=";
    installPath = "https/repo1.maven.org/maven2/org/codehaus/plexus/plexus/6.5";
  };

  "org.codehaus.plexus_plexus-archiver-4.10.0" = fetchMaven {
    name = "org.codehaus.plexus_plexus-archiver-4.10.0";
    urls = [ "https://repo1.maven.org/maven2/org/codehaus/plexus/plexus-archiver/4.10.0/plexus-archiver-4.10.0.jar" "https://repo1.maven.org/maven2/org/codehaus/plexus/plexus-archiver/4.10.0/plexus-archiver-4.10.0.pom" ];
    hash = "sha256-pp9ZIBwMabdHgJHVXZ4eHUFTXevlLlGjMV8Cr9jdz5E=";
    installPath = "https/repo1.maven.org/maven2/org/codehaus/plexus/plexus-archiver/4.10.0";
  };

  "org.codehaus.plexus_plexus-classworlds-2.6.0" = fetchMaven {
    name = "org.codehaus.plexus_plexus-classworlds-2.6.0";
    urls = [ "https://repo1.maven.org/maven2/org/codehaus/plexus/plexus-classworlds/2.6.0/plexus-classworlds-2.6.0.jar" "https://repo1.maven.org/maven2/org/codehaus/plexus/plexus-classworlds/2.6.0/plexus-classworlds-2.6.0.pom" ];
    hash = "sha256-vh7/TKxdcZVxXljM5MLGppoP0Bc28QyI/WsrPc6XSEA=";
    installPath = "https/repo1.maven.org/maven2/org/codehaus/plexus/plexus-classworlds/2.6.0";
  };

  "org.codehaus.plexus_plexus-container-default-2.1.1" = fetchMaven {
    name = "org.codehaus.plexus_plexus-container-default-2.1.1";
    urls = [ "https://repo1.maven.org/maven2/org/codehaus/plexus/plexus-container-default/2.1.1/plexus-container-default-2.1.1.jar" "https://repo1.maven.org/maven2/org/codehaus/plexus/plexus-container-default/2.1.1/plexus-container-default-2.1.1.pom" ];
    hash = "sha256-E0Dt5DQRVlxg8fddMJZpvhU5cfNwB9MJTi/GJ1PVt3A=";
    installPath = "https/repo1.maven.org/maven2/org/codehaus/plexus/plexus-container-default/2.1.1";
  };

  "org.codehaus.plexus_plexus-containers-2.1.1" = fetchMaven {
    name = "org.codehaus.plexus_plexus-containers-2.1.1";
    urls = [ "https://repo1.maven.org/maven2/org/codehaus/plexus/plexus-containers/2.1.1/plexus-containers-2.1.1.pom" ];
    hash = "sha256-LR5FBjo4qAjwjKpHajTnuUBN7cLKbeTJRtYYc8q4FNw=";
    installPath = "https/repo1.maven.org/maven2/org/codehaus/plexus/plexus-containers/2.1.1";
  };

  "org.codehaus.plexus_plexus-io-3.5.0" = fetchMaven {
    name = "org.codehaus.plexus_plexus-io-3.5.0";
    urls = [ "https://repo1.maven.org/maven2/org/codehaus/plexus/plexus-io/3.5.0/plexus-io-3.5.0.jar" "https://repo1.maven.org/maven2/org/codehaus/plexus/plexus-io/3.5.0/plexus-io-3.5.0.pom" ];
    hash = "sha256-GrKvyvvG9jqNcHXTOaBd+QWRUZCWORyrgu+jbgJbWpg=";
    installPath = "https/repo1.maven.org/maven2/org/codehaus/plexus/plexus-io/3.5.0";
  };

  "org.codehaus.plexus_plexus-utils-4.0.1" = fetchMaven {
    name = "org.codehaus.plexus_plexus-utils-4.0.1";
    urls = [ "https://repo1.maven.org/maven2/org/codehaus/plexus/plexus-utils/4.0.1/plexus-utils-4.0.1.jar" "https://repo1.maven.org/maven2/org/codehaus/plexus/plexus-utils/4.0.1/plexus-utils-4.0.1.pom" ];
    hash = "sha256-bMqrl8EEfcmwl4D8hK7iaYROM0j9/RVdEyns9BbWgPM=";
    installPath = "https/repo1.maven.org/maven2/org/codehaus/plexus/plexus-utils/4.0.1";
  };

  "org.eclipse.ee4j_project-1.0.7" = fetchMaven {
    name = "org.eclipse.ee4j_project-1.0.7";
    urls = [ "https://repo1.maven.org/maven2/org/eclipse/ee4j/project/1.0.7/project-1.0.7.pom" ];
    hash = "sha256-1HxZiJ0aeo1n8AWjwGKEoPwVFP9kndMBye7xwgYEal8=";
    installPath = "https/repo1.maven.org/maven2/org/eclipse/ee4j/project/1.0.7";
  };

  "org.eclipse.jetty_jetty-bom-11.0.24" = fetchMaven {
    name = "org.eclipse.jetty_jetty-bom-11.0.24";
    urls = [ "https://repo1.maven.org/maven2/org/eclipse/jetty/jetty-bom/11.0.24/jetty-bom-11.0.24.pom" ];
    hash = "sha256-U5/npTQQwHE+dvi08aq1ZK4s42xgilyPsqXYWrPvdEM=";
    installPath = "https/repo1.maven.org/maven2/org/eclipse/jetty/jetty-bom/11.0.24";
  };

  "org.fusesource.jansi_jansi-2.4.1" = fetchMaven {
    name = "org.fusesource.jansi_jansi-2.4.1";
    urls = [ "https://repo1.maven.org/maven2/org/fusesource/jansi/jansi/2.4.1/jansi-2.4.1.jar" "https://repo1.maven.org/maven2/org/fusesource/jansi/jansi/2.4.1/jansi-2.4.1.pom" ];
    hash = "sha256-M9G+H9TA5eB6NwlBmDP0ghxZzjbvLimPXNRZHyxJXac=";
    installPath = "https/repo1.maven.org/maven2/org/fusesource/jansi/jansi/2.4.1";
  };

  "org.nibor.autolink_autolink-0.6.0" = fetchMaven {
    name = "org.nibor.autolink_autolink-0.6.0";
    urls = [ "https://repo1.maven.org/maven2/org/nibor/autolink/autolink/0.6.0/autolink-0.6.0.jar" "https://repo1.maven.org/maven2/org/nibor/autolink/autolink/0.6.0/autolink-0.6.0.pom" ];
    hash = "sha256-UyOje39E9ysUXMK3ey2jrm7S6e8EVQboYC46t+B6sdo=";
    installPath = "https/repo1.maven.org/maven2/org/nibor/autolink/autolink/0.6.0";
  };

  "org.scala-lang.modules_scala-asm-9.5.0-scala-1" = fetchMaven {
    name = "org.scala-lang.modules_scala-asm-9.5.0-scala-1";
    urls = [ "https://repo1.maven.org/maven2/org/scala-lang/modules/scala-asm/9.5.0-scala-1/scala-asm-9.5.0-scala-1.jar" "https://repo1.maven.org/maven2/org/scala-lang/modules/scala-asm/9.5.0-scala-1/scala-asm-9.5.0-scala-1.pom" ];
    hash = "sha256-5HggTWGWJaioO240uFk7mSFpKhRSff9DZHjJj0HKuhI=";
    installPath = "https/repo1.maven.org/maven2/org/scala-lang/modules/scala-asm/9.5.0-scala-1";
  };

  "org.scala-lang.modules_scala-collection-compat_2.13-2.12.0" = fetchMaven {
    name = "org.scala-lang.modules_scala-collection-compat_2.13-2.12.0";
    urls = [ "https://repo1.maven.org/maven2/org/scala-lang/modules/scala-collection-compat_2.13/2.12.0/scala-collection-compat_2.13-2.12.0.jar" "https://repo1.maven.org/maven2/org/scala-lang/modules/scala-collection-compat_2.13/2.12.0/scala-collection-compat_2.13-2.12.0.pom" ];
    hash = "sha256-gdUFn7dadEj342MYKz1lj4dLYz+AkOzRiIC0spS8CXk=";
    installPath = "https/repo1.maven.org/maven2/org/scala-lang/modules/scala-collection-compat_2.13/2.12.0";
  };

  "org.scala-lang.modules_scala-collection-compat_2.13-2.13.0" = fetchMaven {
    name = "org.scala-lang.modules_scala-collection-compat_2.13-2.13.0";
    urls = [ "https://repo1.maven.org/maven2/org/scala-lang/modules/scala-collection-compat_2.13/2.13.0/scala-collection-compat_2.13-2.13.0.jar" "https://repo1.maven.org/maven2/org/scala-lang/modules/scala-collection-compat_2.13/2.13.0/scala-collection-compat_2.13-2.13.0.pom" ];
    hash = "sha256-aQ+I3JuE8U5GIdb4SlHbZWdPu4E/qRIoZSGMMP3g5GE=";
    installPath = "https/repo1.maven.org/maven2/org/scala-lang/modules/scala-collection-compat_2.13/2.13.0";
  };

  "org.scala-lang.modules_scala-collection-compat_3-2.8.1" = fetchMaven {
    name = "org.scala-lang.modules_scala-collection-compat_3-2.8.1";
    urls = [ "https://repo1.maven.org/maven2/org/scala-lang/modules/scala-collection-compat_3/2.8.1/scala-collection-compat_3-2.8.1.jar" "https://repo1.maven.org/maven2/org/scala-lang/modules/scala-collection-compat_3/2.8.1/scala-collection-compat_3-2.8.1.pom" ];
    hash = "sha256-kxNr6boD/fQ2D+Xfc0X5bcpyWVJYmqVQV2ynT7NCwRY=";
    installPath = "https/repo1.maven.org/maven2/org/scala-lang/modules/scala-collection-compat_3/2.8.1";
  };

  "org.scala-lang.modules_scala-parallel-collections_2.13-0.2.0" = fetchMaven {
    name = "org.scala-lang.modules_scala-parallel-collections_2.13-0.2.0";
    urls = [ "https://repo1.maven.org/maven2/org/scala-lang/modules/scala-parallel-collections_2.13/0.2.0/scala-parallel-collections_2.13-0.2.0.jar" "https://repo1.maven.org/maven2/org/scala-lang/modules/scala-parallel-collections_2.13/0.2.0/scala-parallel-collections_2.13-0.2.0.pom" ];
    hash = "sha256-chqRhtzyMJjeR4ohA5YhNjGV8kLHTy5yZjNCyYIO/wo=";
    installPath = "https/repo1.maven.org/maven2/org/scala-lang/modules/scala-parallel-collections_2.13/0.2.0";
  };

  "org.scala-lang.modules_scala-parser-combinators_2.13-1.1.2" = fetchMaven {
    name = "org.scala-lang.modules_scala-parser-combinators_2.13-1.1.2";
    urls = [ "https://repo1.maven.org/maven2/org/scala-lang/modules/scala-parser-combinators_2.13/1.1.2/scala-parser-combinators_2.13-1.1.2.jar" "https://repo1.maven.org/maven2/org/scala-lang/modules/scala-parser-combinators_2.13/1.1.2/scala-parser-combinators_2.13-1.1.2.pom" ];
    hash = "sha256-sM5GWZ8/K1Jchj4V3FTvaWhfSJiHq0PKtQpd5W94Hps=";
    installPath = "https/repo1.maven.org/maven2/org/scala-lang/modules/scala-parser-combinators_2.13/1.1.2";
  };

  "org.scala-lang.modules_scala-xml_2.13-2.3.0" = fetchMaven {
    name = "org.scala-lang.modules_scala-xml_2.13-2.3.0";
    urls = [ "https://repo1.maven.org/maven2/org/scala-lang/modules/scala-xml_2.13/2.3.0/scala-xml_2.13-2.3.0.jar" "https://repo1.maven.org/maven2/org/scala-lang/modules/scala-xml_2.13/2.3.0/scala-xml_2.13-2.3.0.pom" ];
    hash = "sha256-TZaDZ9UjQB20IMvxqxub63LbqSNDMAhFDRtYfvbzI58=";
    installPath = "https/repo1.maven.org/maven2/org/scala-lang/modules/scala-xml_2.13/2.3.0";
  };

  "org.scala-sbt.jline_jline-2.14.7-sbt-9a88bc413e2b34a4580c001c654d1a7f4f65bf18" = fetchMaven {
    name = "org.scala-sbt.jline_jline-2.14.7-sbt-9a88bc413e2b34a4580c001c654d1a7f4f65bf18";
    urls = [ "https://repo1.maven.org/maven2/org/scala-sbt/jline/jline/2.14.7-sbt-9a88bc413e2b34a4580c001c654d1a7f4f65bf18/jline-2.14.7-sbt-9a88bc413e2b34a4580c001c654d1a7f4f65bf18.jar" "https://repo1.maven.org/maven2/org/scala-sbt/jline/jline/2.14.7-sbt-9a88bc413e2b34a4580c001c654d1a7f4f65bf18/jline-2.14.7-sbt-9a88bc413e2b34a4580c001c654d1a7f4f65bf18.pom" ];
    hash = "sha256-1Nq7/UMXSlaZ7iwR1WMryltAmS8/fRCK6u93cm+1uh4=";
    installPath = "https/repo1.maven.org/maven2/org/scala-sbt/jline/jline/2.14.7-sbt-9a88bc413e2b34a4580c001c654d1a7f4f65bf18";
  };

  "org.sonatype.oss_oss-parent-7" = fetchMaven {
    name = "org.sonatype.oss_oss-parent-7";
    urls = [ "https://repo1.maven.org/maven2/org/sonatype/oss/oss-parent/7/oss-parent-7.pom" ];
    hash = "sha256-HDM4YUA2cNuWnhH7wHWZfxzLMdIr2AT36B3zuJFrXbE=";
    installPath = "https/repo1.maven.org/maven2/org/sonatype/oss/oss-parent/7";
  };

  "org.sonatype.oss_oss-parent-9" = fetchMaven {
    name = "org.sonatype.oss_oss-parent-9";
    urls = [ "https://repo1.maven.org/maven2/org/sonatype/oss/oss-parent/9/oss-parent-9.pom" ];
    hash = "sha256-kJ3QfnDTAvamYaHQowpAKW1gPDFDXbiP2lNPzNllIWY=";
    installPath = "https/repo1.maven.org/maven2/org/sonatype/oss/oss-parent/9";
  };

  "org.virtuslab.scala-cli_config_2.13-1.1.3" = fetchMaven {
    name = "org.virtuslab.scala-cli_config_2.13-1.1.3";
    urls = [ "https://repo1.maven.org/maven2/org/virtuslab/scala-cli/config_2.13/1.1.3/config_2.13-1.1.3.jar" "https://repo1.maven.org/maven2/org/virtuslab/scala-cli/config_2.13/1.1.3/config_2.13-1.1.3.pom" ];
    hash = "sha256-VEMBbFMIYxb4azu232W7xSXXnYk6P7eKOKbA7ZgnTTA=";
    installPath = "https/repo1.maven.org/maven2/org/virtuslab/scala-cli/config_2.13/1.1.3";
  };

  "org.virtuslab.scala-cli_specification-level_2.13-1.1.3" = fetchMaven {
    name = "org.virtuslab.scala-cli_specification-level_2.13-1.1.3";
    urls = [ "https://repo1.maven.org/maven2/org/virtuslab/scala-cli/specification-level_2.13/1.1.3/specification-level_2.13-1.1.3.jar" "https://repo1.maven.org/maven2/org/virtuslab/scala-cli/specification-level_2.13/1.1.3/specification-level_2.13-1.1.3.pom" ];
    hash = "sha256-G/6ffz3UFp2Bj/SV9NLIrrq8nzawFZ7qwemXIx+dn8k=";
    installPath = "https/repo1.maven.org/maven2/org/virtuslab/scala-cli/specification-level_2.13/1.1.3";
  };

  "ua.co.k_strftime4j-1.0.5" = fetchMaven {
    name = "ua.co.k_strftime4j-1.0.5";
    urls = [ "https://repo1.maven.org/maven2/ua/co/k/strftime4j/1.0.5/strftime4j-1.0.5.jar" "https://repo1.maven.org/maven2/ua/co/k/strftime4j/1.0.5/strftime4j-1.0.5.pom" ];
    hash = "sha256-Wrg3ftbV/dCtAhULZcti/FJ2XVbpqd9fM4Z6A/fOwAo=";
    installPath = "https/repo1.maven.org/maven2/ua/co/k/strftime4j/1.0.5";
  };

  "com.fasterxml.jackson.core_jackson-annotations-2.12.1" = fetchMaven {
    name = "com.fasterxml.jackson.core_jackson-annotations-2.12.1";
    urls = [ "https://repo1.maven.org/maven2/com/fasterxml/jackson/core/jackson-annotations/2.12.1/jackson-annotations-2.12.1.pom" ];
    hash = "sha256-anUbI5JS/lVsxPul1sdmtNFsJbiyHvyz9au/cBV0L6w=";
    installPath = "https/repo1.maven.org/maven2/com/fasterxml/jackson/core/jackson-annotations/2.12.1";
  };

  "com.fasterxml.jackson.core_jackson-annotations-2.15.1" = fetchMaven {
    name = "com.fasterxml.jackson.core_jackson-annotations-2.15.1";
    urls = [ "https://repo1.maven.org/maven2/com/fasterxml/jackson/core/jackson-annotations/2.15.1/jackson-annotations-2.15.1.jar" "https://repo1.maven.org/maven2/com/fasterxml/jackson/core/jackson-annotations/2.15.1/jackson-annotations-2.15.1.pom" ];
    hash = "sha256-hwI7CChHkZif7MNeHDjPf6OuNcncc9i7zIET6JUiSY8=";
    installPath = "https/repo1.maven.org/maven2/com/fasterxml/jackson/core/jackson-annotations/2.15.1";
  };

  "com.fasterxml.jackson.core_jackson-core-2.15.1" = fetchMaven {
    name = "com.fasterxml.jackson.core_jackson-core-2.15.1";
    urls = [ "https://repo1.maven.org/maven2/com/fasterxml/jackson/core/jackson-core/2.15.1/jackson-core-2.15.1.jar" "https://repo1.maven.org/maven2/com/fasterxml/jackson/core/jackson-core/2.15.1/jackson-core-2.15.1.pom" ];
    hash = "sha256-07N9Rg8OKF7hTLa+0AoF1hImT3acHpQBIJhHBnLUSOs=";
    installPath = "https/repo1.maven.org/maven2/com/fasterxml/jackson/core/jackson-core/2.15.1";
  };

  "com.fasterxml.jackson.core_jackson-databind-2.15.1" = fetchMaven {
    name = "com.fasterxml.jackson.core_jackson-databind-2.15.1";
    urls = [ "https://repo1.maven.org/maven2/com/fasterxml/jackson/core/jackson-databind/2.15.1/jackson-databind-2.15.1.jar" "https://repo1.maven.org/maven2/com/fasterxml/jackson/core/jackson-databind/2.15.1/jackson-databind-2.15.1.pom" ];
    hash = "sha256-t8Sge4HbKg8XsqNgW69/3G3RKgK09MSCsPH7XYtsrew=";
    installPath = "https/repo1.maven.org/maven2/com/fasterxml/jackson/core/jackson-databind/2.15.1";
  };

  "com.fasterxml.jackson.dataformat_jackson-dataformat-yaml-2.15.1" = fetchMaven {
    name = "com.fasterxml.jackson.dataformat_jackson-dataformat-yaml-2.15.1";
    urls = [ "https://repo1.maven.org/maven2/com/fasterxml/jackson/dataformat/jackson-dataformat-yaml/2.15.1/jackson-dataformat-yaml-2.15.1.jar" "https://repo1.maven.org/maven2/com/fasterxml/jackson/dataformat/jackson-dataformat-yaml/2.15.1/jackson-dataformat-yaml-2.15.1.pom" ];
    hash = "sha256-gSpEZqpCXmFGg86xQeOlNRNdyBmiM/rN2kCTGhjhHt4=";
    installPath = "https/repo1.maven.org/maven2/com/fasterxml/jackson/dataformat/jackson-dataformat-yaml/2.15.1";
  };

  "com.fasterxml.jackson.dataformat_jackson-dataformats-text-2.15.1" = fetchMaven {
    name = "com.fasterxml.jackson.dataformat_jackson-dataformats-text-2.15.1";
    urls = [ "https://repo1.maven.org/maven2/com/fasterxml/jackson/dataformat/jackson-dataformats-text/2.15.1/jackson-dataformats-text-2.15.1.pom" ];
    hash = "sha256-1RiIP6cIRZoOMBV2+vmJJOYXMarqg+4l7XQ8S7OvAvg=";
    installPath = "https/repo1.maven.org/maven2/com/fasterxml/jackson/dataformat/jackson-dataformats-text/2.15.1";
  };

  "com.fasterxml.jackson.datatype_jackson-datatype-jsr310-2.12.1" = fetchMaven {
    name = "com.fasterxml.jackson.datatype_jackson-datatype-jsr310-2.12.1";
    urls = [ "https://repo1.maven.org/maven2/com/fasterxml/jackson/datatype/jackson-datatype-jsr310/2.12.1/jackson-datatype-jsr310-2.12.1.jar" "https://repo1.maven.org/maven2/com/fasterxml/jackson/datatype/jackson-datatype-jsr310/2.12.1/jackson-datatype-jsr310-2.12.1.pom" ];
    hash = "sha256-YH7YMZY1aeamRA6aVvF2JG3C1YLZhvaMpVCegAfdhFU=";
    installPath = "https/repo1.maven.org/maven2/com/fasterxml/jackson/datatype/jackson-datatype-jsr310/2.12.1";
  };

  "com.fasterxml.jackson.module_jackson-modules-java8-2.12.1" = fetchMaven {
    name = "com.fasterxml.jackson.module_jackson-modules-java8-2.12.1";
    urls = [ "https://repo1.maven.org/maven2/com/fasterxml/jackson/module/jackson-modules-java8/2.12.1/jackson-modules-java8-2.12.1.pom" ];
    hash = "sha256-x5YmdPGcWOpCompDhApY6o5VZ+IUVHTbeday5HVW/NQ=";
    installPath = "https/repo1.maven.org/maven2/com/fasterxml/jackson/module/jackson-modules-java8/2.12.1";
  };

  "com.github.plokhotnyuk.jsoniter-scala_jsoniter-scala-core_2.13-2.13.5" = fetchMaven {
    name = "com.github.plokhotnyuk.jsoniter-scala_jsoniter-scala-core_2.13-2.13.5";
    urls = [ "https://repo1.maven.org/maven2/com/github/plokhotnyuk/jsoniter-scala/jsoniter-scala-core_2.13/2.13.5/jsoniter-scala-core_2.13-2.13.5.pom" ];
    hash = "sha256-EtWOnWyOgOJsLq2hjHgCG/2lc4NfCFIWtjyzBsPTBGs=";
    installPath = "https/repo1.maven.org/maven2/com/github/plokhotnyuk/jsoniter-scala/jsoniter-scala-core_2.13/2.13.5";
  };

  "com.github.plokhotnyuk.jsoniter-scala_jsoniter-scala-core_2.13-2.13.5.2" = fetchMaven {
    name = "com.github.plokhotnyuk.jsoniter-scala_jsoniter-scala-core_2.13-2.13.5.2";
    urls = [ "https://repo1.maven.org/maven2/com/github/plokhotnyuk/jsoniter-scala/jsoniter-scala-core_2.13/2.13.5.2/jsoniter-scala-core_2.13-2.13.5.2.jar" "https://repo1.maven.org/maven2/com/github/plokhotnyuk/jsoniter-scala/jsoniter-scala-core_2.13/2.13.5.2/jsoniter-scala-core_2.13-2.13.5.2.pom" ];
    hash = "sha256-XEP6s9Yt6W4PRIC7jIUkDYZ5htlM1ndxEsF6UQPSUwM=";
    installPath = "https/repo1.maven.org/maven2/com/github/plokhotnyuk/jsoniter-scala/jsoniter-scala-core_2.13/2.13.5.2";
  };

  "io.github.alexarchambault.windows-ansi_windows-ansi-0.0.6" = fetchMaven {
    name = "io.github.alexarchambault.windows-ansi_windows-ansi-0.0.6";
    urls = [ "https://repo1.maven.org/maven2/io/github/alexarchambault/windows-ansi/windows-ansi/0.0.6/windows-ansi-0.0.6.jar" "https://repo1.maven.org/maven2/io/github/alexarchambault/windows-ansi/windows-ansi/0.0.6/windows-ansi-0.0.6.pom" ];
    hash = "sha256-TGUrDCPYFiXV5b2If3u4KviH3JxZttMOKL1HUHqIWRo=";
    installPath = "https/repo1.maven.org/maven2/io/github/alexarchambault/windows-ansi/windows-ansi/0.0.6";
  };

  "net.java.dev.jna_jna-5.14.0" = fetchMaven {
    name = "net.java.dev.jna_jna-5.14.0";
    urls = [ "https://repo1.maven.org/maven2/net/java/dev/jna/jna/5.14.0/jna-5.14.0.jar" "https://repo1.maven.org/maven2/net/java/dev/jna/jna/5.14.0/jna-5.14.0.pom" ];
    hash = "sha256-mvzJykzd4Cz473vRi15E0NReFk7YN7hPOtS5ZHUhCIg=";
    installPath = "https/repo1.maven.org/maven2/net/java/dev/jna/jna/5.14.0";
  };

  "net.java.dev.jna_jna-5.3.1" = fetchMaven {
    name = "net.java.dev.jna_jna-5.3.1";
    urls = [ "https://repo1.maven.org/maven2/net/java/dev/jna/jna/5.3.1/jna-5.3.1.jar" "https://repo1.maven.org/maven2/net/java/dev/jna/jna/5.3.1/jna-5.3.1.pom" ];
    hash = "sha256-8K89u5fF/HyXdqWLLYrrRfgqZq8GQdNP+ta83vBQwUA=";
    installPath = "https/repo1.maven.org/maven2/net/java/dev/jna/jna/5.3.1";
  };

  "org.apache.geronimo.genesis_genesis-2.0" = fetchMaven {
    name = "org.apache.geronimo.genesis_genesis-2.0";
    urls = [ "https://repo1.maven.org/maven2/org/apache/geronimo/genesis/genesis/2.0/genesis-2.0.pom" ];
    hash = "sha256-lcX5R64+07kRLqpdfkay87hJI6ykVn/wUXs142Elips=";
    installPath = "https/repo1.maven.org/maven2/org/apache/geronimo/genesis/genesis/2.0";
  };

  "org.apache.geronimo.genesis_genesis-default-flava-2.0" = fetchMaven {
    name = "org.apache.geronimo.genesis_genesis-default-flava-2.0";
    urls = [ "https://repo1.maven.org/maven2/org/apache/geronimo/genesis/genesis-default-flava/2.0/genesis-default-flava-2.0.pom" ];
    hash = "sha256-jkGo9ePZSnxqcIOQIuAz1ZTPNjjx2vc01oxtt6EJuUk=";
    installPath = "https/repo1.maven.org/maven2/org/apache/geronimo/genesis/genesis-default-flava/2.0";
  };

  "org.apache.geronimo.genesis_genesis-java5-flava-2.0" = fetchMaven {
    name = "org.apache.geronimo.genesis_genesis-java5-flava-2.0";
    urls = [ "https://repo1.maven.org/maven2/org/apache/geronimo/genesis/genesis-java5-flava/2.0/genesis-java5-flava-2.0.pom" ];
    hash = "sha256-CTKaQ0fTVeVBnQrWm4TCcbTONXm/N6bPXPGXx0hToLQ=";
    installPath = "https/repo1.maven.org/maven2/org/apache/geronimo/genesis/genesis-java5-flava/2.0";
  };

  "org.apache.logging.log4j_log4j-2.24.3" = fetchMaven {
    name = "org.apache.logging.log4j_log4j-2.24.3";
    urls = [ "https://repo1.maven.org/maven2/org/apache/logging/log4j/log4j/2.24.3/log4j-2.24.3.pom" ];
    hash = "sha256-bWuk6kxsiWW675JezWblZ8RdkKFg9C/3CgzdMGJr1Z8=";
    installPath = "https/repo1.maven.org/maven2/org/apache/logging/log4j/log4j/2.24.3";
  };

  "org.apache.logging.log4j_log4j-api-2.24.3" = fetchMaven {
    name = "org.apache.logging.log4j_log4j-api-2.24.3";
    urls = [ "https://repo1.maven.org/maven2/org/apache/logging/log4j/log4j-api/2.24.3/log4j-api-2.24.3.jar" "https://repo1.maven.org/maven2/org/apache/logging/log4j/log4j-api/2.24.3/log4j-api-2.24.3.pom" ];
    hash = "sha256-y6wgpqMFwL3B3CrUbTI4HQTBjc4YSWxn0WF8QQSjpFw=";
    installPath = "https/repo1.maven.org/maven2/org/apache/logging/log4j/log4j-api/2.24.3";
  };

  "org.apache.logging.log4j_log4j-bom-2.24.3" = fetchMaven {
    name = "org.apache.logging.log4j_log4j-bom-2.24.3";
    urls = [ "https://repo1.maven.org/maven2/org/apache/logging/log4j/log4j-bom/2.24.3/log4j-bom-2.24.3.pom" ];
    hash = "sha256-UNEo/UyoskA/8X62/rwMQObDQxfHDiJKj2pBP9SNoek=";
    installPath = "https/repo1.maven.org/maven2/org/apache/logging/log4j/log4j-bom/2.24.3";
  };

  "org.apache.logging.log4j_log4j-core-2.24.3" = fetchMaven {
    name = "org.apache.logging.log4j_log4j-core-2.24.3";
    urls = [ "https://repo1.maven.org/maven2/org/apache/logging/log4j/log4j-core/2.24.3/log4j-core-2.24.3.jar" "https://repo1.maven.org/maven2/org/apache/logging/log4j/log4j-core/2.24.3/log4j-core-2.24.3.pom" ];
    hash = "sha256-kRXpkDJtXT0VoEyxj5hIc8Z8foh8rKnFqCpjohdh5LQ=";
    installPath = "https/repo1.maven.org/maven2/org/apache/logging/log4j/log4j-core/2.24.3";
  };

}
# Project Source Hash:sha256-yEO++GkZkApktJB0rJXxXpPUuJjdK+1Qov076HlDiY0=
