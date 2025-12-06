{ fetchurl }:
let
  fetchMaven =
    {
      name,
      urls,
      hash,
      installPath,
    }:
    with builtins;
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
      ''
      + concatStringsSep "\n" (
        map (
          elem:
          let
            filename = baseNameOf elem;
          in
          ''
            downloadedFile=$TMPDIR/${filename}
            tryDownload ${elem} "$downloadedFile"
            cp -v "$TMPDIR/${filename}" "$out/"
          ''
        ) otherUrls
      );
    };
in
{

  "commons-codec_commons-codec-1.16.0" = fetchMaven {
    name = "commons-codec_commons-codec-1.16.0";
    urls = [
      "https://repo1.maven.org/maven2/commons-codec/commons-codec/1.16.0/commons-codec-1.16.0.pom"
    ];
    hash = "sha256-dz7cPQ5/IxpGUHebpte7k4K5zo8Rz81DhG0gjZxjxaU=";
    installPath = "https/repo1.maven.org/maven2/commons-codec/commons-codec/1.16.0";
  };

  "commons-codec_commons-codec-1.17.0" = fetchMaven {
    name = "commons-codec_commons-codec-1.17.0";
    urls = [
      "https://repo1.maven.org/maven2/commons-codec/commons-codec/1.17.0/commons-codec-1.17.0.pom"
    ];
    hash = "sha256-rnHRsuLtYGmqFrUPwN5RSu5fuROBWI2N4SO7dWSZANA=";
    installPath = "https/repo1.maven.org/maven2/commons-codec/commons-codec/1.17.0";
  };

  "commons-codec_commons-codec-1.19.0" = fetchMaven {
    name = "commons-codec_commons-codec-1.19.0";
    urls = [
      "https://repo1.maven.org/maven2/commons-codec/commons-codec/1.19.0/commons-codec-1.19.0.jar"
      "https://repo1.maven.org/maven2/commons-codec/commons-codec/1.19.0/commons-codec-1.19.0.pom"
    ];
    hash = "sha256-Tctia3qzKymGgRNoH+mVSjTp3wPVbX8HIevxQz6Qz5g=";
    installPath = "https/repo1.maven.org/maven2/commons-codec/commons-codec/1.19.0";
  };

  "commons-io_commons-io-2.20.0" = fetchMaven {
    name = "commons-io_commons-io-2.20.0";
    urls = [
      "https://repo1.maven.org/maven2/commons-io/commons-io/2.20.0/commons-io-2.20.0.jar"
      "https://repo1.maven.org/maven2/commons-io/commons-io/2.20.0/commons-io-2.20.0.pom"
    ];
    hash = "sha256-o8178vHHyaONu9k/K67WJbEFC0n1G5lis2rMCZfXpS4=";
    installPath = "https/repo1.maven.org/maven2/commons-io/commons-io/2.20.0";
  };

  "commons-logging_commons-logging-1.2" = fetchMaven {
    name = "commons-logging_commons-logging-1.2";
    urls = [
      "https://repo1.maven.org/maven2/commons-logging/commons-logging/1.2/commons-logging-1.2.jar"
      "https://repo1.maven.org/maven2/commons-logging/commons-logging/1.2/commons-logging-1.2.pom"
    ];
    hash = "sha256-IV6PwglWdPf+kCvnR75xDQBzCdOycCc5KxHMU0xcPRs=";
    installPath = "https/repo1.maven.org/maven2/commons-logging/commons-logging/1.2";
  };

  "co.fs2_fs2-core_3-3.9.3" = fetchMaven {
    name = "co.fs2_fs2-core_3-3.9.3";
    urls = [
      "https://repo1.maven.org/maven2/co/fs2/fs2-core_3/3.9.3/fs2-core_3-3.9.3.jar"
      "https://repo1.maven.org/maven2/co/fs2/fs2-core_3/3.9.3/fs2-core_3-3.9.3.pom"
    ];
    hash = "sha256-FLkjGWBOt2Owjobadr0IZ5m/E4s0wWdF5fbILtLVvlc=";
    installPath = "https/repo1.maven.org/maven2/co/fs2/fs2-core_3/3.9.3";
  };

  "co.fs2_fs2-io_3-3.9.3" = fetchMaven {
    name = "co.fs2_fs2-io_3-3.9.3";
    urls = [
      "https://repo1.maven.org/maven2/co/fs2/fs2-io_3/3.9.3/fs2-io_3-3.9.3.jar"
      "https://repo1.maven.org/maven2/co/fs2/fs2-io_3/3.9.3/fs2-io_3-3.9.3.pom"
    ];
    hash = "sha256-uA1w/q35nRWOBSfK4cKVccclc+i0TY1nWpRHYMi9cbc=";
    installPath = "https/repo1.maven.org/maven2/co/fs2/fs2-io_3/3.9.3";
  };

  "com.47deg_github4s_3-0.33.3" = fetchMaven {
    name = "com.47deg_github4s_3-0.33.3";
    urls = [
      "https://repo1.maven.org/maven2/com/47deg/github4s_3/0.33.3/github4s_3-0.33.3.jar"
      "https://repo1.maven.org/maven2/com/47deg/github4s_3/0.33.3/github4s_3-0.33.3.pom"
    ];
    hash = "sha256-J9y9gMhneFZDKy1pKONBBhrlSKzjzFys4l7+gSLUY8Q=";
    installPath = "https/repo1.maven.org/maven2/com/47deg/github4s_3/0.33.3";
  };

  "com.amazonaws_aws-java-sdk-bom-1.12.788" = fetchMaven {
    name = "com.amazonaws_aws-java-sdk-bom-1.12.788";
    urls = [
      "https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-bom/1.12.788/aws-java-sdk-bom-1.12.788.pom"
    ];
    hash = "sha256-RTIQEyfv5/iQC7CO4EAfeH14UyUCVpaei+0kMOKJcfU=";
    installPath = "https/repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-bom/1.12.788";
  };

  "com.amazonaws_aws-java-sdk-pom-1.12.788" = fetchMaven {
    name = "com.amazonaws_aws-java-sdk-pom-1.12.788";
    urls = [
      "https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-pom/1.12.788/aws-java-sdk-pom-1.12.788.pom"
    ];
    hash = "sha256-oTHTjzg4VJeXJ35+CNY3HcXqw79KQiDQCiI5Rk1KWSk=";
    installPath = "https/repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-pom/1.12.788";
  };

  "com.comcast_ip4s-core_3-3.4.0" = fetchMaven {
    name = "com.comcast_ip4s-core_3-3.4.0";
    urls = [
      "https://repo1.maven.org/maven2/com/comcast/ip4s-core_3/3.4.0/ip4s-core_3-3.4.0.jar"
      "https://repo1.maven.org/maven2/com/comcast/ip4s-core_3/3.4.0/ip4s-core_3-3.4.0.pom"
    ];
    hash = "sha256-v9mtoLI71zYVPDy/MmRCTPeSGKxFtqUlUsoLlv3wQTk=";
    installPath = "https/repo1.maven.org/maven2/com/comcast/ip4s-core_3/3.4.0";
  };

  "com.eed3si9n_shaded-jawn-parser_2.13-1.3.2" = fetchMaven {
    name = "com.eed3si9n_shaded-jawn-parser_2.13-1.3.2";
    urls = [
      "https://repo1.maven.org/maven2/com/eed3si9n/shaded-jawn-parser_2.13/1.3.2/shaded-jawn-parser_2.13-1.3.2.jar"
      "https://repo1.maven.org/maven2/com/eed3si9n/shaded-jawn-parser_2.13/1.3.2/shaded-jawn-parser_2.13-1.3.2.pom"
    ];
    hash = "sha256-k0UsS5J5CXho/H4FngEcxAkNJ2ZjpecqDmKBvxIMuBs=";
    installPath = "https/repo1.maven.org/maven2/com/eed3si9n/shaded-jawn-parser_2.13/1.3.2";
  };

  "com.eed3si9n_shaded-scalajson_2.13-1.0.0-M4" = fetchMaven {
    name = "com.eed3si9n_shaded-scalajson_2.13-1.0.0-M4";
    urls = [
      "https://repo1.maven.org/maven2/com/eed3si9n/shaded-scalajson_2.13/1.0.0-M4/shaded-scalajson_2.13-1.0.0-M4.jar"
      "https://repo1.maven.org/maven2/com/eed3si9n/shaded-scalajson_2.13/1.0.0-M4/shaded-scalajson_2.13-1.0.0-M4.pom"
    ];
    hash = "sha256-JyvPek41KleFIS5g4bqLm+qUw5FlX51/rnvv/BT2pk0=";
    installPath = "https/repo1.maven.org/maven2/com/eed3si9n/shaded-scalajson_2.13/1.0.0-M4";
  };

  "com.eed3si9n_sjson-new-core_2.13-0.10.1" = fetchMaven {
    name = "com.eed3si9n_sjson-new-core_2.13-0.10.1";
    urls = [
      "https://repo1.maven.org/maven2/com/eed3si9n/sjson-new-core_2.13/0.10.1/sjson-new-core_2.13-0.10.1.jar"
      "https://repo1.maven.org/maven2/com/eed3si9n/sjson-new-core_2.13/0.10.1/sjson-new-core_2.13-0.10.1.pom"
    ];
    hash = "sha256-sFHoDAQBTHju2EgUOPuO9tM/SLAdb8X/oNSnar0iYoQ=";
    installPath = "https/repo1.maven.org/maven2/com/eed3si9n/sjson-new-core_2.13/0.10.1";
  };

  "com.eed3si9n_sjson-new-core_2.13-0.9.0" = fetchMaven {
    name = "com.eed3si9n_sjson-new-core_2.13-0.9.0";
    urls = [
      "https://repo1.maven.org/maven2/com/eed3si9n/sjson-new-core_2.13/0.9.0/sjson-new-core_2.13-0.9.0.pom"
    ];
    hash = "sha256-WlJsXRKj77jzoFN6d1V/+jAEl37mxggg85F3o8oD+bY=";
    installPath = "https/repo1.maven.org/maven2/com/eed3si9n/sjson-new-core_2.13/0.9.0";
  };

  "com.eed3si9n_sjson-new-scalajson_2.13-0.10.1" = fetchMaven {
    name = "com.eed3si9n_sjson-new-scalajson_2.13-0.10.1";
    urls = [
      "https://repo1.maven.org/maven2/com/eed3si9n/sjson-new-scalajson_2.13/0.10.1/sjson-new-scalajson_2.13-0.10.1.jar"
      "https://repo1.maven.org/maven2/com/eed3si9n/sjson-new-scalajson_2.13/0.10.1/sjson-new-scalajson_2.13-0.10.1.pom"
    ];
    hash = "sha256-DBGJ34c7lyt3m4o5ULwsRk1xPqtHHHKcNgU4nlO/dJY=";
    installPath = "https/repo1.maven.org/maven2/com/eed3si9n/sjson-new-scalajson_2.13/0.10.1";
  };

  "com.fasterxml_oss-parent-38" = fetchMaven {
    name = "com.fasterxml_oss-parent-38";
    urls = [ "https://repo1.maven.org/maven2/com/fasterxml/oss-parent/38/oss-parent-38.pom" ];
    hash = "sha256-EGsoil9DvrBNKLZQ0PsbSkCXy85QE8xbWf8tsyqFjW8=";
    installPath = "https/repo1.maven.org/maven2/com/fasterxml/oss-parent/38";
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

  "com.fasterxml_oss-parent-68" = fetchMaven {
    name = "com.fasterxml_oss-parent-68";
    urls = [ "https://repo1.maven.org/maven2/com/fasterxml/oss-parent/68/oss-parent-68.pom" ];
    hash = "sha256-qdxU7lCS3weCqjFAiHlT8Aa6t8bS2Yx2TV7xFruK4qw=";
    installPath = "https/repo1.maven.org/maven2/com/fasterxml/oss-parent/68";
  };

  "com.fasterxml_oss-parent-69" = fetchMaven {
    name = "com.fasterxml_oss-parent-69";
    urls = [ "https://repo1.maven.org/maven2/com/fasterxml/oss-parent/69/oss-parent-69.pom" ];
    hash = "sha256-/LRxt7QkFlgBi48aGOZGIrHfNUC9cwqkbisbV7NGgqc=";
    installPath = "https/repo1.maven.org/maven2/com/fasterxml/oss-parent/69";
  };

  "com.lihaoyi_fansi_2.13-0.5.0" = fetchMaven {
    name = "com.lihaoyi_fansi_2.13-0.5.0";
    urls = [
      "https://repo1.maven.org/maven2/com/lihaoyi/fansi_2.13/0.5.0/fansi_2.13-0.5.0.jar"
      "https://repo1.maven.org/maven2/com/lihaoyi/fansi_2.13/0.5.0/fansi_2.13-0.5.0.pom"
    ];
    hash = "sha256-iRaKoBsS7VOiQA0yj/wRNKo2NCHWteW0gM99kKObdns=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/fansi_2.13/0.5.0";
  };

  "com.lihaoyi_fansi_3-0.5.0" = fetchMaven {
    name = "com.lihaoyi_fansi_3-0.5.0";
    urls = [ "https://repo1.maven.org/maven2/com/lihaoyi/fansi_3/0.5.0/fansi_3-0.5.0.pom" ];
    hash = "sha256-CdcncPRIOuUQod1xPm3fFrMfaN6UJsSeXY8W51UcZsQ=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/fansi_3/0.5.0";
  };

  "com.lihaoyi_fansi_3-0.5.1" = fetchMaven {
    name = "com.lihaoyi_fansi_3-0.5.1";
    urls = [
      "https://repo1.maven.org/maven2/com/lihaoyi/fansi_3/0.5.1/fansi_3-0.5.1.jar"
      "https://repo1.maven.org/maven2/com/lihaoyi/fansi_3/0.5.1/fansi_3-0.5.1.pom"
    ];
    hash = "sha256-1OUhN7HxHQeI8uOzAZr1tMi2z7+LvOEJ+j9BikcSQJo=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/fansi_3/0.5.1";
  };

  "com.lihaoyi_fastparse_3-3.1.1" = fetchMaven {
    name = "com.lihaoyi_fastparse_3-3.1.1";
    urls = [
      "https://repo1.maven.org/maven2/com/lihaoyi/fastparse_3/3.1.1/fastparse_3-3.1.1.jar"
      "https://repo1.maven.org/maven2/com/lihaoyi/fastparse_3/3.1.1/fastparse_3-3.1.1.pom"
    ];
    hash = "sha256-iz6Wj92asaujz93RjmBAaKHHV64HS26cduPsQzaD6wM=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/fastparse_3/3.1.1";
  };

  "com.lihaoyi_geny_2.13-1.1.1" = fetchMaven {
    name = "com.lihaoyi_geny_2.13-1.1.1";
    urls = [
      "https://repo1.maven.org/maven2/com/lihaoyi/geny_2.13/1.1.1/geny_2.13-1.1.1.jar"
      "https://repo1.maven.org/maven2/com/lihaoyi/geny_2.13/1.1.1/geny_2.13-1.1.1.pom"
    ];
    hash = "sha256-+gQ8X4oSRU30RdF5kE2Gn8nxmo3RJEShiEyyzUJd088=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/geny_2.13/1.1.1";
  };

  "com.lihaoyi_geny_3-1.0.0" = fetchMaven {
    name = "com.lihaoyi_geny_3-1.0.0";
    urls = [ "https://repo1.maven.org/maven2/com/lihaoyi/geny_3/1.0.0/geny_3-1.0.0.pom" ];
    hash = "sha256-gyZV3FMH1nlWfPJ0nAN3y08zzWtW4AYPo1A3oaMraUY=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/geny_3/1.0.0";
  };

  "com.lihaoyi_geny_3-1.1.1" = fetchMaven {
    name = "com.lihaoyi_geny_3-1.1.1";
    urls = [
      "https://repo1.maven.org/maven2/com/lihaoyi/geny_3/1.1.1/geny_3-1.1.1.jar"
      "https://repo1.maven.org/maven2/com/lihaoyi/geny_3/1.1.1/geny_3-1.1.1.pom"
    ];
    hash = "sha256-DtsM1VVr7WxRM+YRjjVDOkfCqXzp2q9FwlSMgoD/+ow=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/geny_3/1.1.1";
  };

  "com.lihaoyi_mainargs_3-0.7.7" = fetchMaven {
    name = "com.lihaoyi_mainargs_3-0.7.7";
    urls = [
      "https://repo1.maven.org/maven2/com/lihaoyi/mainargs_3/0.7.7/mainargs_3-0.7.7.jar"
      "https://repo1.maven.org/maven2/com/lihaoyi/mainargs_3/0.7.7/mainargs_3-0.7.7.pom"
    ];
    hash = "sha256-iOPRzTZrkppVuWW1+s4d3D99P/thkWM09a/ZhFn/ERs=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/mainargs_3/0.7.7";
  };

  "com.lihaoyi_mill-contrib-jmh_3-1.1.0-RC3" = fetchMaven {
    name = "com.lihaoyi_mill-contrib-jmh_3-1.1.0-RC3";
    urls = [
      "https://repo1.maven.org/maven2/com/lihaoyi/mill-contrib-jmh_3/1.1.0-RC3/mill-contrib-jmh_3-1.1.0-RC3.jar"
      "https://repo1.maven.org/maven2/com/lihaoyi/mill-contrib-jmh_3/1.1.0-RC3/mill-contrib-jmh_3-1.1.0-RC3.pom"
    ];
    hash = "sha256-9bW2ogYXgrH4bzqMgczyOOIkSogQzlk85SpD2fMJilc=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/mill-contrib-jmh_3/1.1.0-RC3";
  };

  "com.lihaoyi_mill-core-api-daemon_3-1.1.0-RC3" = fetchMaven {
    name = "com.lihaoyi_mill-core-api-daemon_3-1.1.0-RC3";
    urls = [
      "https://repo1.maven.org/maven2/com/lihaoyi/mill-core-api-daemon_3/1.1.0-RC3/mill-core-api-daemon_3-1.1.0-RC3.jar"
      "https://repo1.maven.org/maven2/com/lihaoyi/mill-core-api-daemon_3/1.1.0-RC3/mill-core-api-daemon_3-1.1.0-RC3.pom"
    ];
    hash = "sha256-DUke+PVr1TBaRCYeVGaxFTUOLv9s3sPRzHZwy3LEt30=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/mill-core-api-daemon_3/1.1.0-RC3";
  };

  "com.lihaoyi_mill-core-api_3-1.1.0-RC3" = fetchMaven {
    name = "com.lihaoyi_mill-core-api_3-1.1.0-RC3";
    urls = [
      "https://repo1.maven.org/maven2/com/lihaoyi/mill-core-api_3/1.1.0-RC3/mill-core-api_3-1.1.0-RC3.jar"
      "https://repo1.maven.org/maven2/com/lihaoyi/mill-core-api_3/1.1.0-RC3/mill-core-api_3-1.1.0-RC3.pom"
    ];
    hash = "sha256-fjXKlIlTGGtQ4r2lF6FndkmL+HlnvxUeF6GcR3hDrCQ=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/mill-core-api_3/1.1.0-RC3";
  };

  "com.lihaoyi_mill-core-constants-1.1.0-RC3" = fetchMaven {
    name = "com.lihaoyi_mill-core-constants-1.1.0-RC3";
    urls = [
      "https://repo1.maven.org/maven2/com/lihaoyi/mill-core-constants/1.1.0-RC3/mill-core-constants-1.1.0-RC3.jar"
      "https://repo1.maven.org/maven2/com/lihaoyi/mill-core-constants/1.1.0-RC3/mill-core-constants-1.1.0-RC3.pom"
    ];
    hash = "sha256-Z5ku13UxWP2rAEOE9/omAPVjOiNMIDLbn+eBffgejDg=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/mill-core-constants/1.1.0-RC3";
  };

  "com.lihaoyi_mill-core-eval_3-1.1.0-RC3" = fetchMaven {
    name = "com.lihaoyi_mill-core-eval_3-1.1.0-RC3";
    urls = [
      "https://repo1.maven.org/maven2/com/lihaoyi/mill-core-eval_3/1.1.0-RC3/mill-core-eval_3-1.1.0-RC3.jar"
      "https://repo1.maven.org/maven2/com/lihaoyi/mill-core-eval_3/1.1.0-RC3/mill-core-eval_3-1.1.0-RC3.pom"
    ];
    hash = "sha256-IAFesS7bGi72jTNPhmBleUxhE7icX8UASYt75+kq15I=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/mill-core-eval_3/1.1.0-RC3";
  };

  "com.lihaoyi_mill-core-exec_3-1.1.0-RC3" = fetchMaven {
    name = "com.lihaoyi_mill-core-exec_3-1.1.0-RC3";
    urls = [
      "https://repo1.maven.org/maven2/com/lihaoyi/mill-core-exec_3/1.1.0-RC3/mill-core-exec_3-1.1.0-RC3.jar"
      "https://repo1.maven.org/maven2/com/lihaoyi/mill-core-exec_3/1.1.0-RC3/mill-core-exec_3-1.1.0-RC3.pom"
    ];
    hash = "sha256-JSa+6He3Cg1k3q/4Ku/xxGD6OwlLChnfbhmuWo/VhS0=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/mill-core-exec_3/1.1.0-RC3";
  };

  "com.lihaoyi_mill-core-internal-cli_3-1.1.0-RC3" = fetchMaven {
    name = "com.lihaoyi_mill-core-internal-cli_3-1.1.0-RC3";
    urls = [
      "https://repo1.maven.org/maven2/com/lihaoyi/mill-core-internal-cli_3/1.1.0-RC3/mill-core-internal-cli_3-1.1.0-RC3.jar"
      "https://repo1.maven.org/maven2/com/lihaoyi/mill-core-internal-cli_3/1.1.0-RC3/mill-core-internal-cli_3-1.1.0-RC3.pom"
    ];
    hash = "sha256-RTUEMf4WwLQgomiRhyXAJnyXd5DtaZ6Z8XTaWk1t08M=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/mill-core-internal-cli_3/1.1.0-RC3";
  };

  "com.lihaoyi_mill-core-internal_3-1.1.0-RC3" = fetchMaven {
    name = "com.lihaoyi_mill-core-internal_3-1.1.0-RC3";
    urls = [
      "https://repo1.maven.org/maven2/com/lihaoyi/mill-core-internal_3/1.1.0-RC3/mill-core-internal_3-1.1.0-RC3.jar"
      "https://repo1.maven.org/maven2/com/lihaoyi/mill-core-internal_3/1.1.0-RC3/mill-core-internal_3-1.1.0-RC3.pom"
    ];
    hash = "sha256-vkkif08OuudHRxbdpKRjGZoe72I0TrK+W1RfL8HoEbE=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/mill-core-internal_3/1.1.0-RC3";
  };

  "com.lihaoyi_mill-core-resolve_3-1.1.0-RC3" = fetchMaven {
    name = "com.lihaoyi_mill-core-resolve_3-1.1.0-RC3";
    urls = [
      "https://repo1.maven.org/maven2/com/lihaoyi/mill-core-resolve_3/1.1.0-RC3/mill-core-resolve_3-1.1.0-RC3.jar"
      "https://repo1.maven.org/maven2/com/lihaoyi/mill-core-resolve_3/1.1.0-RC3/mill-core-resolve_3-1.1.0-RC3.pom"
    ];
    hash = "sha256-F2rdnzB8Yid8aKDMf72lc/GiV3ckeFhvFMA4LqO24wU=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/mill-core-resolve_3/1.1.0-RC3";
  };

  "com.lihaoyi_mill-libs-androidlib-databinding_3-1.1.0-RC3" = fetchMaven {
    name = "com.lihaoyi_mill-libs-androidlib-databinding_3-1.1.0-RC3";
    urls = [
      "https://repo1.maven.org/maven2/com/lihaoyi/mill-libs-androidlib-databinding_3/1.1.0-RC3/mill-libs-androidlib-databinding_3-1.1.0-RC3.jar"
      "https://repo1.maven.org/maven2/com/lihaoyi/mill-libs-androidlib-databinding_3/1.1.0-RC3/mill-libs-androidlib-databinding_3-1.1.0-RC3.pom"
    ];
    hash = "sha256-BAJeZiS/75jFWNtK6PmqVyekYsvs0B8t02qQMbw0gDQ=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/mill-libs-androidlib-databinding_3/1.1.0-RC3";
  };

  "com.lihaoyi_mill-libs-androidlib_3-1.1.0-RC3" = fetchMaven {
    name = "com.lihaoyi_mill-libs-androidlib_3-1.1.0-RC3";
    urls = [
      "https://repo1.maven.org/maven2/com/lihaoyi/mill-libs-androidlib_3/1.1.0-RC3/mill-libs-androidlib_3-1.1.0-RC3.jar"
      "https://repo1.maven.org/maven2/com/lihaoyi/mill-libs-androidlib_3/1.1.0-RC3/mill-libs-androidlib_3-1.1.0-RC3.pom"
    ];
    hash = "sha256-Z3IGQd4bQJZYRzSYx2eXw7tN5BviJYzjkza4astzdCo=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/mill-libs-androidlib_3/1.1.0-RC3";
  };

  "com.lihaoyi_mill-libs-daemon-client-1.1.0-RC3" = fetchMaven {
    name = "com.lihaoyi_mill-libs-daemon-client-1.1.0-RC3";
    urls = [
      "https://repo1.maven.org/maven2/com/lihaoyi/mill-libs-daemon-client/1.1.0-RC3/mill-libs-daemon-client-1.1.0-RC3.jar"
      "https://repo1.maven.org/maven2/com/lihaoyi/mill-libs-daemon-client/1.1.0-RC3/mill-libs-daemon-client-1.1.0-RC3.pom"
    ];
    hash = "sha256-0qON6f7ib080YG7O/XT6ZxDZ4ewNRBjcvfzohFxDKfk=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/mill-libs-daemon-client/1.1.0-RC3";
  };

  "com.lihaoyi_mill-libs-daemon-server_3-1.1.0-RC3" = fetchMaven {
    name = "com.lihaoyi_mill-libs-daemon-server_3-1.1.0-RC3";
    urls = [
      "https://repo1.maven.org/maven2/com/lihaoyi/mill-libs-daemon-server_3/1.1.0-RC3/mill-libs-daemon-server_3-1.1.0-RC3.jar"
      "https://repo1.maven.org/maven2/com/lihaoyi/mill-libs-daemon-server_3/1.1.0-RC3/mill-libs-daemon-server_3-1.1.0-RC3.pom"
    ];
    hash = "sha256-Jltiw6WDO34A2dWm5y123CCBnNcIMJE7jSHhG1BL0sE=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/mill-libs-daemon-server_3/1.1.0-RC3";
  };

  "com.lihaoyi_mill-libs-init_3-1.1.0-RC3" = fetchMaven {
    name = "com.lihaoyi_mill-libs-init_3-1.1.0-RC3";
    urls = [
      "https://repo1.maven.org/maven2/com/lihaoyi/mill-libs-init_3/1.1.0-RC3/mill-libs-init_3-1.1.0-RC3.jar"
      "https://repo1.maven.org/maven2/com/lihaoyi/mill-libs-init_3/1.1.0-RC3/mill-libs-init_3-1.1.0-RC3.pom"
    ];
    hash = "sha256-rLwdbIDbjrKGXOlwJX3MGqG+lgrG+ezPeZCFSjQRBg8=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/mill-libs-init_3/1.1.0-RC3";
  };

  "com.lihaoyi_mill-libs-javalib-api_3-1.1.0-RC3" = fetchMaven {
    name = "com.lihaoyi_mill-libs-javalib-api_3-1.1.0-RC3";
    urls = [
      "https://repo1.maven.org/maven2/com/lihaoyi/mill-libs-javalib-api_3/1.1.0-RC3/mill-libs-javalib-api_3-1.1.0-RC3.jar"
      "https://repo1.maven.org/maven2/com/lihaoyi/mill-libs-javalib-api_3/1.1.0-RC3/mill-libs-javalib-api_3-1.1.0-RC3.pom"
    ];
    hash = "sha256-l4W4Xe+ZZGoivejXqWK3ov6rONFGh5KKObuK1EuQYRU=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/mill-libs-javalib-api_3/1.1.0-RC3";
  };

  "com.lihaoyi_mill-libs-javalib-classgraph-worker_3-1.1.0-RC3" = fetchMaven {
    name = "com.lihaoyi_mill-libs-javalib-classgraph-worker_3-1.1.0-RC3";
    urls = [
      "https://repo1.maven.org/maven2/com/lihaoyi/mill-libs-javalib-classgraph-worker_3/1.1.0-RC3/mill-libs-javalib-classgraph-worker_3-1.1.0-RC3.jar"
      "https://repo1.maven.org/maven2/com/lihaoyi/mill-libs-javalib-classgraph-worker_3/1.1.0-RC3/mill-libs-javalib-classgraph-worker_3-1.1.0-RC3.pom"
    ];
    hash = "sha256-naaODi4TZPherkHMa0nrq2sRAhLo6fGXVLx6DyVCZXo=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/mill-libs-javalib-classgraph-worker_3/1.1.0-RC3";
  };

  "com.lihaoyi_mill-libs-javalib-jarjarabrams-worker_3-1.1.0-RC3" = fetchMaven {
    name = "com.lihaoyi_mill-libs-javalib-jarjarabrams-worker_3-1.1.0-RC3";
    urls = [
      "https://repo1.maven.org/maven2/com/lihaoyi/mill-libs-javalib-jarjarabrams-worker_3/1.1.0-RC3/mill-libs-javalib-jarjarabrams-worker_3-1.1.0-RC3.jar"
      "https://repo1.maven.org/maven2/com/lihaoyi/mill-libs-javalib-jarjarabrams-worker_3/1.1.0-RC3/mill-libs-javalib-jarjarabrams-worker_3-1.1.0-RC3.pom"
    ];
    hash = "sha256-d/U4QPsfSwpjf0xtLDONGoJHVANiU94oyPUt/L8y2pE=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/mill-libs-javalib-jarjarabrams-worker_3/1.1.0-RC3";
  };

  "com.lihaoyi_mill-libs-javalib-maven-worker_3-1.1.0-RC3" = fetchMaven {
    name = "com.lihaoyi_mill-libs-javalib-maven-worker_3-1.1.0-RC3";
    urls = [
      "https://repo1.maven.org/maven2/com/lihaoyi/mill-libs-javalib-maven-worker_3/1.1.0-RC3/mill-libs-javalib-maven-worker_3-1.1.0-RC3.jar"
      "https://repo1.maven.org/maven2/com/lihaoyi/mill-libs-javalib-maven-worker_3/1.1.0-RC3/mill-libs-javalib-maven-worker_3-1.1.0-RC3.pom"
    ];
    hash = "sha256-QKpR6ZsqCVewTap9zHUClIP9L+Z+6jHSMyxOPs8qcVQ=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/mill-libs-javalib-maven-worker_3/1.1.0-RC3";
  };

  "com.lihaoyi_mill-libs-javalib-testrunner-entrypoint-1.1.0-RC3" = fetchMaven {
    name = "com.lihaoyi_mill-libs-javalib-testrunner-entrypoint-1.1.0-RC3";
    urls = [
      "https://repo1.maven.org/maven2/com/lihaoyi/mill-libs-javalib-testrunner-entrypoint/1.1.0-RC3/mill-libs-javalib-testrunner-entrypoint-1.1.0-RC3.jar"
      "https://repo1.maven.org/maven2/com/lihaoyi/mill-libs-javalib-testrunner-entrypoint/1.1.0-RC3/mill-libs-javalib-testrunner-entrypoint-1.1.0-RC3.pom"
    ];
    hash = "sha256-Q6lgvb6vGuX470gpoToQISM2aNIVOKbB3YdA6zyNwK4=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/mill-libs-javalib-testrunner-entrypoint/1.1.0-RC3";
  };

  "com.lihaoyi_mill-libs-javalib-testrunner_3-1.1.0-RC3" = fetchMaven {
    name = "com.lihaoyi_mill-libs-javalib-testrunner_3-1.1.0-RC3";
    urls = [
      "https://repo1.maven.org/maven2/com/lihaoyi/mill-libs-javalib-testrunner_3/1.1.0-RC3/mill-libs-javalib-testrunner_3-1.1.0-RC3.jar"
      "https://repo1.maven.org/maven2/com/lihaoyi/mill-libs-javalib-testrunner_3/1.1.0-RC3/mill-libs-javalib-testrunner_3-1.1.0-RC3.pom"
    ];
    hash = "sha256-3mqbRpLUbanWjsLHRrkXsK9Vs+63BvX8rJwBQGSJMyQ=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/mill-libs-javalib-testrunner_3/1.1.0-RC3";
  };

  "com.lihaoyi_mill-libs-javalib-worker_3-1.1.0-RC3" = fetchMaven {
    name = "com.lihaoyi_mill-libs-javalib-worker_3-1.1.0-RC3";
    urls = [
      "https://repo1.maven.org/maven2/com/lihaoyi/mill-libs-javalib-worker_3/1.1.0-RC3/mill-libs-javalib-worker_3-1.1.0-RC3.jar"
      "https://repo1.maven.org/maven2/com/lihaoyi/mill-libs-javalib-worker_3/1.1.0-RC3/mill-libs-javalib-worker_3-1.1.0-RC3.pom"
    ];
    hash = "sha256-ExqtIb/lyP7ryF+2gaXqyuH+4ohmnN0JItLXRJIN5Eg=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/mill-libs-javalib-worker_3/1.1.0-RC3";
  };

  "com.lihaoyi_mill-libs-javalib_3-1.1.0-RC3" = fetchMaven {
    name = "com.lihaoyi_mill-libs-javalib_3-1.1.0-RC3";
    urls = [
      "https://repo1.maven.org/maven2/com/lihaoyi/mill-libs-javalib_3/1.1.0-RC3/mill-libs-javalib_3-1.1.0-RC3.jar"
      "https://repo1.maven.org/maven2/com/lihaoyi/mill-libs-javalib_3/1.1.0-RC3/mill-libs-javalib_3-1.1.0-RC3.pom"
    ];
    hash = "sha256-9qxBknr4f0FkXX2fPBxKNqYrAoL9BazdBTuiA/1F1hY=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/mill-libs-javalib_3/1.1.0-RC3";
  };

  "com.lihaoyi_mill-libs-javascriptlib_3-1.1.0-RC3" = fetchMaven {
    name = "com.lihaoyi_mill-libs-javascriptlib_3-1.1.0-RC3";
    urls = [
      "https://repo1.maven.org/maven2/com/lihaoyi/mill-libs-javascriptlib_3/1.1.0-RC3/mill-libs-javascriptlib_3-1.1.0-RC3.jar"
      "https://repo1.maven.org/maven2/com/lihaoyi/mill-libs-javascriptlib_3/1.1.0-RC3/mill-libs-javascriptlib_3-1.1.0-RC3.pom"
    ];
    hash = "sha256-TiRDFaQ3HmlAyVgBKlqqWmKJoj9AHTHzHPLp4LY5l/w=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/mill-libs-javascriptlib_3/1.1.0-RC3";
  };

  "com.lihaoyi_mill-libs-kotlinlib-api_3-1.1.0-RC3" = fetchMaven {
    name = "com.lihaoyi_mill-libs-kotlinlib-api_3-1.1.0-RC3";
    urls = [
      "https://repo1.maven.org/maven2/com/lihaoyi/mill-libs-kotlinlib-api_3/1.1.0-RC3/mill-libs-kotlinlib-api_3-1.1.0-RC3.jar"
      "https://repo1.maven.org/maven2/com/lihaoyi/mill-libs-kotlinlib-api_3/1.1.0-RC3/mill-libs-kotlinlib-api_3-1.1.0-RC3.pom"
    ];
    hash = "sha256-QzTVGyipSZ+0w0fhE7RmpVjs1JzllzipDK6bqhFRWe8=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/mill-libs-kotlinlib-api_3/1.1.0-RC3";
  };

  "com.lihaoyi_mill-libs-kotlinlib-ksp2-api_3-1.1.0-RC3" = fetchMaven {
    name = "com.lihaoyi_mill-libs-kotlinlib-ksp2-api_3-1.1.0-RC3";
    urls = [
      "https://repo1.maven.org/maven2/com/lihaoyi/mill-libs-kotlinlib-ksp2-api_3/1.1.0-RC3/mill-libs-kotlinlib-ksp2-api_3-1.1.0-RC3.jar"
      "https://repo1.maven.org/maven2/com/lihaoyi/mill-libs-kotlinlib-ksp2-api_3/1.1.0-RC3/mill-libs-kotlinlib-ksp2-api_3-1.1.0-RC3.pom"
    ];
    hash = "sha256-tZ3nzjtpj6A+/kjWJv7Qi7rpz1B9yMbgLzx20poKJQI=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/mill-libs-kotlinlib-ksp2-api_3/1.1.0-RC3";
  };

  "com.lihaoyi_mill-libs-kotlinlib_3-1.1.0-RC3" = fetchMaven {
    name = "com.lihaoyi_mill-libs-kotlinlib_3-1.1.0-RC3";
    urls = [
      "https://repo1.maven.org/maven2/com/lihaoyi/mill-libs-kotlinlib_3/1.1.0-RC3/mill-libs-kotlinlib_3-1.1.0-RC3.jar"
      "https://repo1.maven.org/maven2/com/lihaoyi/mill-libs-kotlinlib_3/1.1.0-RC3/mill-libs-kotlinlib_3-1.1.0-RC3.pom"
    ];
    hash = "sha256-itFVLa/Aadk90kF7mCfbxG/GlWs6TxxRrjUh2XHnz8I=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/mill-libs-kotlinlib_3/1.1.0-RC3";
  };

  "com.lihaoyi_mill-libs-pythonlib_3-1.1.0-RC3" = fetchMaven {
    name = "com.lihaoyi_mill-libs-pythonlib_3-1.1.0-RC3";
    urls = [
      "https://repo1.maven.org/maven2/com/lihaoyi/mill-libs-pythonlib_3/1.1.0-RC3/mill-libs-pythonlib_3-1.1.0-RC3.jar"
      "https://repo1.maven.org/maven2/com/lihaoyi/mill-libs-pythonlib_3/1.1.0-RC3/mill-libs-pythonlib_3-1.1.0-RC3.pom"
    ];
    hash = "sha256-29NN5v/cUYN2VPQ/XEmjkhZL0n0FzRT/HmbET2gSliU=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/mill-libs-pythonlib_3/1.1.0-RC3";
  };

  "com.lihaoyi_mill-libs-rpc_3-1.1.0-RC3" = fetchMaven {
    name = "com.lihaoyi_mill-libs-rpc_3-1.1.0-RC3";
    urls = [
      "https://repo1.maven.org/maven2/com/lihaoyi/mill-libs-rpc_3/1.1.0-RC3/mill-libs-rpc_3-1.1.0-RC3.jar"
      "https://repo1.maven.org/maven2/com/lihaoyi/mill-libs-rpc_3/1.1.0-RC3/mill-libs-rpc_3-1.1.0-RC3.pom"
    ];
    hash = "sha256-FkkOc8Y7OyuIAQb/h7aU8CJ1ri8+eGFMOPpmvEvq2ts=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/mill-libs-rpc_3/1.1.0-RC3";
  };

  "com.lihaoyi_mill-libs-scalajslib-api_3-1.1.0-RC3" = fetchMaven {
    name = "com.lihaoyi_mill-libs-scalajslib-api_3-1.1.0-RC3";
    urls = [
      "https://repo1.maven.org/maven2/com/lihaoyi/mill-libs-scalajslib-api_3/1.1.0-RC3/mill-libs-scalajslib-api_3-1.1.0-RC3.jar"
      "https://repo1.maven.org/maven2/com/lihaoyi/mill-libs-scalajslib-api_3/1.1.0-RC3/mill-libs-scalajslib-api_3-1.1.0-RC3.pom"
    ];
    hash = "sha256-LdZdkHL9IXMxb7gsLM46MbIHYc7VMbZgecSBDqOQg0A=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/mill-libs-scalajslib-api_3/1.1.0-RC3";
  };

  "com.lihaoyi_mill-libs-scalajslib_3-1.1.0-RC3" = fetchMaven {
    name = "com.lihaoyi_mill-libs-scalajslib_3-1.1.0-RC3";
    urls = [
      "https://repo1.maven.org/maven2/com/lihaoyi/mill-libs-scalajslib_3/1.1.0-RC3/mill-libs-scalajslib_3-1.1.0-RC3.jar"
      "https://repo1.maven.org/maven2/com/lihaoyi/mill-libs-scalajslib_3/1.1.0-RC3/mill-libs-scalajslib_3-1.1.0-RC3.pom"
    ];
    hash = "sha256-c84Avg61boMbkPBB2hNmeqtSG8TAYlzei+LohObqWkg=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/mill-libs-scalajslib_3/1.1.0-RC3";
  };

  "com.lihaoyi_mill-libs-scalalib_3-1.1.0-RC3" = fetchMaven {
    name = "com.lihaoyi_mill-libs-scalalib_3-1.1.0-RC3";
    urls = [
      "https://repo1.maven.org/maven2/com/lihaoyi/mill-libs-scalalib_3/1.1.0-RC3/mill-libs-scalalib_3-1.1.0-RC3.jar"
      "https://repo1.maven.org/maven2/com/lihaoyi/mill-libs-scalalib_3/1.1.0-RC3/mill-libs-scalalib_3-1.1.0-RC3.pom"
    ];
    hash = "sha256-e4RkzaIGtnkXs2lbDxxb/GVNvjucfaNtONzIyjgl7X8=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/mill-libs-scalalib_3/1.1.0-RC3";
  };

  "com.lihaoyi_mill-libs-scalanativelib-api_3-1.1.0-RC3" = fetchMaven {
    name = "com.lihaoyi_mill-libs-scalanativelib-api_3-1.1.0-RC3";
    urls = [
      "https://repo1.maven.org/maven2/com/lihaoyi/mill-libs-scalanativelib-api_3/1.1.0-RC3/mill-libs-scalanativelib-api_3-1.1.0-RC3.jar"
      "https://repo1.maven.org/maven2/com/lihaoyi/mill-libs-scalanativelib-api_3/1.1.0-RC3/mill-libs-scalanativelib-api_3-1.1.0-RC3.pom"
    ];
    hash = "sha256-RIYWbXFmwHhmxMyyByBAqfi1LWKwfHoTMCb/biMRjq8=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/mill-libs-scalanativelib-api_3/1.1.0-RC3";
  };

  "com.lihaoyi_mill-libs-scalanativelib_3-1.1.0-RC3" = fetchMaven {
    name = "com.lihaoyi_mill-libs-scalanativelib_3-1.1.0-RC3";
    urls = [
      "https://repo1.maven.org/maven2/com/lihaoyi/mill-libs-scalanativelib_3/1.1.0-RC3/mill-libs-scalanativelib_3-1.1.0-RC3.jar"
      "https://repo1.maven.org/maven2/com/lihaoyi/mill-libs-scalanativelib_3/1.1.0-RC3/mill-libs-scalanativelib_3-1.1.0-RC3.pom"
    ];
    hash = "sha256-CEFgNjYP9Y2EFTQcqOOiiEk3aQ3bmyE81zurmHJ+cgk=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/mill-libs-scalanativelib_3/1.1.0-RC3";
  };

  "com.lihaoyi_mill-libs-script_3-1.1.0-RC3" = fetchMaven {
    name = "com.lihaoyi_mill-libs-script_3-1.1.0-RC3";
    urls = [
      "https://repo1.maven.org/maven2/com/lihaoyi/mill-libs-script_3/1.1.0-RC3/mill-libs-script_3-1.1.0-RC3.jar"
      "https://repo1.maven.org/maven2/com/lihaoyi/mill-libs-script_3/1.1.0-RC3/mill-libs-script_3-1.1.0-RC3.pom"
    ];
    hash = "sha256-T2fPgHxu/fAk3w7nMTfcl0B1KTFjepGPhI0/nzc9TD0=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/mill-libs-script_3/1.1.0-RC3";
  };

  "com.lihaoyi_mill-libs-tabcomplete_3-1.1.0-RC3" = fetchMaven {
    name = "com.lihaoyi_mill-libs-tabcomplete_3-1.1.0-RC3";
    urls = [
      "https://repo1.maven.org/maven2/com/lihaoyi/mill-libs-tabcomplete_3/1.1.0-RC3/mill-libs-tabcomplete_3-1.1.0-RC3.jar"
      "https://repo1.maven.org/maven2/com/lihaoyi/mill-libs-tabcomplete_3/1.1.0-RC3/mill-libs-tabcomplete_3-1.1.0-RC3.pom"
    ];
    hash = "sha256-kyKiGG8mAhpVB709/G1XMRCpOqesNSj5/eqWp32RLSU=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/mill-libs-tabcomplete_3/1.1.0-RC3";
  };

  "com.lihaoyi_mill-libs-util_3-1.1.0-RC3" = fetchMaven {
    name = "com.lihaoyi_mill-libs-util_3-1.1.0-RC3";
    urls = [
      "https://repo1.maven.org/maven2/com/lihaoyi/mill-libs-util_3/1.1.0-RC3/mill-libs-util_3-1.1.0-RC3.jar"
      "https://repo1.maven.org/maven2/com/lihaoyi/mill-libs-util_3/1.1.0-RC3/mill-libs-util_3-1.1.0-RC3.pom"
    ];
    hash = "sha256-Hs7G+0UL+oRPKkqZxFT8HLr5F6v70XO88sUrt/MYQjg=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/mill-libs-util_3/1.1.0-RC3";
  };

  "com.lihaoyi_mill-libs_3-1.1.0-RC3" = fetchMaven {
    name = "com.lihaoyi_mill-libs_3-1.1.0-RC3";
    urls = [
      "https://repo1.maven.org/maven2/com/lihaoyi/mill-libs_3/1.1.0-RC3/mill-libs_3-1.1.0-RC3.jar"
      "https://repo1.maven.org/maven2/com/lihaoyi/mill-libs_3/1.1.0-RC3/mill-libs_3-1.1.0-RC3.pom"
    ];
    hash = "sha256-m/AoWavS+RysVBTWD7KGJnXgBQwUt+TZ9aDQ1+cfW+s=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/mill-libs_3/1.1.0-RC3";
  };

  "com.lihaoyi_mill-moduledefs_3-0.12.3" = fetchMaven {
    name = "com.lihaoyi_mill-moduledefs_3-0.12.3";
    urls = [
      "https://repo1.maven.org/maven2/com/lihaoyi/mill-moduledefs_3/0.12.3/mill-moduledefs_3-0.12.3.jar"
      "https://repo1.maven.org/maven2/com/lihaoyi/mill-moduledefs_3/0.12.3/mill-moduledefs_3-0.12.3.pom"
    ];
    hash = "sha256-O6Rh6F5m9vP4liUPCw8LFIZGkvAuShQZFBAgKXJGS/E=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/mill-moduledefs_3/0.12.3";
  };

  "com.lihaoyi_mill-runner-autooverride-api_3-1.1.0-RC3" = fetchMaven {
    name = "com.lihaoyi_mill-runner-autooverride-api_3-1.1.0-RC3";
    urls = [
      "https://repo1.maven.org/maven2/com/lihaoyi/mill-runner-autooverride-api_3/1.1.0-RC3/mill-runner-autooverride-api_3-1.1.0-RC3.jar"
      "https://repo1.maven.org/maven2/com/lihaoyi/mill-runner-autooverride-api_3/1.1.0-RC3/mill-runner-autooverride-api_3-1.1.0-RC3.pom"
    ];
    hash = "sha256-F7sDBHIA2Do6Q3nGtercgPg0+UwDpWkZRqbwtKwn8n0=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/mill-runner-autooverride-api_3/1.1.0-RC3";
  };

  "com.lihaoyi_mill-runner-autooverride-plugin_3.8.0-RC2-1.1.0-RC3" = fetchMaven {
    name = "com.lihaoyi_mill-runner-autooverride-plugin_3.8.0-RC2-1.1.0-RC3";
    urls = [
      "https://repo1.maven.org/maven2/com/lihaoyi/mill-runner-autooverride-plugin_3.8.0-RC2/1.1.0-RC3/mill-runner-autooverride-plugin_3.8.0-RC2-1.1.0-RC3.jar"
      "https://repo1.maven.org/maven2/com/lihaoyi/mill-runner-autooverride-plugin_3.8.0-RC2/1.1.0-RC3/mill-runner-autooverride-plugin_3.8.0-RC2-1.1.0-RC3.pom"
    ];
    hash = "sha256-vDcNmd3I96Qi6s60k0Z7pK453RyU+Ok2fAo4/8/l1eY=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/mill-runner-autooverride-plugin_3.8.0-RC2/1.1.0-RC3";
  };

  "com.lihaoyi_mill-runner-bsp-worker_3-1.1.0-RC3" = fetchMaven {
    name = "com.lihaoyi_mill-runner-bsp-worker_3-1.1.0-RC3";
    urls = [
      "https://repo1.maven.org/maven2/com/lihaoyi/mill-runner-bsp-worker_3/1.1.0-RC3/mill-runner-bsp-worker_3-1.1.0-RC3.jar"
      "https://repo1.maven.org/maven2/com/lihaoyi/mill-runner-bsp-worker_3/1.1.0-RC3/mill-runner-bsp-worker_3-1.1.0-RC3.pom"
    ];
    hash = "sha256-K1CHeeI1oKJRfsQKRRNt7RA4iJGbsO0X9RBsE02E6y0=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/mill-runner-bsp-worker_3/1.1.0-RC3";
  };

  "com.lihaoyi_mill-runner-bsp_3-1.1.0-RC3" = fetchMaven {
    name = "com.lihaoyi_mill-runner-bsp_3-1.1.0-RC3";
    urls = [
      "https://repo1.maven.org/maven2/com/lihaoyi/mill-runner-bsp_3/1.1.0-RC3/mill-runner-bsp_3-1.1.0-RC3.jar"
      "https://repo1.maven.org/maven2/com/lihaoyi/mill-runner-bsp_3/1.1.0-RC3/mill-runner-bsp_3-1.1.0-RC3.pom"
    ];
    hash = "sha256-lWvphIfkmECbVd+yCk161POaOiUvJuVxMaepiuIsCJ0=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/mill-runner-bsp_3/1.1.0-RC3";
  };

  "com.lihaoyi_mill-runner-client-1.1.0-RC3" = fetchMaven {
    name = "com.lihaoyi_mill-runner-client-1.1.0-RC3";
    urls = [
      "https://repo1.maven.org/maven2/com/lihaoyi/mill-runner-client/1.1.0-RC3/mill-runner-client-1.1.0-RC3.jar"
      "https://repo1.maven.org/maven2/com/lihaoyi/mill-runner-client/1.1.0-RC3/mill-runner-client-1.1.0-RC3.pom"
    ];
    hash = "sha256-/7RBhSemfrYQFOJwUZybd5jIWd4DASXMwqem0o2dCLg=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/mill-runner-client/1.1.0-RC3";
  };

  "com.lihaoyi_mill-runner-codesig_3-1.1.0-RC3" = fetchMaven {
    name = "com.lihaoyi_mill-runner-codesig_3-1.1.0-RC3";
    urls = [
      "https://repo1.maven.org/maven2/com/lihaoyi/mill-runner-codesig_3/1.1.0-RC3/mill-runner-codesig_3-1.1.0-RC3.jar"
      "https://repo1.maven.org/maven2/com/lihaoyi/mill-runner-codesig_3/1.1.0-RC3/mill-runner-codesig_3-1.1.0-RC3.pom"
    ];
    hash = "sha256-zceeo3LpA8NYtrm55s3oNajLwAXox2iv/oFjiz9wFbg=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/mill-runner-codesig_3/1.1.0-RC3";
  };

  "com.lihaoyi_mill-runner-daemon_3-1.1.0-RC3" = fetchMaven {
    name = "com.lihaoyi_mill-runner-daemon_3-1.1.0-RC3";
    urls = [
      "https://repo1.maven.org/maven2/com/lihaoyi/mill-runner-daemon_3/1.1.0-RC3/mill-runner-daemon_3-1.1.0-RC3.jar"
      "https://repo1.maven.org/maven2/com/lihaoyi/mill-runner-daemon_3/1.1.0-RC3/mill-runner-daemon_3-1.1.0-RC3.pom"
    ];
    hash = "sha256-hJBxR3hQ0v7DdcC5h3nZqwPSpkJkitQW5lq1BvoxS2Q=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/mill-runner-daemon_3/1.1.0-RC3";
  };

  "com.lihaoyi_mill-runner-eclipse_3-1.1.0-RC3" = fetchMaven {
    name = "com.lihaoyi_mill-runner-eclipse_3-1.1.0-RC3";
    urls = [
      "https://repo1.maven.org/maven2/com/lihaoyi/mill-runner-eclipse_3/1.1.0-RC3/mill-runner-eclipse_3-1.1.0-RC3.jar"
      "https://repo1.maven.org/maven2/com/lihaoyi/mill-runner-eclipse_3/1.1.0-RC3/mill-runner-eclipse_3-1.1.0-RC3.pom"
    ];
    hash = "sha256-XwOicDRQtTY58RP1ahsMWuhRfNoCtEp1HpFgXUbVy+8=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/mill-runner-eclipse_3/1.1.0-RC3";
  };

  "com.lihaoyi_mill-runner-idea_3-1.1.0-RC3" = fetchMaven {
    name = "com.lihaoyi_mill-runner-idea_3-1.1.0-RC3";
    urls = [
      "https://repo1.maven.org/maven2/com/lihaoyi/mill-runner-idea_3/1.1.0-RC3/mill-runner-idea_3-1.1.0-RC3.jar"
      "https://repo1.maven.org/maven2/com/lihaoyi/mill-runner-idea_3/1.1.0-RC3/mill-runner-idea_3-1.1.0-RC3.pom"
    ];
    hash = "sha256-c/xrIYN8+Yaeeal6OzqoRlXUscBNP34REbpMLPAIDwg=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/mill-runner-idea_3/1.1.0-RC3";
  };

  "com.lihaoyi_mill-runner-launcher_3-1.1.0-RC3" = fetchMaven {
    name = "com.lihaoyi_mill-runner-launcher_3-1.1.0-RC3";
    urls = [
      "https://repo1.maven.org/maven2/com/lihaoyi/mill-runner-launcher_3/1.1.0-RC3/mill-runner-launcher_3-1.1.0-RC3.jar"
      "https://repo1.maven.org/maven2/com/lihaoyi/mill-runner-launcher_3/1.1.0-RC3/mill-runner-launcher_3-1.1.0-RC3.pom"
    ];
    hash = "sha256-XCm7lvhdYWcb2BQqs3VH+LAOtLhM5/iZacAmLdeKZxE=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/mill-runner-launcher_3/1.1.0-RC3";
  };

  "com.lihaoyi_mill-runner-meta_3-1.1.0-RC3" = fetchMaven {
    name = "com.lihaoyi_mill-runner-meta_3-1.1.0-RC3";
    urls = [
      "https://repo1.maven.org/maven2/com/lihaoyi/mill-runner-meta_3/1.1.0-RC3/mill-runner-meta_3-1.1.0-RC3.jar"
      "https://repo1.maven.org/maven2/com/lihaoyi/mill-runner-meta_3/1.1.0-RC3/mill-runner-meta_3-1.1.0-RC3.pom"
    ];
    hash = "sha256-6QxIi5+kMFCpEwGgq3a1mmEGlVtZK5P0tteMLJJ61YI=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/mill-runner-meta_3/1.1.0-RC3";
  };

  "com.lihaoyi_mill-runner-server_3-1.1.0-RC3" = fetchMaven {
    name = "com.lihaoyi_mill-runner-server_3-1.1.0-RC3";
    urls = [
      "https://repo1.maven.org/maven2/com/lihaoyi/mill-runner-server_3/1.1.0-RC3/mill-runner-server_3-1.1.0-RC3.jar"
      "https://repo1.maven.org/maven2/com/lihaoyi/mill-runner-server_3/1.1.0-RC3/mill-runner-server_3-1.1.0-RC3.pom"
    ];
    hash = "sha256-2cxY03DxxEXe6NGY3buGSKbKaPYA+D9XOt8pYOUmvrs=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/mill-runner-server_3/1.1.0-RC3";
  };

  "com.lihaoyi_mill-scala-compiler-bridge_2.13.11-0.0.1" = fetchMaven {
    name = "com.lihaoyi_mill-scala-compiler-bridge_2.13.11-0.0.1";
    urls = [
      "https://repo1.maven.org/maven2/com/lihaoyi/mill-scala-compiler-bridge_2.13.11/0.0.1/mill-scala-compiler-bridge_2.13.11-0.0.1.jar"
      "https://repo1.maven.org/maven2/com/lihaoyi/mill-scala-compiler-bridge_2.13.11/0.0.1/mill-scala-compiler-bridge_2.13.11-0.0.1.pom"
    ];
    hash = "sha256-85VIE0haqL2KS09/qnmszLSlEg6zwnxOdv22lIHNWEQ=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/mill-scala-compiler-bridge_2.13.11/0.0.1";
  };

  "com.lihaoyi_mill-scala-compiler-bridge_2.13.12-0.0.1" = fetchMaven {
    name = "com.lihaoyi_mill-scala-compiler-bridge_2.13.12-0.0.1";
    urls = [
      "https://repo1.maven.org/maven2/com/lihaoyi/mill-scala-compiler-bridge_2.13.12/0.0.1/mill-scala-compiler-bridge_2.13.12-0.0.1.jar"
      "https://repo1.maven.org/maven2/com/lihaoyi/mill-scala-compiler-bridge_2.13.12/0.0.1/mill-scala-compiler-bridge_2.13.12-0.0.1.pom"
    ];
    hash = "sha256-GaXk8CIA96v8LO4rVEQiDCtSYt+W/jflKFVX5MSJ7Bo=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/mill-scala-compiler-bridge_2.13.12/0.0.1";
  };

  "com.lihaoyi_mill-scala-compiler-bridge_2.13.13-0.0.1" = fetchMaven {
    name = "com.lihaoyi_mill-scala-compiler-bridge_2.13.13-0.0.1";
    urls = [
      "https://repo1.maven.org/maven2/com/lihaoyi/mill-scala-compiler-bridge_2.13.13/0.0.1/mill-scala-compiler-bridge_2.13.13-0.0.1.jar"
      "https://repo1.maven.org/maven2/com/lihaoyi/mill-scala-compiler-bridge_2.13.13/0.0.1/mill-scala-compiler-bridge_2.13.13-0.0.1.pom"
    ];
    hash = "sha256-jaAbMoJZqGg4nuOFVDeyYDGIQ7ZM6iG8GGjlPIuhhoQ=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/mill-scala-compiler-bridge_2.13.13/0.0.1";
  };

  "com.lihaoyi_mill-scala-compiler-bridge_2.13.14-0.0.1" = fetchMaven {
    name = "com.lihaoyi_mill-scala-compiler-bridge_2.13.14-0.0.1";
    urls = [
      "https://repo1.maven.org/maven2/com/lihaoyi/mill-scala-compiler-bridge_2.13.14/0.0.1/mill-scala-compiler-bridge_2.13.14-0.0.1.jar"
      "https://repo1.maven.org/maven2/com/lihaoyi/mill-scala-compiler-bridge_2.13.14/0.0.1/mill-scala-compiler-bridge_2.13.14-0.0.1.pom"
    ];
    hash = "sha256-KkXlgNvX7H0Kfg+LjXNbkzSG6lIi4G9aGeKzyeyz73o=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/mill-scala-compiler-bridge_2.13.14/0.0.1";
  };

  "com.lihaoyi_mill-scala-compiler-bridge_2.13.15-0.0.1" = fetchMaven {
    name = "com.lihaoyi_mill-scala-compiler-bridge_2.13.15-0.0.1";
    urls = [
      "https://repo1.maven.org/maven2/com/lihaoyi/mill-scala-compiler-bridge_2.13.15/0.0.1/mill-scala-compiler-bridge_2.13.15-0.0.1.jar"
      "https://repo1.maven.org/maven2/com/lihaoyi/mill-scala-compiler-bridge_2.13.15/0.0.1/mill-scala-compiler-bridge_2.13.15-0.0.1.pom"
    ];
    hash = "sha256-uTyXjgTJGlaKl8jCUp9A6uDdma97ixL65GNVD9l9oOw=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/mill-scala-compiler-bridge_2.13.15/0.0.1";
  };

  "com.lihaoyi_mill-scala-compiler-bridge_2.13.16-0.0.1" = fetchMaven {
    name = "com.lihaoyi_mill-scala-compiler-bridge_2.13.16-0.0.1";
    urls = [
      "https://repo1.maven.org/maven2/com/lihaoyi/mill-scala-compiler-bridge_2.13.16/0.0.1/mill-scala-compiler-bridge_2.13.16-0.0.1.jar"
      "https://repo1.maven.org/maven2/com/lihaoyi/mill-scala-compiler-bridge_2.13.16/0.0.1/mill-scala-compiler-bridge_2.13.16-0.0.1.pom"
    ];
    hash = "sha256-hbznI1IHBTp0umvFUM1j/aiAXEw5CywzRWhYqCrWsZw=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/mill-scala-compiler-bridge_2.13.16/0.0.1";
  };

  "com.lihaoyi_os-lib-watch_3-0.11.5" = fetchMaven {
    name = "com.lihaoyi_os-lib-watch_3-0.11.5";
    urls = [
      "https://repo1.maven.org/maven2/com/lihaoyi/os-lib-watch_3/0.11.5/os-lib-watch_3-0.11.5.jar"
      "https://repo1.maven.org/maven2/com/lihaoyi/os-lib-watch_3/0.11.5/os-lib-watch_3-0.11.5.pom"
    ];
    hash = "sha256-BgK3+PLSFeZDn3NtQ8r38HQXKXbIPawLAgJhOVDZbvI=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/os-lib-watch_3/0.11.5";
  };

  "com.lihaoyi_os-lib_2.13-0.10.7" = fetchMaven {
    name = "com.lihaoyi_os-lib_2.13-0.10.7";
    urls = [
      "https://repo1.maven.org/maven2/com/lihaoyi/os-lib_2.13/0.10.7/os-lib_2.13-0.10.7.jar"
      "https://repo1.maven.org/maven2/com/lihaoyi/os-lib_2.13/0.10.7/os-lib_2.13-0.10.7.pom"
    ];
    hash = "sha256-cFLSLivNUGJqK77tnPp+hczer3gSR+T/3vOu9L4RanU=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/os-lib_2.13/0.10.7";
  };

  "com.lihaoyi_os-lib_3-0.10.7" = fetchMaven {
    name = "com.lihaoyi_os-lib_3-0.10.7";
    urls = [
      "https://repo1.maven.org/maven2/com/lihaoyi/os-lib_3/0.10.7/os-lib_3-0.10.7.jar"
      "https://repo1.maven.org/maven2/com/lihaoyi/os-lib_3/0.10.7/os-lib_3-0.10.7.pom"
    ];
    hash = "sha256-CH66D8qWU64SD/ZHf0lO1nWykhrqTUFPNkwK3xn3cT0=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/os-lib_3/0.10.7";
  };

  "com.lihaoyi_os-lib_3-0.11.5" = fetchMaven {
    name = "com.lihaoyi_os-lib_3-0.11.5";
    urls = [
      "https://repo1.maven.org/maven2/com/lihaoyi/os-lib_3/0.11.5/os-lib_3-0.11.5.jar"
      "https://repo1.maven.org/maven2/com/lihaoyi/os-lib_3/0.11.5/os-lib_3-0.11.5.pom"
    ];
    hash = "sha256-AcCrTmkce6mc0I36fAGbpvrXP7LCoZfQwwomb4a6IBY=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/os-lib_3/0.11.5";
  };

  "com.lihaoyi_os-zip-0.11.5" = fetchMaven {
    name = "com.lihaoyi_os-zip-0.11.5";
    urls = [
      "https://repo1.maven.org/maven2/com/lihaoyi/os-zip/0.11.5/os-zip-0.11.5.jar"
      "https://repo1.maven.org/maven2/com/lihaoyi/os-zip/0.11.5/os-zip-0.11.5.pom"
    ];
    hash = "sha256-Vl344PVnjZZcpquRbr+UkjIUnXCrVrrDV58mnFuQpbk=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/os-zip/0.11.5";
  };

  "com.lihaoyi_pprint_2.13-0.9.0" = fetchMaven {
    name = "com.lihaoyi_pprint_2.13-0.9.0";
    urls = [
      "https://repo1.maven.org/maven2/com/lihaoyi/pprint_2.13/0.9.0/pprint_2.13-0.9.0.jar"
      "https://repo1.maven.org/maven2/com/lihaoyi/pprint_2.13/0.9.0/pprint_2.13-0.9.0.pom"
    ];
    hash = "sha256-RUmk2jO7irTaoMYgRK6Ui/SeyLEFCAspCehIccoQoeE=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/pprint_2.13/0.9.0";
  };

  "com.lihaoyi_pprint_3-0.9.3" = fetchMaven {
    name = "com.lihaoyi_pprint_3-0.9.3";
    urls = [
      "https://repo1.maven.org/maven2/com/lihaoyi/pprint_3/0.9.3/pprint_3-0.9.3.jar"
      "https://repo1.maven.org/maven2/com/lihaoyi/pprint_3/0.9.3/pprint_3-0.9.3.pom"
    ];
    hash = "sha256-1Ifl6qABoIAAD/1ahPwZ+qTVhEYfqecg9OtCi+kzEh8=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/pprint_3/0.9.3";
  };

  "com.lihaoyi_pprint_3-0.9.5" = fetchMaven {
    name = "com.lihaoyi_pprint_3-0.9.5";
    urls = [
      "https://repo1.maven.org/maven2/com/lihaoyi/pprint_3/0.9.5/pprint_3-0.9.5.jar"
      "https://repo1.maven.org/maven2/com/lihaoyi/pprint_3/0.9.5/pprint_3-0.9.5.pom"
    ];
    hash = "sha256-+SVDXeEz2mf+kAzDBV4GmKi3qJJia2Rjwi0C3/8NtA4=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/pprint_3/0.9.5";
  };

  "com.lihaoyi_requests_3-0.9.0" = fetchMaven {
    name = "com.lihaoyi_requests_3-0.9.0";
    urls = [
      "https://repo1.maven.org/maven2/com/lihaoyi/requests_3/0.9.0/requests_3-0.9.0.jar"
      "https://repo1.maven.org/maven2/com/lihaoyi/requests_3/0.9.0/requests_3-0.9.0.pom"
    ];
    hash = "sha256-ueGLE6/p3TelKviK8v0F1xJShdQfoSHGQoLT58/xf94=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/requests_3/0.9.0";
  };

  "com.lihaoyi_scalac-mill-moduledefs-plugin_3.8.0-RC2-0.12.3" = fetchMaven {
    name = "com.lihaoyi_scalac-mill-moduledefs-plugin_3.8.0-RC2-0.12.3";
    urls = [
      "https://repo1.maven.org/maven2/com/lihaoyi/scalac-mill-moduledefs-plugin_3.8.0-RC2/0.12.3/scalac-mill-moduledefs-plugin_3.8.0-RC2-0.12.3.jar"
      "https://repo1.maven.org/maven2/com/lihaoyi/scalac-mill-moduledefs-plugin_3.8.0-RC2/0.12.3/scalac-mill-moduledefs-plugin_3.8.0-RC2-0.12.3.pom"
    ];
    hash = "sha256-qO1Z3+/z7+jrA94Wl3HX6O8Bayh0kO7pV6ML32M6LQw=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/scalac-mill-moduledefs-plugin_3.8.0-RC2/0.12.3";
  };

  "com.lihaoyi_sourcecode_2.13-0.4.0" = fetchMaven {
    name = "com.lihaoyi_sourcecode_2.13-0.4.0";
    urls = [
      "https://repo1.maven.org/maven2/com/lihaoyi/sourcecode_2.13/0.4.0/sourcecode_2.13-0.4.0.jar"
      "https://repo1.maven.org/maven2/com/lihaoyi/sourcecode_2.13/0.4.0/sourcecode_2.13-0.4.0.pom"
    ];
    hash = "sha256-pi/E3F43hJcUYTx3hqUfOa/SGWmIcCl7z+3vCWDDrXc=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/sourcecode_2.13/0.4.0";
  };

  "com.lihaoyi_sourcecode_3-0.3.0" = fetchMaven {
    name = "com.lihaoyi_sourcecode_3-0.3.0";
    urls = [ "https://repo1.maven.org/maven2/com/lihaoyi/sourcecode_3/0.3.0/sourcecode_3-0.3.0.pom" ];
    hash = "sha256-lr4/nfVXauGgxI2rR6IJs2lPSQkS39mb8QS//1agWtA=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/sourcecode_3/0.3.0";
  };

  "com.lihaoyi_sourcecode_3-0.4.4" = fetchMaven {
    name = "com.lihaoyi_sourcecode_3-0.4.4";
    urls = [
      "https://repo1.maven.org/maven2/com/lihaoyi/sourcecode_3/0.4.4/sourcecode_3-0.4.4.jar"
      "https://repo1.maven.org/maven2/com/lihaoyi/sourcecode_3/0.4.4/sourcecode_3-0.4.4.pom"
    ];
    hash = "sha256-Mb4BGjFreHJodpuyXYAN4MNqYNlNeSQoTWHUnPYdF10=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/sourcecode_3/0.4.4";
  };

  "com.lihaoyi_ujson_2.13-3.3.1" = fetchMaven {
    name = "com.lihaoyi_ujson_2.13-3.3.1";
    urls = [
      "https://repo1.maven.org/maven2/com/lihaoyi/ujson_2.13/3.3.1/ujson_2.13-3.3.1.jar"
      "https://repo1.maven.org/maven2/com/lihaoyi/ujson_2.13/3.3.1/ujson_2.13-3.3.1.pom"
    ];
    hash = "sha256-tS5BVFeMdRfzGHUlrAywtQb4mG6oel56ooMEtlsWGjI=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/ujson_2.13/3.3.1";
  };

  "com.lihaoyi_ujson_3-3.3.1" = fetchMaven {
    name = "com.lihaoyi_ujson_3-3.3.1";
    urls = [
      "https://repo1.maven.org/maven2/com/lihaoyi/ujson_3/3.3.1/ujson_3-3.3.1.jar"
      "https://repo1.maven.org/maven2/com/lihaoyi/ujson_3/3.3.1/ujson_3-3.3.1.pom"
    ];
    hash = "sha256-WBrFmNnzUHJCiuLnaN1JnZAFYKGoD7gbzeFrMljtWj8=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/ujson_3/3.3.1";
  };

  "com.lihaoyi_ujson_3-4.1.0" = fetchMaven {
    name = "com.lihaoyi_ujson_3-4.1.0";
    urls = [ "https://repo1.maven.org/maven2/com/lihaoyi/ujson_3/4.1.0/ujson_3-4.1.0.pom" ];
    hash = "sha256-81N4BDBwyCPnBsl3AmwXUod0pUXCt+9Apy7CWYx3MzU=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/ujson_3/4.1.0";
  };

  "com.lihaoyi_ujson_3-4.4.1" = fetchMaven {
    name = "com.lihaoyi_ujson_3-4.4.1";
    urls = [
      "https://repo1.maven.org/maven2/com/lihaoyi/ujson_3/4.4.1/ujson_3-4.4.1.jar"
      "https://repo1.maven.org/maven2/com/lihaoyi/ujson_3/4.4.1/ujson_3-4.4.1.pom"
    ];
    hash = "sha256-h9dvH5/a3AcrYjeN+uUn9g5atxDcZwG6HLq1P96UAK4=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/ujson_3/4.4.1";
  };

  "com.lihaoyi_unroll-annotation_3-0.2.0" = fetchMaven {
    name = "com.lihaoyi_unroll-annotation_3-0.2.0";
    urls = [
      "https://repo1.maven.org/maven2/com/lihaoyi/unroll-annotation_3/0.2.0/unroll-annotation_3-0.2.0.jar"
      "https://repo1.maven.org/maven2/com/lihaoyi/unroll-annotation_3/0.2.0/unroll-annotation_3-0.2.0.pom"
    ];
    hash = "sha256-ExxiEO3FCd5f41vmo6LitJC46Lq5EBcjLSsFDmrTWLA=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/unroll-annotation_3/0.2.0";
  };

  "com.lihaoyi_upack_2.13-3.3.1" = fetchMaven {
    name = "com.lihaoyi_upack_2.13-3.3.1";
    urls = [
      "https://repo1.maven.org/maven2/com/lihaoyi/upack_2.13/3.3.1/upack_2.13-3.3.1.jar"
      "https://repo1.maven.org/maven2/com/lihaoyi/upack_2.13/3.3.1/upack_2.13-3.3.1.pom"
    ];
    hash = "sha256-rbWiMl6+OXfWP2HjpMbvkToBzWhuW2hsJD/4dd+XmOs=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/upack_2.13/3.3.1";
  };

  "com.lihaoyi_upack_3-3.3.1" = fetchMaven {
    name = "com.lihaoyi_upack_3-3.3.1";
    urls = [
      "https://repo1.maven.org/maven2/com/lihaoyi/upack_3/3.3.1/upack_3-3.3.1.jar"
      "https://repo1.maven.org/maven2/com/lihaoyi/upack_3/3.3.1/upack_3-3.3.1.pom"
    ];
    hash = "sha256-5I+QJF9ahoCA1znfnsfSDwGHhRMh08cjyKNiYw6VGqE=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/upack_3/3.3.1";
  };

  "com.lihaoyi_upack_3-4.1.0" = fetchMaven {
    name = "com.lihaoyi_upack_3-4.1.0";
    urls = [ "https://repo1.maven.org/maven2/com/lihaoyi/upack_3/4.1.0/upack_3-4.1.0.pom" ];
    hash = "sha256-XktB0pPuJtx5Cf58WBajMMlCj44UzofLJTxWkryaqqs=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/upack_3/4.1.0";
  };

  "com.lihaoyi_upack_3-4.4.1" = fetchMaven {
    name = "com.lihaoyi_upack_3-4.4.1";
    urls = [
      "https://repo1.maven.org/maven2/com/lihaoyi/upack_3/4.4.1/upack_3-4.4.1.jar"
      "https://repo1.maven.org/maven2/com/lihaoyi/upack_3/4.4.1/upack_3-4.4.1.pom"
    ];
    hash = "sha256-/VxDA6S90QMHiNC1/KSzDUX+3wDVRHVBpkqgIuuygSM=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/upack_3/4.4.1";
  };

  "com.lihaoyi_upickle-core_2.13-3.3.1" = fetchMaven {
    name = "com.lihaoyi_upickle-core_2.13-3.3.1";
    urls = [
      "https://repo1.maven.org/maven2/com/lihaoyi/upickle-core_2.13/3.3.1/upickle-core_2.13-3.3.1.jar"
      "https://repo1.maven.org/maven2/com/lihaoyi/upickle-core_2.13/3.3.1/upickle-core_2.13-3.3.1.pom"
    ];
    hash = "sha256-+vXjTD3FY+FMlDpvsOkhwycDbvhnIY0SOcHKOYc+StM=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/upickle-core_2.13/3.3.1";
  };

  "com.lihaoyi_upickle-core_3-3.3.1" = fetchMaven {
    name = "com.lihaoyi_upickle-core_3-3.3.1";
    urls = [
      "https://repo1.maven.org/maven2/com/lihaoyi/upickle-core_3/3.3.1/upickle-core_3-3.3.1.jar"
      "https://repo1.maven.org/maven2/com/lihaoyi/upickle-core_3/3.3.1/upickle-core_3-3.3.1.pom"
    ];
    hash = "sha256-ilLrjctjuOu0Qs1RAbjy9uezHXUOfgvMaVuh6ZCNflw=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/upickle-core_3/3.3.1";
  };

  "com.lihaoyi_upickle-core_3-4.1.0" = fetchMaven {
    name = "com.lihaoyi_upickle-core_3-4.1.0";
    urls = [
      "https://repo1.maven.org/maven2/com/lihaoyi/upickle-core_3/4.1.0/upickle-core_3-4.1.0.pom"
    ];
    hash = "sha256-I9NWcyjpsp3yuCSfjxbjeUSC37yA0SIJ2lWqcbVhI3M=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/upickle-core_3/4.1.0";
  };

  "com.lihaoyi_upickle-core_3-4.4.1" = fetchMaven {
    name = "com.lihaoyi_upickle-core_3-4.4.1";
    urls = [
      "https://repo1.maven.org/maven2/com/lihaoyi/upickle-core_3/4.4.1/upickle-core_3-4.4.1.jar"
      "https://repo1.maven.org/maven2/com/lihaoyi/upickle-core_3/4.4.1/upickle-core_3-4.4.1.pom"
    ];
    hash = "sha256-GQUQWUioawbKJulrXSy/XVZO1VlOrX8Qh69qJ3olf3E=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/upickle-core_3/4.4.1";
  };

  "com.lihaoyi_upickle-implicits-named-tuples_3-4.4.1" = fetchMaven {
    name = "com.lihaoyi_upickle-implicits-named-tuples_3-4.4.1";
    urls = [
      "https://repo1.maven.org/maven2/com/lihaoyi/upickle-implicits-named-tuples_3/4.4.1/upickle-implicits-named-tuples_3-4.4.1.jar"
      "https://repo1.maven.org/maven2/com/lihaoyi/upickle-implicits-named-tuples_3/4.4.1/upickle-implicits-named-tuples_3-4.4.1.pom"
    ];
    hash = "sha256-gcgWaUPGZegtC9lJZKcX9yR1wA31WLXj7vTB7D09lak=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/upickle-implicits-named-tuples_3/4.4.1";
  };

  "com.lihaoyi_upickle-implicits_2.13-3.3.1" = fetchMaven {
    name = "com.lihaoyi_upickle-implicits_2.13-3.3.1";
    urls = [
      "https://repo1.maven.org/maven2/com/lihaoyi/upickle-implicits_2.13/3.3.1/upickle-implicits_2.13-3.3.1.jar"
      "https://repo1.maven.org/maven2/com/lihaoyi/upickle-implicits_2.13/3.3.1/upickle-implicits_2.13-3.3.1.pom"
    ];
    hash = "sha256-LKWPAok7DL+YyfLv6yTwuyAG8z/74mzMrsqgUvUw9bM=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/upickle-implicits_2.13/3.3.1";
  };

  "com.lihaoyi_upickle-implicits_3-3.3.1" = fetchMaven {
    name = "com.lihaoyi_upickle-implicits_3-3.3.1";
    urls = [
      "https://repo1.maven.org/maven2/com/lihaoyi/upickle-implicits_3/3.3.1/upickle-implicits_3-3.3.1.jar"
      "https://repo1.maven.org/maven2/com/lihaoyi/upickle-implicits_3/3.3.1/upickle-implicits_3-3.3.1.pom"
    ];
    hash = "sha256-woCFgGb/JC+nZala0DL0reBbVXtdDUaa/lTG219HOHk=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/upickle-implicits_3/3.3.1";
  };

  "com.lihaoyi_upickle-implicits_3-4.1.0" = fetchMaven {
    name = "com.lihaoyi_upickle-implicits_3-4.1.0";
    urls = [
      "https://repo1.maven.org/maven2/com/lihaoyi/upickle-implicits_3/4.1.0/upickle-implicits_3-4.1.0.pom"
    ];
    hash = "sha256-EWGaFGjCykMJuyKtTkCVfnr3hc2+6hwSqdyfZ/v4dr8=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/upickle-implicits_3/4.1.0";
  };

  "com.lihaoyi_upickle-implicits_3-4.4.1" = fetchMaven {
    name = "com.lihaoyi_upickle-implicits_3-4.4.1";
    urls = [
      "https://repo1.maven.org/maven2/com/lihaoyi/upickle-implicits_3/4.4.1/upickle-implicits_3-4.4.1.jar"
      "https://repo1.maven.org/maven2/com/lihaoyi/upickle-implicits_3/4.4.1/upickle-implicits_3-4.4.1.pom"
    ];
    hash = "sha256-w40BuSOs3+gq3QNTupnT+oLpf6LVwvScPiZx2xT4fhY=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/upickle-implicits_3/4.4.1";
  };

  "com.lihaoyi_upickle_2.13-3.3.1" = fetchMaven {
    name = "com.lihaoyi_upickle_2.13-3.3.1";
    urls = [
      "https://repo1.maven.org/maven2/com/lihaoyi/upickle_2.13/3.3.1/upickle_2.13-3.3.1.jar"
      "https://repo1.maven.org/maven2/com/lihaoyi/upickle_2.13/3.3.1/upickle_2.13-3.3.1.pom"
    ];
    hash = "sha256-1vHU3mGQey3zvyUHK9uCx+9pUnpnWe3zEMlyb8QqUFc=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/upickle_2.13/3.3.1";
  };

  "com.lihaoyi_upickle_3-3.3.1" = fetchMaven {
    name = "com.lihaoyi_upickle_3-3.3.1";
    urls = [
      "https://repo1.maven.org/maven2/com/lihaoyi/upickle_3/3.3.1/upickle_3-3.3.1.jar"
      "https://repo1.maven.org/maven2/com/lihaoyi/upickle_3/3.3.1/upickle_3-3.3.1.pom"
    ];
    hash = "sha256-pug2T74XKw35S+3WAI3URsvG6Eq/B8MoAFYM4hvNPPs=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/upickle_3/3.3.1";
  };

  "com.lihaoyi_upickle_3-4.1.0" = fetchMaven {
    name = "com.lihaoyi_upickle_3-4.1.0";
    urls = [ "https://repo1.maven.org/maven2/com/lihaoyi/upickle_3/4.1.0/upickle_3-4.1.0.pom" ];
    hash = "sha256-GQg4FdCE1oaS5ikW6tZYBy1hnglX9Uce6zVcekOS4jo=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/upickle_3/4.1.0";
  };

  "com.lihaoyi_upickle_3-4.4.1" = fetchMaven {
    name = "com.lihaoyi_upickle_3-4.4.1";
    urls = [
      "https://repo1.maven.org/maven2/com/lihaoyi/upickle_3/4.4.1/upickle_3-4.4.1.jar"
      "https://repo1.maven.org/maven2/com/lihaoyi/upickle_3/4.4.1/upickle_3-4.4.1.pom"
    ];
    hash = "sha256-Xc5BWydZyyKXPTn/YO0ldHKsSp7kx7/6vpXePZYgsuI=";
    installPath = "https/repo1.maven.org/maven2/com/lihaoyi/upickle_3/4.4.1";
  };

  "com.lmax_disruptor-3.4.2" = fetchMaven {
    name = "com.lmax_disruptor-3.4.2";
    urls = [
      "https://repo1.maven.org/maven2/com/lmax/disruptor/3.4.2/disruptor-3.4.2.jar"
      "https://repo1.maven.org/maven2/com/lmax/disruptor/3.4.2/disruptor-3.4.2.pom"
    ];
    hash = "sha256-nbZsn6zL8HaJOrkMiWwvCuHQumcNQYA8e6QrAjXKKKg=";
    installPath = "https/repo1.maven.org/maven2/com/lmax/disruptor/3.4.2";
  };

  "com.lumidion_sonatype-central-client-core_3-0.6.0" = fetchMaven {
    name = "com.lumidion_sonatype-central-client-core_3-0.6.0";
    urls = [
      "https://repo1.maven.org/maven2/com/lumidion/sonatype-central-client-core_3/0.6.0/sonatype-central-client-core_3-0.6.0.jar"
      "https://repo1.maven.org/maven2/com/lumidion/sonatype-central-client-core_3/0.6.0/sonatype-central-client-core_3-0.6.0.pom"
    ];
    hash = "sha256-YEkjIQPfrhNzTOyy9wivwhFF/IRA8hBAHAkx+dt2Feg=";
    installPath = "https/repo1.maven.org/maven2/com/lumidion/sonatype-central-client-core_3/0.6.0";
  };

  "com.lumidion_sonatype-central-client-requests_3-0.6.0" = fetchMaven {
    name = "com.lumidion_sonatype-central-client-requests_3-0.6.0";
    urls = [
      "https://repo1.maven.org/maven2/com/lumidion/sonatype-central-client-requests_3/0.6.0/sonatype-central-client-requests_3-0.6.0.jar"
      "https://repo1.maven.org/maven2/com/lumidion/sonatype-central-client-requests_3/0.6.0/sonatype-central-client-requests_3-0.6.0.pom"
    ];
    hash = "sha256-725YZk7xMwtpthJ/lf57xTXkEn+0njn3BdTaoV98nNI=";
    installPath = "https/repo1.maven.org/maven2/com/lumidion/sonatype-central-client-requests_3/0.6.0";
  };

  "com.lumidion_sonatype-central-client-upickle_3-0.6.0" = fetchMaven {
    name = "com.lumidion_sonatype-central-client-upickle_3-0.6.0";
    urls = [
      "https://repo1.maven.org/maven2/com/lumidion/sonatype-central-client-upickle_3/0.6.0/sonatype-central-client-upickle_3-0.6.0.jar"
      "https://repo1.maven.org/maven2/com/lumidion/sonatype-central-client-upickle_3/0.6.0/sonatype-central-client-upickle_3-0.6.0.pom"
    ];
    hash = "sha256-26m05j/d1yXlIpECzcGNyDS4mZE5i9CkbGTmWYEmN3Y=";
    installPath = "https/repo1.maven.org/maven2/com/lumidion/sonatype-central-client-upickle_3/0.6.0";
  };

  "com.openhtmltopdf_openhtmltopdf-core-1.0.10" = fetchMaven {
    name = "com.openhtmltopdf_openhtmltopdf-core-1.0.10";
    urls = [
      "https://repo1.maven.org/maven2/com/openhtmltopdf/openhtmltopdf-core/1.0.10/openhtmltopdf-core-1.0.10.jar"
      "https://repo1.maven.org/maven2/com/openhtmltopdf/openhtmltopdf-core/1.0.10/openhtmltopdf-core-1.0.10.pom"
    ];
    hash = "sha256-eMJiWzyv6bOE1TjYPW2cetH1q8bLrBmtj0IICcFugu8=";
    installPath = "https/repo1.maven.org/maven2/com/openhtmltopdf/openhtmltopdf-core/1.0.10";
  };

  "com.openhtmltopdf_openhtmltopdf-parent-1.0.10" = fetchMaven {
    name = "com.openhtmltopdf_openhtmltopdf-parent-1.0.10";
    urls = [
      "https://repo1.maven.org/maven2/com/openhtmltopdf/openhtmltopdf-parent/1.0.10/openhtmltopdf-parent-1.0.10.pom"
    ];
    hash = "sha256-IZfPUVwVrT5UZyzGqwFpAEUtY4Kv9wJHLd28vU2pDr0=";
    installPath = "https/repo1.maven.org/maven2/com/openhtmltopdf/openhtmltopdf-parent/1.0.10";
  };

  "com.openhtmltopdf_openhtmltopdf-pdfbox-1.0.10" = fetchMaven {
    name = "com.openhtmltopdf_openhtmltopdf-pdfbox-1.0.10";
    urls = [
      "https://repo1.maven.org/maven2/com/openhtmltopdf/openhtmltopdf-pdfbox/1.0.10/openhtmltopdf-pdfbox-1.0.10.jar"
      "https://repo1.maven.org/maven2/com/openhtmltopdf/openhtmltopdf-pdfbox/1.0.10/openhtmltopdf-pdfbox-1.0.10.pom"
    ];
    hash = "sha256-VVZFnitqzGRuCrE6lsqo5JP14KRLK03leOMT18wJt04=";
    installPath = "https/repo1.maven.org/maven2/com/openhtmltopdf/openhtmltopdf-pdfbox/1.0.10";
  };

  "com.openhtmltopdf_openhtmltopdf-rtl-support-1.0.10" = fetchMaven {
    name = "com.openhtmltopdf_openhtmltopdf-rtl-support-1.0.10";
    urls = [
      "https://repo1.maven.org/maven2/com/openhtmltopdf/openhtmltopdf-rtl-support/1.0.10/openhtmltopdf-rtl-support-1.0.10.jar"
      "https://repo1.maven.org/maven2/com/openhtmltopdf/openhtmltopdf-rtl-support/1.0.10/openhtmltopdf-rtl-support-1.0.10.pom"
    ];
    hash = "sha256-q8ru6sYZmSY6550JXzXW92tJ3R0bUiXDoYfyog3Wyus=";
    installPath = "https/repo1.maven.org/maven2/com/openhtmltopdf/openhtmltopdf-rtl-support/1.0.10";
  };

  "com.swoval_file-tree-views-2.1.12" = fetchMaven {
    name = "com.swoval_file-tree-views-2.1.12";
    urls = [
      "https://repo1.maven.org/maven2/com/swoval/file-tree-views/2.1.12/file-tree-views-2.1.12.jar"
      "https://repo1.maven.org/maven2/com/swoval/file-tree-views/2.1.12/file-tree-views-2.1.12.pom"
    ];
    hash = "sha256-QhJJFQt5LS2THa8AyPLrj0suht4eCiAEl2sf7QsZU3I=";
    installPath = "https/repo1.maven.org/maven2/com/swoval/file-tree-views/2.1.12";
  };

  "com.typesafe_config-1.4.3" = fetchMaven {
    name = "com.typesafe_config-1.4.3";
    urls = [
      "https://repo1.maven.org/maven2/com/typesafe/config/1.4.3/config-1.4.3.jar"
      "https://repo1.maven.org/maven2/com/typesafe/config/1.4.3/config-1.4.3.pom"
    ];
    hash = "sha256-pGJKaNOiiCbTyHbP7xVNLx8QJUTcGSMUFvFDc6fePsM=";
    installPath = "https/repo1.maven.org/maven2/com/typesafe/config/1.4.3";
  };

  "guru.nidi_graphviz-java-0.18.1" = fetchMaven {
    name = "guru.nidi_graphviz-java-0.18.1";
    urls = [
      "https://repo1.maven.org/maven2/guru/nidi/graphviz-java/0.18.1/graphviz-java-0.18.1.jar"
      "https://repo1.maven.org/maven2/guru/nidi/graphviz-java/0.18.1/graphviz-java-0.18.1.pom"
    ];
    hash = "sha256-Aq/u1Ss6/IoutsGna1uDSZ/+QNdDjfZmDZDh49OHNGs=";
    installPath = "https/repo1.maven.org/maven2/guru/nidi/graphviz-java/0.18.1";
  };

  "guru.nidi_graphviz-java-min-deps-0.18.1" = fetchMaven {
    name = "guru.nidi_graphviz-java-min-deps-0.18.1";
    urls = [
      "https://repo1.maven.org/maven2/guru/nidi/graphviz-java-min-deps/0.18.1/graphviz-java-min-deps-0.18.1.jar"
      "https://repo1.maven.org/maven2/guru/nidi/graphviz-java-min-deps/0.18.1/graphviz-java-min-deps-0.18.1.pom"
    ];
    hash = "sha256-IJXiFPcJ1+FIHyUzXJWIWBecUp1qj2OcmQaHpUBpXKs=";
    installPath = "https/repo1.maven.org/maven2/guru/nidi/graphviz-java-min-deps/0.18.1";
  };

  "guru.nidi_graphviz-java-parent-0.18.1" = fetchMaven {
    name = "guru.nidi_graphviz-java-parent-0.18.1";
    urls = [
      "https://repo1.maven.org/maven2/guru/nidi/graphviz-java-parent/0.18.1/graphviz-java-parent-0.18.1.pom"
    ];
    hash = "sha256-wjX7phg6GsC6AsCunFDeqktfCfHi0oW3WjsCNnBl8oQ=";
    installPath = "https/repo1.maven.org/maven2/guru/nidi/graphviz-java-parent/0.18.1";
  };

  "guru.nidi_guru-nidi-parent-pom-1.1.36" = fetchMaven {
    name = "guru.nidi_guru-nidi-parent-pom-1.1.36";
    urls = [
      "https://repo1.maven.org/maven2/guru/nidi/guru-nidi-parent-pom/1.1.36/guru-nidi-parent-pom-1.1.36.pom"
    ];
    hash = "sha256-RywUAzcemtEHr3u6CYSTBA+NjVhrUilz8bM/EjOnBpE=";
    installPath = "https/repo1.maven.org/maven2/guru/nidi/guru-nidi-parent-pom/1.1.36";
  };

  "io.airlift_airbase-112" = fetchMaven {
    name = "io.airlift_airbase-112";
    urls = [ "https://repo1.maven.org/maven2/io/airlift/airbase/112/airbase-112.pom" ];
    hash = "sha256-I3jUuyAfPGbPcF0yDH+fa8l5rouZdvucoXg8tMLt174=";
    installPath = "https/repo1.maven.org/maven2/io/airlift/airbase/112";
  };

  "io.airlift_aircompressor-0.27" = fetchMaven {
    name = "io.airlift_aircompressor-0.27";
    urls = [
      "https://repo1.maven.org/maven2/io/airlift/aircompressor/0.27/aircompressor-0.27.jar"
      "https://repo1.maven.org/maven2/io/airlift/aircompressor/0.27/aircompressor-0.27.pom"
    ];
    hash = "sha256-mxNNsdJ5O/jd2kv4pEyG7kFfnxLqrYDMPtxys0c1wuM=";
    installPath = "https/repo1.maven.org/maven2/io/airlift/aircompressor/0.27";
  };

  "io.circe_circe-core_3-0.14.6" = fetchMaven {
    name = "io.circe_circe-core_3-0.14.6";
    urls = [
      "https://repo1.maven.org/maven2/io/circe/circe-core_3/0.14.6/circe-core_3-0.14.6.jar"
      "https://repo1.maven.org/maven2/io/circe/circe-core_3/0.14.6/circe-core_3-0.14.6.pom"
    ];
    hash = "sha256-DbV8AQX+yGxcmBdWGAJiaL/S30lenOg+TNK8ppwhK/8=";
    installPath = "https/repo1.maven.org/maven2/io/circe/circe-core_3/0.14.6";
  };

  "io.circe_circe-generic_3-0.14.6" = fetchMaven {
    name = "io.circe_circe-generic_3-0.14.6";
    urls = [
      "https://repo1.maven.org/maven2/io/circe/circe-generic_3/0.14.6/circe-generic_3-0.14.6.jar"
      "https://repo1.maven.org/maven2/io/circe/circe-generic_3/0.14.6/circe-generic_3-0.14.6.pom"
    ];
    hash = "sha256-vmTYDJ6B7nIP7LHqrMeP6V79/9HJI0Nqmn1YJfLIngI=";
    installPath = "https/repo1.maven.org/maven2/io/circe/circe-generic_3/0.14.6";
  };

  "io.circe_circe-jawn_3-0.14.6" = fetchMaven {
    name = "io.circe_circe-jawn_3-0.14.6";
    urls = [
      "https://repo1.maven.org/maven2/io/circe/circe-jawn_3/0.14.6/circe-jawn_3-0.14.6.jar"
      "https://repo1.maven.org/maven2/io/circe/circe-jawn_3/0.14.6/circe-jawn_3-0.14.6.pom"
    ];
    hash = "sha256-YEdAdZkTNJtPik2Vod7xDJqAnpiArDdHeDL54gj6F0w=";
    installPath = "https/repo1.maven.org/maven2/io/circe/circe-jawn_3/0.14.6";
  };

  "io.circe_circe-numbers_3-0.14.6" = fetchMaven {
    name = "io.circe_circe-numbers_3-0.14.6";
    urls = [
      "https://repo1.maven.org/maven2/io/circe/circe-numbers_3/0.14.6/circe-numbers_3-0.14.6.jar"
      "https://repo1.maven.org/maven2/io/circe/circe-numbers_3/0.14.6/circe-numbers_3-0.14.6.pom"
    ];
    hash = "sha256-GPvzx1ODXA6mJm5uZZoCf9Oa+CEjXfxpVN4KfouKtsc=";
    installPath = "https/repo1.maven.org/maven2/io/circe/circe-numbers_3/0.14.6";
  };

  "io.get-coursier_cache-util-2.1.25-M20" = fetchMaven {
    name = "io.get-coursier_cache-util-2.1.25-M20";
    urls = [
      "https://repo1.maven.org/maven2/io/get-coursier/cache-util/2.1.25-M20/cache-util-2.1.25-M20.jar"
      "https://repo1.maven.org/maven2/io/get-coursier/cache-util/2.1.25-M20/cache-util-2.1.25-M20.pom"
    ];
    hash = "sha256-46jCRTQLd15+R/G96GegZrs/sHbwLdsdRYRunPsUT3g=";
    installPath = "https/repo1.maven.org/maven2/io/get-coursier/cache-util/2.1.25-M20";
  };

  "io.get-coursier_coursier-archive-cache_2.13-2.1.25-M20" = fetchMaven {
    name = "io.get-coursier_coursier-archive-cache_2.13-2.1.25-M20";
    urls = [
      "https://repo1.maven.org/maven2/io/get-coursier/coursier-archive-cache_2.13/2.1.25-M20/coursier-archive-cache_2.13-2.1.25-M20.jar"
      "https://repo1.maven.org/maven2/io/get-coursier/coursier-archive-cache_2.13/2.1.25-M20/coursier-archive-cache_2.13-2.1.25-M20.pom"
    ];
    hash = "sha256-XrfM54HkizHR4tiwWXai8wTuCaXqyaRnBP0cvO0Xr30=";
    installPath = "https/repo1.maven.org/maven2/io/get-coursier/coursier-archive-cache_2.13/2.1.25-M20";
  };

  "io.get-coursier_coursier-cache_2.13-2.1.25-M20" = fetchMaven {
    name = "io.get-coursier_coursier-cache_2.13-2.1.25-M20";
    urls = [
      "https://repo1.maven.org/maven2/io/get-coursier/coursier-cache_2.13/2.1.25-M20/coursier-cache_2.13-2.1.25-M20.jar"
      "https://repo1.maven.org/maven2/io/get-coursier/coursier-cache_2.13/2.1.25-M20/coursier-cache_2.13-2.1.25-M20.pom"
    ];
    hash = "sha256-/vfe1XwFlNKmH7lFXTHXxCKIapyfRJIHJAf6nVqKKa8=";
    installPath = "https/repo1.maven.org/maven2/io/get-coursier/coursier-cache_2.13/2.1.25-M20";
  };

  "io.get-coursier_coursier-core_2.13-2.1.25-M20" = fetchMaven {
    name = "io.get-coursier_coursier-core_2.13-2.1.25-M20";
    urls = [
      "https://repo1.maven.org/maven2/io/get-coursier/coursier-core_2.13/2.1.25-M20/coursier-core_2.13-2.1.25-M20.jar"
      "https://repo1.maven.org/maven2/io/get-coursier/coursier-core_2.13/2.1.25-M20/coursier-core_2.13-2.1.25-M20.pom"
    ];
    hash = "sha256-hftgKgB2HuIIR0d3+IUQT6oe2XXWR9WJtbpc+JaafV4=";
    installPath = "https/repo1.maven.org/maven2/io/get-coursier/coursier-core_2.13/2.1.25-M20";
  };

  "io.get-coursier_coursier-env_2.13-2.1.25-M20" = fetchMaven {
    name = "io.get-coursier_coursier-env_2.13-2.1.25-M20";
    urls = [
      "https://repo1.maven.org/maven2/io/get-coursier/coursier-env_2.13/2.1.25-M20/coursier-env_2.13-2.1.25-M20.jar"
      "https://repo1.maven.org/maven2/io/get-coursier/coursier-env_2.13/2.1.25-M20/coursier-env_2.13-2.1.25-M20.pom"
    ];
    hash = "sha256-LfhE2koHB3Yrmw6GQCJcgDa32JaoTJTSQWaLAi2D+D4=";
    installPath = "https/repo1.maven.org/maven2/io/get-coursier/coursier-env_2.13/2.1.25-M20";
  };

  "io.get-coursier_coursier-exec-2.1.25-M20" = fetchMaven {
    name = "io.get-coursier_coursier-exec-2.1.25-M20";
    urls = [
      "https://repo1.maven.org/maven2/io/get-coursier/coursier-exec/2.1.25-M20/coursier-exec-2.1.25-M20.jar"
      "https://repo1.maven.org/maven2/io/get-coursier/coursier-exec/2.1.25-M20/coursier-exec-2.1.25-M20.pom"
    ];
    hash = "sha256-cn6j2OR17THRaNmiTXjmqCLaE5BSCmeT6s/xqUngjB0=";
    installPath = "https/repo1.maven.org/maven2/io/get-coursier/coursier-exec/2.1.25-M20";
  };

  "io.get-coursier_coursier-jvm_2.13-2.1.25-M20" = fetchMaven {
    name = "io.get-coursier_coursier-jvm_2.13-2.1.25-M20";
    urls = [
      "https://repo1.maven.org/maven2/io/get-coursier/coursier-jvm_2.13/2.1.25-M20/coursier-jvm_2.13-2.1.25-M20.jar"
      "https://repo1.maven.org/maven2/io/get-coursier/coursier-jvm_2.13/2.1.25-M20/coursier-jvm_2.13-2.1.25-M20.pom"
    ];
    hash = "sha256-sU0VolzY5ESfGUrjoMgjgzCLHyU/Nr1PC9BeYMNnFts=";
    installPath = "https/repo1.maven.org/maven2/io/get-coursier/coursier-jvm_2.13/2.1.25-M20";
  };

  "io.get-coursier_coursier-paths-2.1.25-M20" = fetchMaven {
    name = "io.get-coursier_coursier-paths-2.1.25-M20";
    urls = [
      "https://repo1.maven.org/maven2/io/get-coursier/coursier-paths/2.1.25-M20/coursier-paths-2.1.25-M20.jar"
      "https://repo1.maven.org/maven2/io/get-coursier/coursier-paths/2.1.25-M20/coursier-paths-2.1.25-M20.pom"
    ];
    hash = "sha256-skXeu0xS0Zs68BuvOpZ6mU3jl18SJEOVRhLScTW6J+o=";
    installPath = "https/repo1.maven.org/maven2/io/get-coursier/coursier-paths/2.1.25-M20";
  };

  "io.get-coursier_coursier-proxy-setup-2.1.25-M20" = fetchMaven {
    name = "io.get-coursier_coursier-proxy-setup-2.1.25-M20";
    urls = [
      "https://repo1.maven.org/maven2/io/get-coursier/coursier-proxy-setup/2.1.25-M20/coursier-proxy-setup-2.1.25-M20.jar"
      "https://repo1.maven.org/maven2/io/get-coursier/coursier-proxy-setup/2.1.25-M20/coursier-proxy-setup-2.1.25-M20.pom"
    ];
    hash = "sha256-bzpmLtWiP2xCdxwnDzqAKc324FLvVde6DaYDCIlN1wM=";
    installPath = "https/repo1.maven.org/maven2/io/get-coursier/coursier-proxy-setup/2.1.25-M20";
  };

  "io.get-coursier_coursier-util_2.13-2.1.25-M20" = fetchMaven {
    name = "io.get-coursier_coursier-util_2.13-2.1.25-M20";
    urls = [
      "https://repo1.maven.org/maven2/io/get-coursier/coursier-util_2.13/2.1.25-M20/coursier-util_2.13-2.1.25-M20.jar"
      "https://repo1.maven.org/maven2/io/get-coursier/coursier-util_2.13/2.1.25-M20/coursier-util_2.13-2.1.25-M20.pom"
    ];
    hash = "sha256-oT4JvOvf4yHzVpNR1APg1NwWPsQw3qYXpjA3W2TqBHs=";
    installPath = "https/repo1.maven.org/maven2/io/get-coursier/coursier-util_2.13/2.1.25-M20";
  };

  "io.get-coursier_coursier_2.13-2.1.25-M20" = fetchMaven {
    name = "io.get-coursier_coursier_2.13-2.1.25-M20";
    urls = [
      "https://repo1.maven.org/maven2/io/get-coursier/coursier_2.13/2.1.25-M20/coursier_2.13-2.1.25-M20.jar"
      "https://repo1.maven.org/maven2/io/get-coursier/coursier_2.13/2.1.25-M20/coursier_2.13-2.1.25-M20.pom"
    ];
    hash = "sha256-h6b+rvxmuJ56VBXQd/w+1XCkoruwli/F505/Ax9jRIE=";
    installPath = "https/repo1.maven.org/maven2/io/get-coursier/coursier_2.13/2.1.25-M20";
  };

  "io.get-coursier_dependency_2.13-0.3.2" = fetchMaven {
    name = "io.get-coursier_dependency_2.13-0.3.2";
    urls = [
      "https://repo1.maven.org/maven2/io/get-coursier/dependency_2.13/0.3.2/dependency_2.13-0.3.2.jar"
      "https://repo1.maven.org/maven2/io/get-coursier/dependency_2.13/0.3.2/dependency_2.13-0.3.2.pom"
    ];
    hash = "sha256-kLCTLMEFNrY74GFqcr7Vw/qEbR7CPpskXrpzbbH0gMg=";
    installPath = "https/repo1.maven.org/maven2/io/get-coursier/dependency_2.13/0.3.2";
  };

  "io.get-coursier_interface-1.0.28" = fetchMaven {
    name = "io.get-coursier_interface-1.0.28";
    urls = [
      "https://repo1.maven.org/maven2/io/get-coursier/interface/1.0.28/interface-1.0.28.jar"
      "https://repo1.maven.org/maven2/io/get-coursier/interface/1.0.28/interface-1.0.28.pom"
    ];
    hash = "sha256-ilqO9pRagNeDDD9UlIXzkEXhBZEJQNLyGU/FzBhqgaY=";
    installPath = "https/repo1.maven.org/maven2/io/get-coursier/interface/1.0.28";
  };

  "io.get-coursier_versions_2.13-0.5.1" = fetchMaven {
    name = "io.get-coursier_versions_2.13-0.5.1";
    urls = [
      "https://repo1.maven.org/maven2/io/get-coursier/versions_2.13/0.5.1/versions_2.13-0.5.1.jar"
      "https://repo1.maven.org/maven2/io/get-coursier/versions_2.13/0.5.1/versions_2.13-0.5.1.pom"
    ];
    hash = "sha256-1ryxcGeeUu18sLY4gL2cDVfOkh59oRPmNnIA0N2G1/Y=";
    installPath = "https/repo1.maven.org/maven2/io/get-coursier/versions_2.13/0.5.1";
  };

  "io.methvin_directory-watcher-0.19.1" = fetchMaven {
    name = "io.methvin_directory-watcher-0.19.1";
    urls = [
      "https://repo1.maven.org/maven2/io/methvin/directory-watcher/0.19.1/directory-watcher-0.19.1.jar"
      "https://repo1.maven.org/maven2/io/methvin/directory-watcher/0.19.1/directory-watcher-0.19.1.pom"
    ];
    hash = "sha256-+py6iwvAZIvr9vkXZiOwvi0TuPufiBIzYjkj0CzoTrM=";
    installPath = "https/repo1.maven.org/maven2/io/methvin/directory-watcher/0.19.1";
  };

  "io.netty_netty-bom-4.2.3.Final" = fetchMaven {
    name = "io.netty_netty-bom-4.2.3.Final";
    urls = [
      "https://repo1.maven.org/maven2/io/netty/netty-bom/4.2.3.Final/netty-bom-4.2.3.Final.pom"
    ];
    hash = "sha256-ENiE6QvxNsoN86CyyIh+FXodC4eZpLaXiTl4vTZDRN8=";
    installPath = "https/repo1.maven.org/maven2/io/netty/netty-bom/4.2.3.Final";
  };

  "io.undertow_undertow-core-2.2.30.Final" = fetchMaven {
    name = "io.undertow_undertow-core-2.2.30.Final";
    urls = [
      "https://repo1.maven.org/maven2/io/undertow/undertow-core/2.2.30.Final/undertow-core-2.2.30.Final.jar"
      "https://repo1.maven.org/maven2/io/undertow/undertow-core/2.2.30.Final/undertow-core-2.2.30.Final.pom"
    ];
    hash = "sha256-ElcNbmU35DsNNkomYMPjliG9sQaJPmn/1uMjteVQsMg=";
    installPath = "https/repo1.maven.org/maven2/io/undertow/undertow-core/2.2.30.Final";
  };

  "io.undertow_undertow-parent-2.2.30.Final" = fetchMaven {
    name = "io.undertow_undertow-parent-2.2.30.Final";
    urls = [
      "https://repo1.maven.org/maven2/io/undertow/undertow-parent/2.2.30.Final/undertow-parent-2.2.30.Final.pom"
    ];
    hash = "sha256-8FKDgkXIzj/wXav43A3YNSspRDWdClSZu8WtV9Rfr80=";
    installPath = "https/repo1.maven.org/maven2/io/undertow/undertow-parent/2.2.30.Final";
  };

  "jakarta.inject_jakarta.inject-api-2.0.1" = fetchMaven {
    name = "jakarta.inject_jakarta.inject-api-2.0.1";
    urls = [
      "https://repo1.maven.org/maven2/jakarta/inject/jakarta.inject-api/2.0.1/jakarta.inject-api-2.0.1.jar"
      "https://repo1.maven.org/maven2/jakarta/inject/jakarta.inject-api/2.0.1/jakarta.inject-api-2.0.1.pom"
    ];
    hash = "sha256-iAdQB/hIT0wm3DoIY38AP+ZlZJbScDqjjwT+AfAQ52w=";
    installPath = "https/repo1.maven.org/maven2/jakarta/inject/jakarta.inject-api/2.0.1";
  };

  "jakarta.platform_jakarta.jakartaee-bom-9.1.0" = fetchMaven {
    name = "jakarta.platform_jakarta.jakartaee-bom-9.1.0";
    urls = [
      "https://repo1.maven.org/maven2/jakarta/platform/jakarta.jakartaee-bom/9.1.0/jakarta.jakartaee-bom-9.1.0.pom"
    ];
    hash = "sha256-kstGe15Yw9oF6LQ3Vovx1PcCUfQtNaEM7T8E5Upp1gg=";
    installPath = "https/repo1.maven.org/maven2/jakarta/platform/jakarta.jakartaee-bom/9.1.0";
  };

  "jakarta.platform_jakartaee-api-parent-9.1.0" = fetchMaven {
    name = "jakarta.platform_jakartaee-api-parent-9.1.0";
    urls = [
      "https://repo1.maven.org/maven2/jakarta/platform/jakartaee-api-parent/9.1.0/jakartaee-api-parent-9.1.0.pom"
    ];
    hash = "sha256-FrD7N30UkkRSQtD3+FPOC1fH2qrNnJw6UZQ/hNFXWrA=";
    installPath = "https/repo1.maven.org/maven2/jakarta/platform/jakartaee-api-parent/9.1.0";
  };

  "javax.inject_javax.inject-1" = fetchMaven {
    name = "javax.inject_javax.inject-1";
    urls = [
      "https://repo1.maven.org/maven2/javax/inject/javax.inject/1/javax.inject-1.jar"
      "https://repo1.maven.org/maven2/javax/inject/javax.inject/1/javax.inject-1.pom"
    ];
    hash = "sha256-CZm6Lb7D5az8nprqBvjNerGQjB0xPaY56/RvKwSZIxE=";
    installPath = "https/repo1.maven.org/maven2/javax/inject/javax.inject/1";
  };

  "net.openhft_java-parent-pom-1.1.28" = fetchMaven {
    name = "net.openhft_java-parent-pom-1.1.28";
    urls = [
      "https://repo1.maven.org/maven2/net/openhft/java-parent-pom/1.1.28/java-parent-pom-1.1.28.pom"
    ];
    hash = "sha256-d7bOKP/hHJElmDQtIbblYDHRc8LCpqkt5Zl8aHp7l88=";
    installPath = "https/repo1.maven.org/maven2/net/openhft/java-parent-pom/1.1.28";
  };

  "net.openhft_root-parent-pom-1.2.12" = fetchMaven {
    name = "net.openhft_root-parent-pom-1.2.12";
    urls = [
      "https://repo1.maven.org/maven2/net/openhft/root-parent-pom/1.2.12/root-parent-pom-1.2.12.pom"
    ];
    hash = "sha256-D/M1qN+njmMZWqS5h27fl83Q+zWgIFjaYQkCpD2Oy/M=";
    installPath = "https/repo1.maven.org/maven2/net/openhft/root-parent-pom/1.2.12";
  };

  "net.openhft_zero-allocation-hashing-0.16" = fetchMaven {
    name = "net.openhft_zero-allocation-hashing-0.16";
    urls = [
      "https://repo1.maven.org/maven2/net/openhft/zero-allocation-hashing/0.16/zero-allocation-hashing-0.16.jar"
      "https://repo1.maven.org/maven2/net/openhft/zero-allocation-hashing/0.16/zero-allocation-hashing-0.16.pom"
    ];
    hash = "sha256-QkNOGkyP/OFWM+pv40hqR+ii4GBAcv0bbIrpG66YDMo=";
    installPath = "https/repo1.maven.org/maven2/net/openhft/zero-allocation-hashing/0.16";
  };

  "nl.big-o_liqp-0.8.2" = fetchMaven {
    name = "nl.big-o_liqp-0.8.2";
    urls = [
      "https://repo1.maven.org/maven2/nl/big-o/liqp/0.8.2/liqp-0.8.2.jar"
      "https://repo1.maven.org/maven2/nl/big-o/liqp/0.8.2/liqp-0.8.2.pom"
    ];
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
    urls = [
      "https://repo1.maven.org/maven2/org/antlr/antlr4-runtime/4.7.2/antlr4-runtime-4.7.2.jar"
      "https://repo1.maven.org/maven2/org/antlr/antlr4-runtime/4.7.2/antlr4-runtime-4.7.2.pom"
    ];
    hash = "sha256-orSo+dX/By8iQ7guGqi/mScUKmFeAp2TizPRFWLVUvY=";
    installPath = "https/repo1.maven.org/maven2/org/antlr/antlr4-runtime/4.7.2";
  };

  "org.apache_apache-13" = fetchMaven {
    name = "org.apache_apache-13";
    urls = [ "https://repo1.maven.org/maven2/org/apache/apache/13/apache-13.pom" ];
    hash = "sha256-sACBC2XyW8OQOMbX09EPCVL/lqUvROHaHHHiQ3XpTk4=";
    installPath = "https/repo1.maven.org/maven2/org/apache/apache/13";
  };

  "org.apache_apache-16" = fetchMaven {
    name = "org.apache_apache-16";
    urls = [ "https://repo1.maven.org/maven2/org/apache/apache/16/apache-16.pom" ];
    hash = "sha256-Ffy1Lw2d5Roxr4FhpSRU4zow5rkuKRQB6kMvH52swiQ=";
    installPath = "https/repo1.maven.org/maven2/org/apache/apache/16";
  };

  "org.apache_apache-19" = fetchMaven {
    name = "org.apache_apache-19";
    urls = [ "https://repo1.maven.org/maven2/org/apache/apache/19/apache-19.pom" ];
    hash = "sha256-zhBKa7d1483sjfmn+XnLUQgYZltXXBPJayIZ44PcKHo=";
    installPath = "https/repo1.maven.org/maven2/org/apache/apache/19";
  };

  "org.apache_apache-21" = fetchMaven {
    name = "org.apache_apache-21";
    urls = [ "https://repo1.maven.org/maven2/org/apache/apache/21/apache-21.pom" ];
    hash = "sha256-MPUeMZwdZMHG1C0GXZccscBBWCLtZ1g5b/1YTKeRLjY=";
    installPath = "https/repo1.maven.org/maven2/org/apache/apache/21";
  };

  "org.apache_apache-29" = fetchMaven {
    name = "org.apache_apache-29";
    urls = [ "https://repo1.maven.org/maven2/org/apache/apache/29/apache-29.pom" ];
    hash = "sha256-g3GCmmilviP9RsFiwyNjDn6Ta+vWtn7Y/WgvU75pUlY=";
    installPath = "https/repo1.maven.org/maven2/org/apache/apache/29";
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

  "org.apache_apache-35" = fetchMaven {
    name = "org.apache_apache-35";
    urls = [ "https://repo1.maven.org/maven2/org/apache/apache/35/apache-35.pom" ];
    hash = "sha256-Xi9qlMJKcB7Oc/RDG74Xmum5LLz6PVSIREBESM2qPbQ=";
    installPath = "https/repo1.maven.org/maven2/org/apache/apache/35";
  };

  "org.apache_apache-6" = fetchMaven {
    name = "org.apache_apache-6";
    urls = [ "https://repo1.maven.org/maven2/org/apache/apache/6/apache-6.pom" ];
    hash = "sha256-A7aDRlGjS4P3/QlZmvMRdVHhP4yqTFL4wZbRnp1lJ9U=";
    installPath = "https/repo1.maven.org/maven2/org/apache/apache/6";
  };

  "org.checkerframework_checker-qual-3.5.0" = fetchMaven {
    name = "org.checkerframework_checker-qual-3.5.0";
    urls = [
      "https://repo1.maven.org/maven2/org/checkerframework/checker-qual/3.5.0/checker-qual-3.5.0.jar"
      "https://repo1.maven.org/maven2/org/checkerframework/checker-qual/3.5.0/checker-qual-3.5.0.pom"
    ];
    hash = "sha256-7lxlpTC52iRt4ZSq/jCM3ohl9uRC4V8WTpNF+DLWZrU=";
    installPath = "https/repo1.maven.org/maven2/org/checkerframework/checker-qual/3.5.0";
  };

  "org.chipsalliance_firtool-resolver_2.13-2.0.1" = fetchMaven {
    name = "org.chipsalliance_firtool-resolver_2.13-2.0.1";
    urls = [
      "https://repo1.maven.org/maven2/org/chipsalliance/firtool-resolver_2.13/2.0.1/firtool-resolver_2.13-2.0.1.jar"
      "https://repo1.maven.org/maven2/org/chipsalliance/firtool-resolver_2.13/2.0.1/firtool-resolver_2.13-2.0.1.pom"
    ];
    hash = "sha256-CGJ1TtugVYKbdzR1NWZunPLyxQRgKZPGQPWhTOGOeHI=";
    installPath = "https/repo1.maven.org/maven2/org/chipsalliance/firtool-resolver_2.13/2.0.1";
  };

  "org.fusesource_fusesource-pom-1.12" = fetchMaven {
    name = "org.fusesource_fusesource-pom-1.12";
    urls = [
      "https://repo1.maven.org/maven2/org/fusesource/fusesource-pom/1.12/fusesource-pom-1.12.pom"
    ];
    hash = "sha256-NUD5PZ1FYYOq8yumvT5i29Vxd2ZCI6PXImXfLe4mE30=";
    installPath = "https/repo1.maven.org/maven2/org/fusesource/fusesource-pom/1.12";
  };

  "org.http4s_http4s-circe_3-0.23.25" = fetchMaven {
    name = "org.http4s_http4s-circe_3-0.23.25";
    urls = [
      "https://repo1.maven.org/maven2/org/http4s/http4s-circe_3/0.23.25/http4s-circe_3-0.23.25.jar"
      "https://repo1.maven.org/maven2/org/http4s/http4s-circe_3/0.23.25/http4s-circe_3-0.23.25.pom"
    ];
    hash = "sha256-+8ORQzNCq67AY1vGQaqIXe2YKqG+dstWcBIj/9hKXhg=";
    installPath = "https/repo1.maven.org/maven2/org/http4s/http4s-circe_3/0.23.25";
  };

  "org.http4s_http4s-client_3-0.23.25" = fetchMaven {
    name = "org.http4s_http4s-client_3-0.23.25";
    urls = [
      "https://repo1.maven.org/maven2/org/http4s/http4s-client_3/0.23.25/http4s-client_3-0.23.25.jar"
      "https://repo1.maven.org/maven2/org/http4s/http4s-client_3/0.23.25/http4s-client_3-0.23.25.pom"
    ];
    hash = "sha256-+EZTHKdM3RfgxwgT9eE9xxVfsmYYWSftA6XIcVgsoaA=";
    installPath = "https/repo1.maven.org/maven2/org/http4s/http4s-client_3/0.23.25";
  };

  "org.http4s_http4s-core_3-0.23.25" = fetchMaven {
    name = "org.http4s_http4s-core_3-0.23.25";
    urls = [
      "https://repo1.maven.org/maven2/org/http4s/http4s-core_3/0.23.25/http4s-core_3-0.23.25.jar"
      "https://repo1.maven.org/maven2/org/http4s/http4s-core_3/0.23.25/http4s-core_3-0.23.25.pom"
    ];
    hash = "sha256-w1fZAEeSNjq2BSdHFQEFzACusTmsbG8sJNRQql+lL78=";
    installPath = "https/repo1.maven.org/maven2/org/http4s/http4s-core_3/0.23.25";
  };

  "org.http4s_http4s-crypto_3-0.2.4" = fetchMaven {
    name = "org.http4s_http4s-crypto_3-0.2.4";
    urls = [
      "https://repo1.maven.org/maven2/org/http4s/http4s-crypto_3/0.2.4/http4s-crypto_3-0.2.4.jar"
      "https://repo1.maven.org/maven2/org/http4s/http4s-crypto_3/0.2.4/http4s-crypto_3-0.2.4.pom"
    ];
    hash = "sha256-oNkdLswvq/2BQSsnncbGXvk/fzw78Cku8ycWFVJzXHs=";
    installPath = "https/repo1.maven.org/maven2/org/http4s/http4s-crypto_3/0.2.4";
  };

  "org.http4s_http4s-jawn_3-0.23.25" = fetchMaven {
    name = "org.http4s_http4s-jawn_3-0.23.25";
    urls = [
      "https://repo1.maven.org/maven2/org/http4s/http4s-jawn_3/0.23.25/http4s-jawn_3-0.23.25.jar"
      "https://repo1.maven.org/maven2/org/http4s/http4s-jawn_3/0.23.25/http4s-jawn_3-0.23.25.pom"
    ];
    hash = "sha256-wCyXPwWH7GwDp78XBGGfFkYyLdpANiUiAn231T5bqGw=";
    installPath = "https/repo1.maven.org/maven2/org/http4s/http4s-jawn_3/0.23.25";
  };

  "org.jboss_jboss-parent-23" = fetchMaven {
    name = "org.jboss_jboss-parent-23";
    urls = [ "https://repo1.maven.org/maven2/org/jboss/jboss-parent/23/jboss-parent-23.pom" ];
    hash = "sha256-NmkKsTbW8td3q4leFJinAt6IeqwtIi0cuUbsjpNyBCs=";
    installPath = "https/repo1.maven.org/maven2/org/jboss/jboss-parent/23";
  };

  "org.jboss_jboss-parent-34" = fetchMaven {
    name = "org.jboss_jboss-parent-34";
    urls = [ "https://repo1.maven.org/maven2/org/jboss/jboss-parent/34/jboss-parent-34.pom" ];
    hash = "sha256-TgbquaeRtRsZIozVtie6s0k9NM534WnDNbqu+/unM04=";
    installPath = "https/repo1.maven.org/maven2/org/jboss/jboss-parent/34";
  };

  "org.jboss_jboss-parent-35" = fetchMaven {
    name = "org.jboss_jboss-parent-35";
    urls = [ "https://repo1.maven.org/maven2/org/jboss/jboss-parent/35/jboss-parent-35.pom" ];
    hash = "sha256-dBipKKOVeA+QsqHm/ndBTRYyCYcqCLUOcx8rO3GZBvY=";
    installPath = "https/repo1.maven.org/maven2/org/jboss/jboss-parent/35";
  };

  "org.jboss_jboss-parent-36" = fetchMaven {
    name = "org.jboss_jboss-parent-36";
    urls = [ "https://repo1.maven.org/maven2/org/jboss/jboss-parent/36/jboss-parent-36.pom" ];
    hash = "sha256-q8N3JNtfAL7fx00KqtUmyir4NOKdP10JbclYN+KDMLw=";
    installPath = "https/repo1.maven.org/maven2/org/jboss/jboss-parent/36";
  };

  "org.jboss_jboss-parent-39" = fetchMaven {
    name = "org.jboss_jboss-parent-39";
    urls = [ "https://repo1.maven.org/maven2/org/jboss/jboss-parent/39/jboss-parent-39.pom" ];
    hash = "sha256-iGyoeNg1UuXVm1Vp1B8uEYgoo8ZQs9tMTPwTt9tTNfM=";
    installPath = "https/repo1.maven.org/maven2/org/jboss/jboss-parent/39";
  };

  "org.jboss_jboss-parent-43" = fetchMaven {
    name = "org.jboss_jboss-parent-43";
    urls = [ "https://repo1.maven.org/maven2/org/jboss/jboss-parent/43/jboss-parent-43.pom" ];
    hash = "sha256-Yo2fv3pSFZhbjErJZbnRrMMYLLOGpxNWwWkbvo5MjK4=";
    installPath = "https/repo1.maven.org/maven2/org/jboss/jboss-parent/43";
  };

  "org.jetbrains_annotations-15.0" = fetchMaven {
    name = "org.jetbrains_annotations-15.0";
    urls = [
      "https://repo1.maven.org/maven2/org/jetbrains/annotations/15.0/annotations-15.0.jar"
      "https://repo1.maven.org/maven2/org/jetbrains/annotations/15.0/annotations-15.0.pom"
    ];
    hash = "sha256-zKx9CDgM9iLkt5SFNiSgDzJu9AxFNPjCFWwMi9copnI=";
    installPath = "https/repo1.maven.org/maven2/org/jetbrains/annotations/15.0";
  };

  "org.jetbrains_annotations-24.0.1" = fetchMaven {
    name = "org.jetbrains_annotations-24.0.1";
    urls = [
      "https://repo1.maven.org/maven2/org/jetbrains/annotations/24.0.1/annotations-24.0.1.jar"
      "https://repo1.maven.org/maven2/org/jetbrains/annotations/24.0.1/annotations-24.0.1.pom"
    ];
    hash = "sha256-7jECYkmiX+IueCRTVx3m+ZvMhcCSGj76dzASyBxFKlc=";
    installPath = "https/repo1.maven.org/maven2/org/jetbrains/annotations/24.0.1";
  };

  "org.jgrapht_jgrapht-1.4.0" = fetchMaven {
    name = "org.jgrapht_jgrapht-1.4.0";
    urls = [ "https://repo1.maven.org/maven2/org/jgrapht/jgrapht/1.4.0/jgrapht-1.4.0.pom" ];
    hash = "sha256-0bLt1jNIcVaLnLF7J/UT53p9nsmR1nSB3zKHCCc9xY0=";
    installPath = "https/repo1.maven.org/maven2/org/jgrapht/jgrapht/1.4.0";
  };

  "org.jgrapht_jgrapht-core-1.4.0" = fetchMaven {
    name = "org.jgrapht_jgrapht-core-1.4.0";
    urls = [
      "https://repo1.maven.org/maven2/org/jgrapht/jgrapht-core/1.4.0/jgrapht-core-1.4.0.jar"
      "https://repo1.maven.org/maven2/org/jgrapht/jgrapht-core/1.4.0/jgrapht-core-1.4.0.pom"
    ];
    hash = "sha256-SDTdRtbcTa+IsuGfLrnZjaDdEkUaxolSHKwTM1uyKII=";
    installPath = "https/repo1.maven.org/maven2/org/jgrapht/jgrapht-core/1.4.0";
  };

  "org.jheaps_jheaps-0.11" = fetchMaven {
    name = "org.jheaps_jheaps-0.11";
    urls = [
      "https://repo1.maven.org/maven2/org/jheaps/jheaps/0.11/jheaps-0.11.jar"
      "https://repo1.maven.org/maven2/org/jheaps/jheaps/0.11/jheaps-0.11.pom"
    ];
    hash = "sha256-LtDxiqSoClaeIxb0UUbh79Y8HiSHrgyVLCMhQSjRDUo=";
    installPath = "https/repo1.maven.org/maven2/org/jheaps/jheaps/0.11";
  };

  "org.jline_jline-3.22.0" = fetchMaven {
    name = "org.jline_jline-3.22.0";
    urls = [
      "https://repo1.maven.org/maven2/org/jline/jline/3.22.0/jline-3.22.0.jar"
      "https://repo1.maven.org/maven2/org/jline/jline/3.22.0/jline-3.22.0.pom"
    ];
    hash = "sha256-I0ovz3Ra27RXAszepdlSnNz+M7u/+NyhBq2ZffnrU8k=";
    installPath = "https/repo1.maven.org/maven2/org/jline/jline/3.22.0";
  };

  "org.jline_jline-3.24.1" = fetchMaven {
    name = "org.jline_jline-3.24.1";
    urls = [
      "https://repo1.maven.org/maven2/org/jline/jline/3.24.1/jline-3.24.1.jar"
      "https://repo1.maven.org/maven2/org/jline/jline/3.24.1/jline-3.24.1.pom"
    ];
    hash = "sha256-UTsMeQWtJKmzb0cgJ+tjX9KC2m17SSZn8tESnJjihD0=";
    installPath = "https/repo1.maven.org/maven2/org/jline/jline/3.24.1";
  };

  "org.jline_jline-3.25.1" = fetchMaven {
    name = "org.jline_jline-3.25.1";
    urls = [
      "https://repo1.maven.org/maven2/org/jline/jline/3.25.1/jline-3.25.1.jar"
      "https://repo1.maven.org/maven2/org/jline/jline/3.25.1/jline-3.25.1.pom"
    ];
    hash = "sha256-A7XFvMymmp7sLkQQEFZdVJJZicA+cvXwPyyA0JMww2U=";
    installPath = "https/repo1.maven.org/maven2/org/jline/jline/3.25.1";
  };

  "org.jline_jline-3.26.3" = fetchMaven {
    name = "org.jline_jline-3.26.3";
    urls = [
      "https://repo1.maven.org/maven2/org/jline/jline/3.26.3/jline-3.26.3.jar"
      "https://repo1.maven.org/maven2/org/jline/jline/3.26.3/jline-3.26.3.pom"
    ];
    hash = "sha256-CVg5HR6GRYVCZ+0Y3yMsCUlgFCzd7MhgMqaZIQZEus0=";
    installPath = "https/repo1.maven.org/maven2/org/jline/jline/3.26.3";
  };

  "org.jline_jline-3.27.1" = fetchMaven {
    name = "org.jline_jline-3.27.1";
    urls = [
      "https://repo1.maven.org/maven2/org/jline/jline/3.27.1/jline-3.27.1-jdk8.jar"
      "https://repo1.maven.org/maven2/org/jline/jline/3.27.1/jline-3.27.1.pom"
    ];
    hash = "sha256-GnI5uLuXJN7AvsltUpzwzGNuFYkfSQ4mxy4XLOODsmU=";
    installPath = "https/repo1.maven.org/maven2/org/jline/jline/3.27.1";
  };

  "org.jline_jline-3.28.0" = fetchMaven {
    name = "org.jline_jline-3.28.0";
    urls = [
      "https://repo1.maven.org/maven2/org/jline/jline/3.28.0/jline-3.28.0-jdk8.jar"
      "https://repo1.maven.org/maven2/org/jline/jline/3.28.0/jline-3.28.0.jar"
      "https://repo1.maven.org/maven2/org/jline/jline/3.28.0/jline-3.28.0.pom"
    ];
    hash = "sha256-gDKE20d8d58LmwG9aL+oN3hoEm+LI/ksMw3C4T/bUPM=";
    installPath = "https/repo1.maven.org/maven2/org/jline/jline/3.28.0";
  };

  "org.jline_jline-3.29.0" = fetchMaven {
    name = "org.jline_jline-3.29.0";
    urls = [
      "https://repo1.maven.org/maven2/org/jline/jline/3.29.0/jline-3.29.0-jdk8.jar"
      "https://repo1.maven.org/maven2/org/jline/jline/3.29.0/jline-3.29.0.pom"
    ];
    hash = "sha256-ZmgozcoXoJvSHC8o/MWWuJwq8t5opF2ELqfWaDyx4N8=";
    installPath = "https/repo1.maven.org/maven2/org/jline/jline/3.29.0";
  };

  "org.jline_jline-native-3.25.1" = fetchMaven {
    name = "org.jline_jline-native-3.25.1";
    urls = [
      "https://repo1.maven.org/maven2/org/jline/jline-native/3.25.1/jline-native-3.25.1.jar"
      "https://repo1.maven.org/maven2/org/jline/jline-native/3.25.1/jline-native-3.25.1.pom"
    ];
    hash = "sha256-693lRtrr078jNfaxvkTVseTIQHpjfbJD4vD7pDPQ7LI=";
    installPath = "https/repo1.maven.org/maven2/org/jline/jline-native/3.25.1";
  };

  "org.jline_jline-native-3.29.0" = fetchMaven {
    name = "org.jline_jline-native-3.29.0";
    urls = [
      "https://repo1.maven.org/maven2/org/jline/jline-native/3.29.0/jline-native-3.29.0.jar"
      "https://repo1.maven.org/maven2/org/jline/jline-native/3.29.0/jline-native-3.29.0.pom"
    ];
    hash = "sha256-B4uPEOoZQdIyvNzjJBxzr+9m6E0Q95p2l/0iyYpz62Y=";
    installPath = "https/repo1.maven.org/maven2/org/jline/jline-native/3.29.0";
  };

  "org.jline_jline-parent-3.22.0" = fetchMaven {
    name = "org.jline_jline-parent-3.22.0";
    urls = [ "https://repo1.maven.org/maven2/org/jline/jline-parent/3.22.0/jline-parent-3.22.0.pom" ];
    hash = "sha256-onEcBbRLFP9zt0OMtf6/SNhzQNZDxFbosPRVdINwbyU=";
    installPath = "https/repo1.maven.org/maven2/org/jline/jline-parent/3.22.0";
  };

  "org.jline_jline-parent-3.24.1" = fetchMaven {
    name = "org.jline_jline-parent-3.24.1";
    urls = [ "https://repo1.maven.org/maven2/org/jline/jline-parent/3.24.1/jline-parent-3.24.1.pom" ];
    hash = "sha256-TmNt3xgCMMZ/wwxBKzmqlU5UAEg4F4VVkVaUsMJsGK8=";
    installPath = "https/repo1.maven.org/maven2/org/jline/jline-parent/3.24.1";
  };

  "org.jline_jline-parent-3.25.1" = fetchMaven {
    name = "org.jline_jline-parent-3.25.1";
    urls = [ "https://repo1.maven.org/maven2/org/jline/jline-parent/3.25.1/jline-parent-3.25.1.pom" ];
    hash = "sha256-+yzWFZBCONNCOAeh6VqkYoH+N8hZllPCKfv+93cTn18=";
    installPath = "https/repo1.maven.org/maven2/org/jline/jline-parent/3.25.1";
  };

  "org.jline_jline-parent-3.27.1" = fetchMaven {
    name = "org.jline_jline-parent-3.27.1";
    urls = [ "https://repo1.maven.org/maven2/org/jline/jline-parent/3.27.1/jline-parent-3.27.1.pom" ];
    hash = "sha256-Oa5DgBvf5JwZH68PDIyNkEQtm7IL04ujoeniH6GZas8=";
    installPath = "https/repo1.maven.org/maven2/org/jline/jline-parent/3.27.1";
  };

  "org.jline_jline-parent-3.28.0" = fetchMaven {
    name = "org.jline_jline-parent-3.28.0";
    urls = [ "https://repo1.maven.org/maven2/org/jline/jline-parent/3.28.0/jline-parent-3.28.0.pom" ];
    hash = "sha256-EvTBMv2vy2Fr4PBgLlyFTBOBTND+rNcodOzplY4Rq/g=";
    installPath = "https/repo1.maven.org/maven2/org/jline/jline-parent/3.28.0";
  };

  "org.jline_jline-parent-3.29.0" = fetchMaven {
    name = "org.jline_jline-parent-3.29.0";
    urls = [ "https://repo1.maven.org/maven2/org/jline/jline-parent/3.29.0/jline-parent-3.29.0.pom" ];
    hash = "sha256-oxKMIwjIJO0c7pcRwCh1deR9MT5oIjEQD5xiDZzCLNg=";
    installPath = "https/repo1.maven.org/maven2/org/jline/jline-parent/3.29.0";
  };

  "org.jline_jline-reader-3.25.1" = fetchMaven {
    name = "org.jline_jline-reader-3.25.1";
    urls = [
      "https://repo1.maven.org/maven2/org/jline/jline-reader/3.25.1/jline-reader-3.25.1.jar"
      "https://repo1.maven.org/maven2/org/jline/jline-reader/3.25.1/jline-reader-3.25.1.pom"
    ];
    hash = "sha256-d8W/YHtMX6thHsUkm3BO8wYwA6Oz+rDBcasUArMwMXY=";
    installPath = "https/repo1.maven.org/maven2/org/jline/jline-reader/3.25.1";
  };

  "org.jline_jline-reader-3.29.0" = fetchMaven {
    name = "org.jline_jline-reader-3.29.0";
    urls = [
      "https://repo1.maven.org/maven2/org/jline/jline-reader/3.29.0/jline-reader-3.29.0.jar"
      "https://repo1.maven.org/maven2/org/jline/jline-reader/3.29.0/jline-reader-3.29.0.pom"
    ];
    hash = "sha256-29VGA1VapJEewqh+CohsyXSpXkH7It/GwcAK0Z4igbo=";
    installPath = "https/repo1.maven.org/maven2/org/jline/jline-reader/3.29.0";
  };

  "org.jline_jline-terminal-3.25.1" = fetchMaven {
    name = "org.jline_jline-terminal-3.25.1";
    urls = [
      "https://repo1.maven.org/maven2/org/jline/jline-terminal/3.25.1/jline-terminal-3.25.1.jar"
      "https://repo1.maven.org/maven2/org/jline/jline-terminal/3.25.1/jline-terminal-3.25.1.pom"
    ];
    hash = "sha256-Pm00LXlWGtEWHVogvZH9suEHXk/ArOq/FNw35Hk8MJc=";
    installPath = "https/repo1.maven.org/maven2/org/jline/jline-terminal/3.25.1";
  };

  "org.jline_jline-terminal-3.27.1" = fetchMaven {
    name = "org.jline_jline-terminal-3.27.1";
    urls = [
      "https://repo1.maven.org/maven2/org/jline/jline-terminal/3.27.1/jline-terminal-3.27.1.jar"
      "https://repo1.maven.org/maven2/org/jline/jline-terminal/3.27.1/jline-terminal-3.27.1.pom"
    ];
    hash = "sha256-WV77BAEncauTljUBrlYi9v3GxDDeskqQpHHD9Fdbqjw=";
    installPath = "https/repo1.maven.org/maven2/org/jline/jline-terminal/3.27.1";
  };

  "org.jline_jline-terminal-3.29.0" = fetchMaven {
    name = "org.jline_jline-terminal-3.29.0";
    urls = [
      "https://repo1.maven.org/maven2/org/jline/jline-terminal/3.29.0/jline-terminal-3.29.0.jar"
      "https://repo1.maven.org/maven2/org/jline/jline-terminal/3.29.0/jline-terminal-3.29.0.pom"
    ];
    hash = "sha256-VSLgLannbVTHJdbWjmHtvPlbqRHgN67iVGQhd6GdBrI=";
    installPath = "https/repo1.maven.org/maven2/org/jline/jline-terminal/3.29.0";
  };

  "org.jline_jline-terminal-jna-3.25.1" = fetchMaven {
    name = "org.jline_jline-terminal-jna-3.25.1";
    urls = [
      "https://repo1.maven.org/maven2/org/jline/jline-terminal-jna/3.25.1/jline-terminal-jna-3.25.1.jar"
      "https://repo1.maven.org/maven2/org/jline/jline-terminal-jna/3.25.1/jline-terminal-jna-3.25.1.pom"
    ];
    hash = "sha256-5+WKhwPEvBhaZr4myFh39kMp8COzHSPWbvyM6QFqUuk=";
    installPath = "https/repo1.maven.org/maven2/org/jline/jline-terminal-jna/3.25.1";
  };

  "org.jline_jline-terminal-jni-3.27.1" = fetchMaven {
    name = "org.jline_jline-terminal-jni-3.27.1";
    urls = [
      "https://repo1.maven.org/maven2/org/jline/jline-terminal-jni/3.27.1/jline-terminal-jni-3.27.1.jar"
      "https://repo1.maven.org/maven2/org/jline/jline-terminal-jni/3.27.1/jline-terminal-jni-3.27.1.pom"
    ];
    hash = "sha256-AWKC7imb/rnF39PAo3bVIW430zPkyj9WozKGkPlTTBE=";
    installPath = "https/repo1.maven.org/maven2/org/jline/jline-terminal-jni/3.27.1";
  };

  "org.jline_jline-terminal-jni-3.29.0" = fetchMaven {
    name = "org.jline_jline-terminal-jni-3.29.0";
    urls = [
      "https://repo1.maven.org/maven2/org/jline/jline-terminal-jni/3.29.0/jline-terminal-jni-3.29.0.jar"
      "https://repo1.maven.org/maven2/org/jline/jline-terminal-jni/3.29.0/jline-terminal-jni-3.29.0.pom"
    ];
    hash = "sha256-P5vIZblvy8nL21syHeJMNJEip/JVsVkislqKbh6ffyA=";
    installPath = "https/repo1.maven.org/maven2/org/jline/jline-terminal-jni/3.29.0";
  };

  "org.jsoup_jsoup-1.15.4" = fetchMaven {
    name = "org.jsoup_jsoup-1.15.4";
    urls = [
      "https://repo1.maven.org/maven2/org/jsoup/jsoup/1.15.4/jsoup-1.15.4.jar"
      "https://repo1.maven.org/maven2/org/jsoup/jsoup/1.15.4/jsoup-1.15.4.pom"
    ];
    hash = "sha256-3Nk1Vety11VNjlGaP57Ybb2o1iaB59eXZ8xXjVFQbug=";
    installPath = "https/repo1.maven.org/maven2/org/jsoup/jsoup/1.15.4";
  };

  "org.jsoup_jsoup-1.17.2" = fetchMaven {
    name = "org.jsoup_jsoup-1.17.2";
    urls = [
      "https://repo1.maven.org/maven2/org/jsoup/jsoup/1.17.2/jsoup-1.17.2.jar"
      "https://repo1.maven.org/maven2/org/jsoup/jsoup/1.17.2/jsoup-1.17.2.pom"
    ];
    hash = "sha256-aex/2xWBJBV0CVGOIoNvOcnYi6sVTd3CwBJhM5ZUISU=";
    installPath = "https/repo1.maven.org/maven2/org/jsoup/jsoup/1.17.2";
  };

  "org.junit_junit-bom-5.10.0" = fetchMaven {
    name = "org.junit_junit-bom-5.10.0";
    urls = [ "https://repo1.maven.org/maven2/org/junit/junit-bom/5.10.0/junit-bom-5.10.0.pom" ];
    hash = "sha256-luQjQgOITEqh2Y+/2XwfXzgggI8aRglNmIXZGpcJEgY=";
    installPath = "https/repo1.maven.org/maven2/org/junit/junit-bom/5.10.0";
  };

  "org.junit_junit-bom-5.10.1" = fetchMaven {
    name = "org.junit_junit-bom-5.10.1";
    urls = [ "https://repo1.maven.org/maven2/org/junit/junit-bom/5.10.1/junit-bom-5.10.1.pom" ];
    hash = "sha256-j6Bq0SVdCeMwCv3U2bFfmInjBSY9NYedGadR/5PskK4=";
    installPath = "https/repo1.maven.org/maven2/org/junit/junit-bom/5.10.1";
  };

  "org.junit_junit-bom-5.10.2" = fetchMaven {
    name = "org.junit_junit-bom-5.10.2";
    urls = [ "https://repo1.maven.org/maven2/org/junit/junit-bom/5.10.2/junit-bom-5.10.2.pom" ];
    hash = "sha256-AlDFqi7NIm0J1UoA6JCUM3Rhq5cNwsXq/I8viZmWLEg=";
    installPath = "https/repo1.maven.org/maven2/org/junit/junit-bom/5.10.2";
  };

  "org.junit_junit-bom-5.13.1" = fetchMaven {
    name = "org.junit_junit-bom-5.13.1";
    urls = [ "https://repo1.maven.org/maven2/org/junit/junit-bom/5.13.1/junit-bom-5.13.1.pom" ];
    hash = "sha256-y0fYl6j3V74Ioxxiq2/0Riiw4VDt7XG6YR/Ekd7wKDg=";
    installPath = "https/repo1.maven.org/maven2/org/junit/junit-bom/5.13.1";
  };

  "org.junit_junit-bom-5.13.2" = fetchMaven {
    name = "org.junit_junit-bom-5.13.2";
    urls = [ "https://repo1.maven.org/maven2/org/junit/junit-bom/5.13.2/junit-bom-5.13.2.pom" ];
    hash = "sha256-7tgy2u9U7G1G3A8bXLq3vl23h0NzJNsXtELQv3s6idg=";
    installPath = "https/repo1.maven.org/maven2/org/junit/junit-bom/5.13.2";
  };

  "org.junit_junit-bom-5.13.4" = fetchMaven {
    name = "org.junit_junit-bom-5.13.4";
    urls = [ "https://repo1.maven.org/maven2/org/junit/junit-bom/5.13.4/junit-bom-5.13.4.pom" ];
    hash = "sha256-uMvXRj2IJjctssr3Twwzn/xTriNqj8Wl3QeIeCzgHwE=";
    installPath = "https/repo1.maven.org/maven2/org/junit/junit-bom/5.13.4";
  };

  "org.junit_junit-bom-5.8.0-M1" = fetchMaven {
    name = "org.junit_junit-bom-5.8.0-M1";
    urls = [ "https://repo1.maven.org/maven2/org/junit/junit-bom/5.8.0-M1/junit-bom-5.8.0-M1.pom" ];
    hash = "sha256-3suC6i7s+f+GrkY/p8I8TXqZnkP6Vz5/iHplYFZPIk4=";
    installPath = "https/repo1.maven.org/maven2/org/junit/junit-bom/5.8.0-M1";
  };

  "org.junit_junit-bom-5.8.2" = fetchMaven {
    name = "org.junit_junit-bom-5.8.2";
    urls = [ "https://repo1.maven.org/maven2/org/junit/junit-bom/5.8.2/junit-bom-5.8.2.pom" ];
    hash = "sha256-3uZs6ouEx/m0uaNQk0y7oMqoPXeNsL4K1VOhYJm9lmk=";
    installPath = "https/repo1.maven.org/maven2/org/junit/junit-bom/5.8.2";
  };

  "org.junit_junit-bom-5.9.2" = fetchMaven {
    name = "org.junit_junit-bom-5.9.2";
    urls = [ "https://repo1.maven.org/maven2/org/junit/junit-bom/5.9.2/junit-bom-5.9.2.pom" ];
    hash = "sha256-uGn68+1/ScKIRXjMgUllMofOsjFTxO1mfwrpSVBpP6E=";
    installPath = "https/repo1.maven.org/maven2/org/junit/junit-bom/5.9.2";
  };

  "org.junit_junit-bom-5.9.3" = fetchMaven {
    name = "org.junit_junit-bom-5.9.3";
    urls = [ "https://repo1.maven.org/maven2/org/junit/junit-bom/5.9.3/junit-bom-5.9.3.pom" ];
    hash = "sha256-X9DjgXGbAVQU9wJfHfw6JGAGx/jhvbklGM2h4V/lOi4=";
    installPath = "https/repo1.maven.org/maven2/org/junit/junit-bom/5.9.3";
  };

  "org.log4s_log4s_3-1.10.0" = fetchMaven {
    name = "org.log4s_log4s_3-1.10.0";
    urls = [
      "https://repo1.maven.org/maven2/org/log4s/log4s_3/1.10.0/log4s_3-1.10.0.jar"
      "https://repo1.maven.org/maven2/org/log4s/log4s_3/1.10.0/log4s_3-1.10.0.pom"
    ];
    hash = "sha256-BgQ5mtxoYo4Km2AdtCRZA6YV5jX0Ykdo7uvXrAAiJVg=";
    installPath = "https/repo1.maven.org/maven2/org/log4s/log4s_3/1.10.0";
  };

  "org.mockito_mockito-bom-4.11.0" = fetchMaven {
    name = "org.mockito_mockito-bom-4.11.0";
    urls = [ "https://repo1.maven.org/maven2/org/mockito/mockito-bom/4.11.0/mockito-bom-4.11.0.pom" ];
    hash = "sha256-jtuaGRrHXNkevtfBAzk3OA+n5RNtrDQ0MQSqSRxUIfc=";
    installPath = "https/repo1.maven.org/maven2/org/mockito/mockito-bom/4.11.0";
  };

  "org.mockito_mockito-bom-5.7.0" = fetchMaven {
    name = "org.mockito_mockito-bom-5.7.0";
    urls = [ "https://repo1.maven.org/maven2/org/mockito/mockito-bom/5.7.0/mockito-bom-5.7.0.pom" ];
    hash = "sha256-X5w739I0fG+xoZt82yLhQZxgetd4lB++IHAE7aLsOag=";
    installPath = "https/repo1.maven.org/maven2/org/mockito/mockito-bom/5.7.0";
  };

  "org.ow2_ow2-1.5.1" = fetchMaven {
    name = "org.ow2_ow2-1.5.1";
    urls = [ "https://repo1.maven.org/maven2/org/ow2/ow2/1.5.1/ow2-1.5.1.pom" ];
    hash = "sha256-4F8xYVbQg2PG/GhDEdcvENureaBF1yT/hSdLimkz5ks=";
    installPath = "https/repo1.maven.org/maven2/org/ow2/ow2/1.5.1";
  };

  "org.scala-lang_scala-compiler-2.13.11" = fetchMaven {
    name = "org.scala-lang_scala-compiler-2.13.11";
    urls = [
      "https://repo1.maven.org/maven2/org/scala-lang/scala-compiler/2.13.11/scala-compiler-2.13.11.jar"
      "https://repo1.maven.org/maven2/org/scala-lang/scala-compiler/2.13.11/scala-compiler-2.13.11.pom"
    ];
    hash = "sha256-2bZLGDF2jy/fsP/ceKtfydCUMMjpZXCHzPcYSksyvqM=";
    installPath = "https/repo1.maven.org/maven2/org/scala-lang/scala-compiler/2.13.11";
  };

  "org.scala-lang_scala-compiler-2.13.12" = fetchMaven {
    name = "org.scala-lang_scala-compiler-2.13.12";
    urls = [
      "https://repo1.maven.org/maven2/org/scala-lang/scala-compiler/2.13.12/scala-compiler-2.13.12.jar"
      "https://repo1.maven.org/maven2/org/scala-lang/scala-compiler/2.13.12/scala-compiler-2.13.12.pom"
    ];
    hash = "sha256-cVcD6CK1r2M07sg3/MvclRAvtoCKusp2lJFS5Bw/CaU=";
    installPath = "https/repo1.maven.org/maven2/org/scala-lang/scala-compiler/2.13.12";
  };

  "org.scala-lang_scala-compiler-2.13.13" = fetchMaven {
    name = "org.scala-lang_scala-compiler-2.13.13";
    urls = [
      "https://repo1.maven.org/maven2/org/scala-lang/scala-compiler/2.13.13/scala-compiler-2.13.13.jar"
      "https://repo1.maven.org/maven2/org/scala-lang/scala-compiler/2.13.13/scala-compiler-2.13.13.pom"
    ];
    hash = "sha256-lHIX4OLYQ6PsAVqjFMEzct6Z/lCeUtfLw1OhFAUoMd8=";
    installPath = "https/repo1.maven.org/maven2/org/scala-lang/scala-compiler/2.13.13";
  };

  "org.scala-lang_scala-compiler-2.13.14" = fetchMaven {
    name = "org.scala-lang_scala-compiler-2.13.14";
    urls = [
      "https://repo1.maven.org/maven2/org/scala-lang/scala-compiler/2.13.14/scala-compiler-2.13.14.jar"
      "https://repo1.maven.org/maven2/org/scala-lang/scala-compiler/2.13.14/scala-compiler-2.13.14.pom"
    ];
    hash = "sha256-R1MSUh8rAiJm6O114agQNoQyY+DBCLvl4TUgmWeKi0A=";
    installPath = "https/repo1.maven.org/maven2/org/scala-lang/scala-compiler/2.13.14";
  };

  "org.scala-lang_scala-compiler-2.13.15" = fetchMaven {
    name = "org.scala-lang_scala-compiler-2.13.15";
    urls = [
      "https://repo1.maven.org/maven2/org/scala-lang/scala-compiler/2.13.15/scala-compiler-2.13.15.jar"
      "https://repo1.maven.org/maven2/org/scala-lang/scala-compiler/2.13.15/scala-compiler-2.13.15.pom"
    ];
    hash = "sha256-kvqWoFLNy3LGIbD6l67f66OyJq/K2L4rTStLiDzIzm8=";
    installPath = "https/repo1.maven.org/maven2/org/scala-lang/scala-compiler/2.13.15";
  };

  "org.scala-lang_scala-compiler-2.13.16" = fetchMaven {
    name = "org.scala-lang_scala-compiler-2.13.16";
    urls = [
      "https://repo1.maven.org/maven2/org/scala-lang/scala-compiler/2.13.16/scala-compiler-2.13.16.jar"
      "https://repo1.maven.org/maven2/org/scala-lang/scala-compiler/2.13.16/scala-compiler-2.13.16.pom"
    ];
    hash = "sha256-uPxnpCaIbviBXMJjY9+MSQCPa6iqEx/zgtO926dxv+U=";
    installPath = "https/repo1.maven.org/maven2/org/scala-lang/scala-compiler/2.13.16";
  };

  "org.scala-lang_scala-compiler-2.13.17" = fetchMaven {
    name = "org.scala-lang_scala-compiler-2.13.17";
    urls = [
      "https://repo1.maven.org/maven2/org/scala-lang/scala-compiler/2.13.17/scala-compiler-2.13.17.jar"
      "https://repo1.maven.org/maven2/org/scala-lang/scala-compiler/2.13.17/scala-compiler-2.13.17.pom"
    ];
    hash = "sha256-GPCnCzE5jH98C8eZuCO4cbywplpPnYFmx766lQOnbZo=";
    installPath = "https/repo1.maven.org/maven2/org/scala-lang/scala-compiler/2.13.17";
  };

  "org.scala-lang_scala-compiler-2.13.18" = fetchMaven {
    name = "org.scala-lang_scala-compiler-2.13.18";
    urls = [
      "https://repo1.maven.org/maven2/org/scala-lang/scala-compiler/2.13.18/scala-compiler-2.13.18.jar"
      "https://repo1.maven.org/maven2/org/scala-lang/scala-compiler/2.13.18/scala-compiler-2.13.18.pom"
    ];
    hash = "sha256-FzRNf2n/OSuKCLvDLLTqnemaDV2PF3YdKmkBjuYO0IU=";
    installPath = "https/repo1.maven.org/maven2/org/scala-lang/scala-compiler/2.13.18";
  };

  "org.scala-lang_scala-library-2.13.11" = fetchMaven {
    name = "org.scala-lang_scala-library-2.13.11";
    urls = [
      "https://repo1.maven.org/maven2/org/scala-lang/scala-library/2.13.11/scala-library-2.13.11.jar"
      "https://repo1.maven.org/maven2/org/scala-lang/scala-library/2.13.11/scala-library-2.13.11.pom"
    ];
    hash = "sha256-xmgPZ4eig7KPdRJjU1G010gZYe1jbDujcXyMoDhTcOw=";
    installPath = "https/repo1.maven.org/maven2/org/scala-lang/scala-library/2.13.11";
  };

  "org.scala-lang_scala-library-2.13.12" = fetchMaven {
    name = "org.scala-lang_scala-library-2.13.12";
    urls = [
      "https://repo1.maven.org/maven2/org/scala-lang/scala-library/2.13.12/scala-library-2.13.12.jar"
      "https://repo1.maven.org/maven2/org/scala-lang/scala-library/2.13.12/scala-library-2.13.12.pom"
    ];
    hash = "sha256-lXKrUcaYvYFyltW8AxZb1apsFCr5H/5I8oF8/QWDOKQ=";
    installPath = "https/repo1.maven.org/maven2/org/scala-lang/scala-library/2.13.12";
  };

  "org.scala-lang_scala-library-2.13.13" = fetchMaven {
    name = "org.scala-lang_scala-library-2.13.13";
    urls = [
      "https://repo1.maven.org/maven2/org/scala-lang/scala-library/2.13.13/scala-library-2.13.13.jar"
      "https://repo1.maven.org/maven2/org/scala-lang/scala-library/2.13.13/scala-library-2.13.13.pom"
    ];
    hash = "sha256-CnAqcbFDxIG1EhrQ+yqEUzQT3emZE9umT9NKLdTTefI=";
    installPath = "https/repo1.maven.org/maven2/org/scala-lang/scala-library/2.13.13";
  };

  "org.scala-lang_scala-library-2.13.14" = fetchMaven {
    name = "org.scala-lang_scala-library-2.13.14";
    urls = [
      "https://repo1.maven.org/maven2/org/scala-lang/scala-library/2.13.14/scala-library-2.13.14.jar"
      "https://repo1.maven.org/maven2/org/scala-lang/scala-library/2.13.14/scala-library-2.13.14.pom"
    ];
    hash = "sha256-JD7ng4Rp55SXRO5Jkx8UHbSpvuXPxYuirQfj75hRnhM=";
    installPath = "https/repo1.maven.org/maven2/org/scala-lang/scala-library/2.13.14";
  };

  "org.scala-lang_scala-library-2.13.15" = fetchMaven {
    name = "org.scala-lang_scala-library-2.13.15";
    urls = [
      "https://repo1.maven.org/maven2/org/scala-lang/scala-library/2.13.15/scala-library-2.13.15.jar"
      "https://repo1.maven.org/maven2/org/scala-lang/scala-library/2.13.15/scala-library-2.13.15.pom"
    ];
    hash = "sha256-JnbDGZQKZZswRZuxauQywH/4rXzwzn++kMB4lw3OfPI=";
    installPath = "https/repo1.maven.org/maven2/org/scala-lang/scala-library/2.13.15";
  };

  "org.scala-lang_scala-library-2.13.16" = fetchMaven {
    name = "org.scala-lang_scala-library-2.13.16";
    urls = [
      "https://repo1.maven.org/maven2/org/scala-lang/scala-library/2.13.16/scala-library-2.13.16.jar"
      "https://repo1.maven.org/maven2/org/scala-lang/scala-library/2.13.16/scala-library-2.13.16.pom"
    ];
    hash = "sha256-7/NvAxKKPtghJ/+pTNxvmIAiAdtQXRTUvDwGGXwpnpU=";
    installPath = "https/repo1.maven.org/maven2/org/scala-lang/scala-library/2.13.16";
  };

  "org.scala-lang_scala-library-2.13.17" = fetchMaven {
    name = "org.scala-lang_scala-library-2.13.17";
    urls = [
      "https://repo1.maven.org/maven2/org/scala-lang/scala-library/2.13.17/scala-library-2.13.17.jar"
      "https://repo1.maven.org/maven2/org/scala-lang/scala-library/2.13.17/scala-library-2.13.17.pom"
    ];
    hash = "sha256-muYKpKx3pVApxCSsSa9DJu8g/rpj+/o5VPEdWVlms1k=";
    installPath = "https/repo1.maven.org/maven2/org/scala-lang/scala-library/2.13.17";
  };

  "org.scala-lang_scala-library-2.13.18" = fetchMaven {
    name = "org.scala-lang_scala-library-2.13.18";
    urls = [
      "https://repo1.maven.org/maven2/org/scala-lang/scala-library/2.13.18/scala-library-2.13.18.jar"
      "https://repo1.maven.org/maven2/org/scala-lang/scala-library/2.13.18/scala-library-2.13.18.pom"
    ];
    hash = "sha256-yvrsVgwMXWIDzG/kaiPRkYZQfLg7y/ViH2HRUcF8IgE=";
    installPath = "https/repo1.maven.org/maven2/org/scala-lang/scala-library/2.13.18";
  };

  "org.scala-lang_scala-library-3.8.0-RC2" = fetchMaven {
    name = "org.scala-lang_scala-library-3.8.0-RC2";
    urls = [
      "https://repo1.maven.org/maven2/org/scala-lang/scala-library/3.8.0-RC2/scala-library-3.8.0-RC2.jar"
      "https://repo1.maven.org/maven2/org/scala-lang/scala-library/3.8.0-RC2/scala-library-3.8.0-RC2.pom"
    ];
    hash = "sha256-HwuAatcQ8B0BpELDTWuGRRDJRZFlqyW8/U04Gt0AqfM=";
    installPath = "https/repo1.maven.org/maven2/org/scala-lang/scala-library/3.8.0-RC2";
  };

  "org.scala-lang_scala-reflect-2.13.11" = fetchMaven {
    name = "org.scala-lang_scala-reflect-2.13.11";
    urls = [
      "https://repo1.maven.org/maven2/org/scala-lang/scala-reflect/2.13.11/scala-reflect-2.13.11.jar"
      "https://repo1.maven.org/maven2/org/scala-lang/scala-reflect/2.13.11/scala-reflect-2.13.11.pom"
    ];
    hash = "sha256-uOmyHJxL4YS7gAVBbeN19gC/FtEG7wxvTRM/oD2GHeU=";
    installPath = "https/repo1.maven.org/maven2/org/scala-lang/scala-reflect/2.13.11";
  };

  "org.scala-lang_scala-reflect-2.13.12" = fetchMaven {
    name = "org.scala-lang_scala-reflect-2.13.12";
    urls = [
      "https://repo1.maven.org/maven2/org/scala-lang/scala-reflect/2.13.12/scala-reflect-2.13.12.jar"
      "https://repo1.maven.org/maven2/org/scala-lang/scala-reflect/2.13.12/scala-reflect-2.13.12.pom"
    ];
    hash = "sha256-876jILtSkA9ukYfoR7hmf9IHypGGe0DoTxyiYlVVtRU=";
    installPath = "https/repo1.maven.org/maven2/org/scala-lang/scala-reflect/2.13.12";
  };

  "org.scala-lang_scala-reflect-2.13.13" = fetchMaven {
    name = "org.scala-lang_scala-reflect-2.13.13";
    urls = [
      "https://repo1.maven.org/maven2/org/scala-lang/scala-reflect/2.13.13/scala-reflect-2.13.13.jar"
      "https://repo1.maven.org/maven2/org/scala-lang/scala-reflect/2.13.13/scala-reflect-2.13.13.pom"
    ];
    hash = "sha256-tfmrmWZpXJi5SQ7v+gZ34nsYQ+Y44rJX+Q9JsygbGPM=";
    installPath = "https/repo1.maven.org/maven2/org/scala-lang/scala-reflect/2.13.13";
  };

  "org.scala-lang_scala-reflect-2.13.14" = fetchMaven {
    name = "org.scala-lang_scala-reflect-2.13.14";
    urls = [
      "https://repo1.maven.org/maven2/org/scala-lang/scala-reflect/2.13.14/scala-reflect-2.13.14.jar"
      "https://repo1.maven.org/maven2/org/scala-lang/scala-reflect/2.13.14/scala-reflect-2.13.14.pom"
    ];
    hash = "sha256-khLNhLU3TwEfUUxeTeFbOxtJ31okA8grgSsVSlQGV8w=";
    installPath = "https/repo1.maven.org/maven2/org/scala-lang/scala-reflect/2.13.14";
  };

  "org.scala-lang_scala-reflect-2.13.15" = fetchMaven {
    name = "org.scala-lang_scala-reflect-2.13.15";
    urls = [
      "https://repo1.maven.org/maven2/org/scala-lang/scala-reflect/2.13.15/scala-reflect-2.13.15.jar"
      "https://repo1.maven.org/maven2/org/scala-lang/scala-reflect/2.13.15/scala-reflect-2.13.15.pom"
    ];
    hash = "sha256-zmUU4hTEf5HC311UaNIHmzjSwWSbjXn6DyPP7ZzFy/8=";
    installPath = "https/repo1.maven.org/maven2/org/scala-lang/scala-reflect/2.13.15";
  };

  "org.scala-lang_scala-reflect-2.13.16" = fetchMaven {
    name = "org.scala-lang_scala-reflect-2.13.16";
    urls = [
      "https://repo1.maven.org/maven2/org/scala-lang/scala-reflect/2.13.16/scala-reflect-2.13.16.jar"
      "https://repo1.maven.org/maven2/org/scala-lang/scala-reflect/2.13.16/scala-reflect-2.13.16.pom"
    ];
    hash = "sha256-Y/cXrptUKnH51rsTo8reYZbqbrWuO+fohzQW3z9Nx90=";
    installPath = "https/repo1.maven.org/maven2/org/scala-lang/scala-reflect/2.13.16";
  };

  "org.scala-lang_scala-reflect-2.13.17" = fetchMaven {
    name = "org.scala-lang_scala-reflect-2.13.17";
    urls = [
      "https://repo1.maven.org/maven2/org/scala-lang/scala-reflect/2.13.17/scala-reflect-2.13.17.jar"
      "https://repo1.maven.org/maven2/org/scala-lang/scala-reflect/2.13.17/scala-reflect-2.13.17.pom"
    ];
    hash = "sha256-II0IMVH2tJwz/KBigpc3qpqdmygGJ2rHWwtbO2mubgA=";
    installPath = "https/repo1.maven.org/maven2/org/scala-lang/scala-reflect/2.13.17";
  };

  "org.scala-lang_scala-reflect-2.13.18" = fetchMaven {
    name = "org.scala-lang_scala-reflect-2.13.18";
    urls = [
      "https://repo1.maven.org/maven2/org/scala-lang/scala-reflect/2.13.18/scala-reflect-2.13.18.jar"
      "https://repo1.maven.org/maven2/org/scala-lang/scala-reflect/2.13.18/scala-reflect-2.13.18.pom"
    ];
    hash = "sha256-NUxw12IP7v+wF4LMxX3rfxlC+G6BTHcrBDrRZlHaWZU=";
    installPath = "https/repo1.maven.org/maven2/org/scala-lang/scala-reflect/2.13.18";
  };

  "org.scala-lang_scala3-compiler_3-3.3.4" = fetchMaven {
    name = "org.scala-lang_scala3-compiler_3-3.3.4";
    urls = [
      "https://repo1.maven.org/maven2/org/scala-lang/scala3-compiler_3/3.3.4/scala3-compiler_3-3.3.4.jar"
      "https://repo1.maven.org/maven2/org/scala-lang/scala3-compiler_3/3.3.4/scala3-compiler_3-3.3.4.pom"
    ];
    hash = "sha256-15qkuy7k4kWNHUk/JSqd2hwWB8WzMMPx1cfYCFjm4Mk=";
    installPath = "https/repo1.maven.org/maven2/org/scala-lang/scala3-compiler_3/3.3.4";
  };

  "org.scala-lang_scala3-compiler_3-3.8.0-RC2" = fetchMaven {
    name = "org.scala-lang_scala3-compiler_3-3.8.0-RC2";
    urls = [
      "https://repo1.maven.org/maven2/org/scala-lang/scala3-compiler_3/3.8.0-RC2/scala3-compiler_3-3.8.0-RC2.jar"
      "https://repo1.maven.org/maven2/org/scala-lang/scala3-compiler_3/3.8.0-RC2/scala3-compiler_3-3.8.0-RC2.pom"
    ];
    hash = "sha256-eJ7CtLC5FZFEh6sDonx52A2yd8dNkRDCT3Y0FUMYxxU=";
    installPath = "https/repo1.maven.org/maven2/org/scala-lang/scala3-compiler_3/3.8.0-RC2";
  };

  "org.scala-lang_scala3-interfaces-3.3.4" = fetchMaven {
    name = "org.scala-lang_scala3-interfaces-3.3.4";
    urls = [
      "https://repo1.maven.org/maven2/org/scala-lang/scala3-interfaces/3.3.4/scala3-interfaces-3.3.4.jar"
      "https://repo1.maven.org/maven2/org/scala-lang/scala3-interfaces/3.3.4/scala3-interfaces-3.3.4.pom"
    ];
    hash = "sha256-B3z36x1NYCYoZRIiOWOe5J07K8PMTiQsBFZ2vjqrtyU=";
    installPath = "https/repo1.maven.org/maven2/org/scala-lang/scala3-interfaces/3.3.4";
  };

  "org.scala-lang_scala3-interfaces-3.8.0-RC2" = fetchMaven {
    name = "org.scala-lang_scala3-interfaces-3.8.0-RC2";
    urls = [
      "https://repo1.maven.org/maven2/org/scala-lang/scala3-interfaces/3.8.0-RC2/scala3-interfaces-3.8.0-RC2.jar"
      "https://repo1.maven.org/maven2/org/scala-lang/scala3-interfaces/3.8.0-RC2/scala3-interfaces-3.8.0-RC2.pom"
    ];
    hash = "sha256-D58VokjyNSkbG+yE1eEufjfGXL1kGPxlzeREbOIVwoM=";
    installPath = "https/repo1.maven.org/maven2/org/scala-lang/scala3-interfaces/3.8.0-RC2";
  };

  "org.scala-lang_scala3-library_3-3.3.4" = fetchMaven {
    name = "org.scala-lang_scala3-library_3-3.3.4";
    urls = [
      "https://repo1.maven.org/maven2/org/scala-lang/scala3-library_3/3.3.4/scala3-library_3-3.3.4.jar"
      "https://repo1.maven.org/maven2/org/scala-lang/scala3-library_3/3.3.4/scala3-library_3-3.3.4.pom"
    ];
    hash = "sha256-+jxXazzk+mRl2N2ynxdrRNY4Z96+qxcs8ycCLKO8M5c=";
    installPath = "https/repo1.maven.org/maven2/org/scala-lang/scala3-library_3/3.3.4";
  };

  "org.scala-lang_scala3-library_3-3.3.7" = fetchMaven {
    name = "org.scala-lang_scala3-library_3-3.3.7";
    urls = [
      "https://repo1.maven.org/maven2/org/scala-lang/scala3-library_3/3.3.7/scala3-library_3-3.3.7.jar"
      "https://repo1.maven.org/maven2/org/scala-lang/scala3-library_3/3.3.7/scala3-library_3-3.3.7.pom"
    ];
    hash = "sha256-m19053xCyueDxDJ/9rcvLSKsMa/bUSeLn7JprQePiI4=";
    installPath = "https/repo1.maven.org/maven2/org/scala-lang/scala3-library_3/3.3.7";
  };

  "org.scala-lang_scala3-library_3-3.7.4" = fetchMaven {
    name = "org.scala-lang_scala3-library_3-3.7.4";
    urls = [
      "https://repo1.maven.org/maven2/org/scala-lang/scala3-library_3/3.7.4/scala3-library_3-3.7.4.jar"
      "https://repo1.maven.org/maven2/org/scala-lang/scala3-library_3/3.7.4/scala3-library_3-3.7.4.pom"
    ];
    hash = "sha256-n96MbSjNHeFV9QaEinPQhEZyRvFuYIAU0o9iSSlkmyA=";
    installPath = "https/repo1.maven.org/maven2/org/scala-lang/scala3-library_3/3.7.4";
  };

  "org.scala-lang_scala3-library_3-3.8.0-RC2" = fetchMaven {
    name = "org.scala-lang_scala3-library_3-3.8.0-RC2";
    urls = [
      "https://repo1.maven.org/maven2/org/scala-lang/scala3-library_3/3.8.0-RC2/scala3-library_3-3.8.0-RC2.jar"
      "https://repo1.maven.org/maven2/org/scala-lang/scala3-library_3/3.8.0-RC2/scala3-library_3-3.8.0-RC2.pom"
    ];
    hash = "sha256-P3Ft45NA1xeQIxF17GVCwTDJB6HbOVFi+dgBz5vSCjk=";
    installPath = "https/repo1.maven.org/maven2/org/scala-lang/scala3-library_3/3.8.0-RC2";
  };

  "org.scala-lang_scala3-repl_3-3.8.0-RC2" = fetchMaven {
    name = "org.scala-lang_scala3-repl_3-3.8.0-RC2";
    urls = [
      "https://repo1.maven.org/maven2/org/scala-lang/scala3-repl_3/3.8.0-RC2/scala3-repl_3-3.8.0-RC2.jar"
      "https://repo1.maven.org/maven2/org/scala-lang/scala3-repl_3/3.8.0-RC2/scala3-repl_3-3.8.0-RC2.pom"
    ];
    hash = "sha256-GP6zt82iRf8SnZ6ctzvJgMrb3R8/jewYATf4bQ4WFh0=";
    installPath = "https/repo1.maven.org/maven2/org/scala-lang/scala3-repl_3/3.8.0-RC2";
  };

  "org.scala-lang_scala3-sbt-bridge-3.3.4" = fetchMaven {
    name = "org.scala-lang_scala3-sbt-bridge-3.3.4";
    urls = [
      "https://repo1.maven.org/maven2/org/scala-lang/scala3-sbt-bridge/3.3.4/scala3-sbt-bridge-3.3.4.jar"
      "https://repo1.maven.org/maven2/org/scala-lang/scala3-sbt-bridge/3.3.4/scala3-sbt-bridge-3.3.4.pom"
    ];
    hash = "sha256-h9Fr8l1spGFWsy3PAoC035KzmjHh6fXMuaL+gNmujvA=";
    installPath = "https/repo1.maven.org/maven2/org/scala-lang/scala3-sbt-bridge/3.3.4";
  };

  "org.scala-lang_scala3-sbt-bridge-3.8.0-RC2" = fetchMaven {
    name = "org.scala-lang_scala3-sbt-bridge-3.8.0-RC2";
    urls = [
      "https://repo1.maven.org/maven2/org/scala-lang/scala3-sbt-bridge/3.8.0-RC2/scala3-sbt-bridge-3.8.0-RC2.jar"
      "https://repo1.maven.org/maven2/org/scala-lang/scala3-sbt-bridge/3.8.0-RC2/scala3-sbt-bridge-3.8.0-RC2.pom"
    ];
    hash = "sha256-qpgOfIffXtC+qUEyoCKAw6OExy+UrOqpwvcEhK3TrNA=";
    installPath = "https/repo1.maven.org/maven2/org/scala-lang/scala3-sbt-bridge/3.8.0-RC2";
  };

  "org.scala-lang_scala3-tasty-inspector_3-3.3.4" = fetchMaven {
    name = "org.scala-lang_scala3-tasty-inspector_3-3.3.4";
    urls = [
      "https://repo1.maven.org/maven2/org/scala-lang/scala3-tasty-inspector_3/3.3.4/scala3-tasty-inspector_3-3.3.4.jar"
      "https://repo1.maven.org/maven2/org/scala-lang/scala3-tasty-inspector_3/3.3.4/scala3-tasty-inspector_3-3.3.4.pom"
    ];
    hash = "sha256-S2NR6M5BVD2/vHGGcGiVSu0R6t23UskxXvIX6Fqf47w=";
    installPath = "https/repo1.maven.org/maven2/org/scala-lang/scala3-tasty-inspector_3/3.3.4";
  };

  "org.scala-lang_scaladoc_3-3.3.4" = fetchMaven {
    name = "org.scala-lang_scaladoc_3-3.3.4";
    urls = [
      "https://repo1.maven.org/maven2/org/scala-lang/scaladoc_3/3.3.4/scaladoc_3-3.3.4.jar"
      "https://repo1.maven.org/maven2/org/scala-lang/scaladoc_3/3.3.4/scaladoc_3-3.3.4.pom"
    ];
    hash = "sha256-PI2XYc1qPkTMmpbPv6gEgBYvAen+U+xAkxNz+P64Sc8=";
    installPath = "https/repo1.maven.org/maven2/org/scala-lang/scaladoc_3/3.3.4";
  };

  "org.scala-lang_tasty-core_3-3.3.4" = fetchMaven {
    name = "org.scala-lang_tasty-core_3-3.3.4";
    urls = [
      "https://repo1.maven.org/maven2/org/scala-lang/tasty-core_3/3.3.4/tasty-core_3-3.3.4.jar"
      "https://repo1.maven.org/maven2/org/scala-lang/tasty-core_3/3.3.4/tasty-core_3-3.3.4.pom"
    ];
    hash = "sha256-K0tg8Cy+B/fhui5yF4aL+a1bd3q8DF3g6wOAvPSRc+I=";
    installPath = "https/repo1.maven.org/maven2/org/scala-lang/tasty-core_3/3.3.4";
  };

  "org.scala-lang_tasty-core_3-3.8.0-RC2" = fetchMaven {
    name = "org.scala-lang_tasty-core_3-3.8.0-RC2";
    urls = [
      "https://repo1.maven.org/maven2/org/scala-lang/tasty-core_3/3.8.0-RC2/tasty-core_3-3.8.0-RC2.jar"
      "https://repo1.maven.org/maven2/org/scala-lang/tasty-core_3/3.8.0-RC2/tasty-core_3-3.8.0-RC2.pom"
    ];
    hash = "sha256-0v24ln/jnckq9Nq9lH+Ix6g9UQxCtcEly8cyfQ4jK5o=";
    installPath = "https/repo1.maven.org/maven2/org/scala-lang/tasty-core_3/3.8.0-RC2";
  };

  "org.scala-sbt_collections_2.13-1.11.5" = fetchMaven {
    name = "org.scala-sbt_collections_2.13-1.11.5";
    urls = [
      "https://repo1.maven.org/maven2/org/scala-sbt/collections_2.13/1.11.5/collections_2.13-1.11.5.jar"
      "https://repo1.maven.org/maven2/org/scala-sbt/collections_2.13/1.11.5/collections_2.13-1.11.5.pom"
    ];
    hash = "sha256-jstlzDJxPLS1JACyG8zGgHj6e5Wx338y+Gr6xsShr2M=";
    installPath = "https/repo1.maven.org/maven2/org/scala-sbt/collections_2.13/1.11.5";
  };

  "org.scala-sbt_compiler-bridge_2.13-1.11.0" = fetchMaven {
    name = "org.scala-sbt_compiler-bridge_2.13-1.11.0";
    urls = [
      "https://repo1.maven.org/maven2/org/scala-sbt/compiler-bridge_2.13/1.11.0/compiler-bridge_2.13-1.11.0-sources.jar"
      "https://repo1.maven.org/maven2/org/scala-sbt/compiler-bridge_2.13/1.11.0/compiler-bridge_2.13-1.11.0.jar"
      "https://repo1.maven.org/maven2/org/scala-sbt/compiler-bridge_2.13/1.11.0/compiler-bridge_2.13-1.11.0.pom"
    ];
    hash = "sha256-zwGpWyj9qUxiAhgulQrfI7QoxmJ4Iqaq/JG+wTceF6s=";
    installPath = "https/repo1.maven.org/maven2/org/scala-sbt/compiler-bridge_2.13/1.11.0";
  };

  "org.scala-sbt_compiler-interface-1.10.0" = fetchMaven {
    name = "org.scala-sbt_compiler-interface-1.10.0";
    urls = [
      "https://repo1.maven.org/maven2/org/scala-sbt/compiler-interface/1.10.0/compiler-interface-1.10.0.jar"
      "https://repo1.maven.org/maven2/org/scala-sbt/compiler-interface/1.10.0/compiler-interface-1.10.0.pom"
    ];
    hash = "sha256-bpYU74YwRESRBkSMomtxjgzATk3HkTpJYnEBK+/LJ+w=";
    installPath = "https/repo1.maven.org/maven2/org/scala-sbt/compiler-interface/1.10.0";
  };

  "org.scala-sbt_compiler-interface-1.10.3" = fetchMaven {
    name = "org.scala-sbt_compiler-interface-1.10.3";
    urls = [
      "https://repo1.maven.org/maven2/org/scala-sbt/compiler-interface/1.10.3/compiler-interface-1.10.3.jar"
      "https://repo1.maven.org/maven2/org/scala-sbt/compiler-interface/1.10.3/compiler-interface-1.10.3.pom"
    ];
    hash = "sha256-eUpVhTZhe/6qSWs+XkD7bDhrqCv893HCNme7G4yPyeg=";
    installPath = "https/repo1.maven.org/maven2/org/scala-sbt/compiler-interface/1.10.3";
  };

  "org.scala-sbt_compiler-interface-1.10.7" = fetchMaven {
    name = "org.scala-sbt_compiler-interface-1.10.7";
    urls = [
      "https://repo1.maven.org/maven2/org/scala-sbt/compiler-interface/1.10.7/compiler-interface-1.10.7.jar"
      "https://repo1.maven.org/maven2/org/scala-sbt/compiler-interface/1.10.7/compiler-interface-1.10.7.pom"
    ];
    hash = "sha256-nFVs4vEVTEPSiGce3C77TTjvffSU+SMrn9KgV9xGVP0=";
    installPath = "https/repo1.maven.org/maven2/org/scala-sbt/compiler-interface/1.10.7";
  };

  "org.scala-sbt_compiler-interface-1.10.8" = fetchMaven {
    name = "org.scala-sbt_compiler-interface-1.10.8";
    urls = [
      "https://repo1.maven.org/maven2/org/scala-sbt/compiler-interface/1.10.8/compiler-interface-1.10.8.jar"
      "https://repo1.maven.org/maven2/org/scala-sbt/compiler-interface/1.10.8/compiler-interface-1.10.8.pom"
    ];
    hash = "sha256-3ajeQYhoP+Vqe05uXnwbwA5KAgIeLizUM6rorISKVMU=";
    installPath = "https/repo1.maven.org/maven2/org/scala-sbt/compiler-interface/1.10.8";
  };

  "org.scala-sbt_compiler-interface-1.11.0" = fetchMaven {
    name = "org.scala-sbt_compiler-interface-1.11.0";
    urls = [
      "https://repo1.maven.org/maven2/org/scala-sbt/compiler-interface/1.11.0/compiler-interface-1.11.0-sources.jar"
      "https://repo1.maven.org/maven2/org/scala-sbt/compiler-interface/1.11.0/compiler-interface-1.11.0.jar"
      "https://repo1.maven.org/maven2/org/scala-sbt/compiler-interface/1.11.0/compiler-interface-1.11.0.pom"
    ];
    hash = "sha256-mjHxsvEgFfq9+wMpVukapMCFu6Qe7xZDT8X4oIjeCNs=";
    installPath = "https/repo1.maven.org/maven2/org/scala-sbt/compiler-interface/1.11.0";
  };

  "org.scala-sbt_compiler-interface-1.8.1" = fetchMaven {
    name = "org.scala-sbt_compiler-interface-1.8.1";
    urls = [
      "https://repo1.maven.org/maven2/org/scala-sbt/compiler-interface/1.8.1/compiler-interface-1.8.1.jar"
      "https://repo1.maven.org/maven2/org/scala-sbt/compiler-interface/1.8.1/compiler-interface-1.8.1.pom"
    ];
    hash = "sha256-ZDa2ylrKTUBR6cz497JOsWG6Ry1wCR6WDiDANIa1yPk=";
    installPath = "https/repo1.maven.org/maven2/org/scala-sbt/compiler-interface/1.8.1";
  };

  "org.scala-sbt_compiler-interface-1.9.5" = fetchMaven {
    name = "org.scala-sbt_compiler-interface-1.9.5";
    urls = [
      "https://repo1.maven.org/maven2/org/scala-sbt/compiler-interface/1.9.5/compiler-interface-1.9.5.jar"
      "https://repo1.maven.org/maven2/org/scala-sbt/compiler-interface/1.9.5/compiler-interface-1.9.5.pom"
    ];
    hash = "sha256-/kx55BDpsnMpIqSGTHMg+zwfn4/8Ezvl/Lv3z+ClpnI=";
    installPath = "https/repo1.maven.org/maven2/org/scala-sbt/compiler-interface/1.9.5";
  };

  "org.scala-sbt_compiler-interface-1.9.6" = fetchMaven {
    name = "org.scala-sbt_compiler-interface-1.9.6";
    urls = [
      "https://repo1.maven.org/maven2/org/scala-sbt/compiler-interface/1.9.6/compiler-interface-1.9.6.jar"
      "https://repo1.maven.org/maven2/org/scala-sbt/compiler-interface/1.9.6/compiler-interface-1.9.6.pom"
    ];
    hash = "sha256-spep2us0CWZiButV6u4/nJyRqQozTEuo83z0CR/5cos=";
    installPath = "https/repo1.maven.org/maven2/org/scala-sbt/compiler-interface/1.9.6";
  };

  "org.scala-sbt_core-macros_2.13-1.11.5" = fetchMaven {
    name = "org.scala-sbt_core-macros_2.13-1.11.5";
    urls = [
      "https://repo1.maven.org/maven2/org/scala-sbt/core-macros_2.13/1.11.5/core-macros_2.13-1.11.5.jar"
      "https://repo1.maven.org/maven2/org/scala-sbt/core-macros_2.13/1.11.5/core-macros_2.13-1.11.5.pom"
    ];
    hash = "sha256-HjbAm7VhBb9QkZQMK/Tqk/x0t9CizS9qwDSXSOd6+nY=";
    installPath = "https/repo1.maven.org/maven2/org/scala-sbt/core-macros_2.13/1.11.5";
  };

  "org.scala-sbt_io_2.13-1.10.5" = fetchMaven {
    name = "org.scala-sbt_io_2.13-1.10.5";
    urls = [
      "https://repo1.maven.org/maven2/org/scala-sbt/io_2.13/1.10.5/io_2.13-1.10.5.jar"
      "https://repo1.maven.org/maven2/org/scala-sbt/io_2.13/1.10.5/io_2.13-1.10.5.pom"
    ];
    hash = "sha256-MyKsd3DGU6RtsAmSk3L09f8LJOKz3WZbv+/4Vrl4ZDI=";
    installPath = "https/repo1.maven.org/maven2/org/scala-sbt/io_2.13/1.10.5";
  };

  "org.scala-sbt_launcher-interface-1.4.4" = fetchMaven {
    name = "org.scala-sbt_launcher-interface-1.4.4";
    urls = [
      "https://repo1.maven.org/maven2/org/scala-sbt/launcher-interface/1.4.4/launcher-interface-1.4.4.jar"
      "https://repo1.maven.org/maven2/org/scala-sbt/launcher-interface/1.4.4/launcher-interface-1.4.4.pom"
    ];
    hash = "sha256-HWiEWRS8Grm7uQME6o7FYZFhWvJgvrvyxKXMATB0Z7E=";
    installPath = "https/repo1.maven.org/maven2/org/scala-sbt/launcher-interface/1.4.4";
  };

  "org.scala-sbt_sbinary_2.13-0.5.1" = fetchMaven {
    name = "org.scala-sbt_sbinary_2.13-0.5.1";
    urls = [
      "https://repo1.maven.org/maven2/org/scala-sbt/sbinary_2.13/0.5.1/sbinary_2.13-0.5.1.jar"
      "https://repo1.maven.org/maven2/org/scala-sbt/sbinary_2.13/0.5.1/sbinary_2.13-0.5.1.pom"
    ];
    hash = "sha256-+TrjPjSy8WVXq3IYHkHHIzttvHQbgwMLkwwWBys/ryw=";
    installPath = "https/repo1.maven.org/maven2/org/scala-sbt/sbinary_2.13/0.5.1";
  };

  "org.scala-sbt_test-interface-1.0" = fetchMaven {
    name = "org.scala-sbt_test-interface-1.0";
    urls = [
      "https://repo1.maven.org/maven2/org/scala-sbt/test-interface/1.0/test-interface-1.0.jar"
      "https://repo1.maven.org/maven2/org/scala-sbt/test-interface/1.0/test-interface-1.0.pom"
    ];
    hash = "sha256-Cc5Q+4mULLHRdw+7Wjx6spCLbKrckXHeNYjIibw4LWw=";
    installPath = "https/repo1.maven.org/maven2/org/scala-sbt/test-interface/1.0";
  };

  "org.scala-sbt_util-control_2.13-1.11.5" = fetchMaven {
    name = "org.scala-sbt_util-control_2.13-1.11.5";
    urls = [
      "https://repo1.maven.org/maven2/org/scala-sbt/util-control_2.13/1.11.5/util-control_2.13-1.11.5.jar"
      "https://repo1.maven.org/maven2/org/scala-sbt/util-control_2.13/1.11.5/util-control_2.13-1.11.5.pom"
    ];
    hash = "sha256-78DjuZOAiY2WoHBZtx4/V1wjR/TCuO1gruP8w54mr+Y=";
    installPath = "https/repo1.maven.org/maven2/org/scala-sbt/util-control_2.13/1.11.5";
  };

  "org.scala-sbt_util-interface-1.10.0" = fetchMaven {
    name = "org.scala-sbt_util-interface-1.10.0";
    urls = [
      "https://repo1.maven.org/maven2/org/scala-sbt/util-interface/1.10.0/util-interface-1.10.0.jar"
      "https://repo1.maven.org/maven2/org/scala-sbt/util-interface/1.10.0/util-interface-1.10.0.pom"
    ];
    hash = "sha256-M5aec33ZuPmuY6CNjd9qhNlpxqxG5ktQBxb7rUUpdA4=";
    installPath = "https/repo1.maven.org/maven2/org/scala-sbt/util-interface/1.10.0";
  };

  "org.scala-sbt_util-interface-1.10.3" = fetchMaven {
    name = "org.scala-sbt_util-interface-1.10.3";
    urls = [
      "https://repo1.maven.org/maven2/org/scala-sbt/util-interface/1.10.3/util-interface-1.10.3.jar"
      "https://repo1.maven.org/maven2/org/scala-sbt/util-interface/1.10.3/util-interface-1.10.3.pom"
    ];
    hash = "sha256-uu+2jvXfm2FaHkvJb44uRGdelrtS9pLfolU977MMQj0=";
    installPath = "https/repo1.maven.org/maven2/org/scala-sbt/util-interface/1.10.3";
  };

  "org.scala-sbt_util-interface-1.10.7" = fetchMaven {
    name = "org.scala-sbt_util-interface-1.10.7";
    urls = [
      "https://repo1.maven.org/maven2/org/scala-sbt/util-interface/1.10.7/util-interface-1.10.7.jar"
      "https://repo1.maven.org/maven2/org/scala-sbt/util-interface/1.10.7/util-interface-1.10.7.pom"
    ];
    hash = "sha256-cIOD5+vCDptOP6jwds5yG+23h2H54npBzGu3jrCQlvQ=";
    installPath = "https/repo1.maven.org/maven2/org/scala-sbt/util-interface/1.10.7";
  };

  "org.scala-sbt_util-interface-1.10.8" = fetchMaven {
    name = "org.scala-sbt_util-interface-1.10.8";
    urls = [
      "https://repo1.maven.org/maven2/org/scala-sbt/util-interface/1.10.8/util-interface-1.10.8.jar"
      "https://repo1.maven.org/maven2/org/scala-sbt/util-interface/1.10.8/util-interface-1.10.8.pom"
    ];
    hash = "sha256-gG7jvX9By0LLoZIyzdSUvWnfMBiaR7MGtSywz5lM5JM=";
    installPath = "https/repo1.maven.org/maven2/org/scala-sbt/util-interface/1.10.8";
  };

  "org.scala-sbt_util-interface-1.11.5" = fetchMaven {
    name = "org.scala-sbt_util-interface-1.11.5";
    urls = [
      "https://repo1.maven.org/maven2/org/scala-sbt/util-interface/1.11.5/util-interface-1.11.5-sources.jar"
      "https://repo1.maven.org/maven2/org/scala-sbt/util-interface/1.11.5/util-interface-1.11.5.jar"
      "https://repo1.maven.org/maven2/org/scala-sbt/util-interface/1.11.5/util-interface-1.11.5.pom"
    ];
    hash = "sha256-x57T+PYlVtgxFIqrqNVG21f0wFNB7GWxSLMH4JgJJEc=";
    installPath = "https/repo1.maven.org/maven2/org/scala-sbt/util-interface/1.11.5";
  };

  "org.scala-sbt_util-interface-1.8.2" = fetchMaven {
    name = "org.scala-sbt_util-interface-1.8.2";
    urls = [
      "https://repo1.maven.org/maven2/org/scala-sbt/util-interface/1.8.2/util-interface-1.8.2.jar"
      "https://repo1.maven.org/maven2/org/scala-sbt/util-interface/1.8.2/util-interface-1.8.2.pom"
    ];
    hash = "sha256-lPAZzAlj36mUYzNyjEeVuUw3iLCaxrgDiRG+9e7ttWM=";
    installPath = "https/repo1.maven.org/maven2/org/scala-sbt/util-interface/1.8.2";
  };

  "org.scala-sbt_util-interface-1.9.4" = fetchMaven {
    name = "org.scala-sbt_util-interface-1.9.4";
    urls = [
      "https://repo1.maven.org/maven2/org/scala-sbt/util-interface/1.9.4/util-interface-1.9.4.jar"
      "https://repo1.maven.org/maven2/org/scala-sbt/util-interface/1.9.4/util-interface-1.9.4.pom"
    ];
    hash = "sha256-tljMmr/UKrmc5bPiEaEd962zf5zS1iavRbjSWZg+jxE=";
    installPath = "https/repo1.maven.org/maven2/org/scala-sbt/util-interface/1.9.4";
  };

  "org.scala-sbt_util-interface-1.9.8" = fetchMaven {
    name = "org.scala-sbt_util-interface-1.9.8";
    urls = [
      "https://repo1.maven.org/maven2/org/scala-sbt/util-interface/1.9.8/util-interface-1.9.8.jar"
      "https://repo1.maven.org/maven2/org/scala-sbt/util-interface/1.9.8/util-interface-1.9.8.pom"
    ];
    hash = "sha256-7PoE3Jj8JSBaNeK3IzCSlkwArEWP1Zo+XBn0OorE1I8=";
    installPath = "https/repo1.maven.org/maven2/org/scala-sbt/util-interface/1.9.8";
  };

  "org.scala-sbt_util-logging_2.13-1.11.5" = fetchMaven {
    name = "org.scala-sbt_util-logging_2.13-1.11.5";
    urls = [
      "https://repo1.maven.org/maven2/org/scala-sbt/util-logging_2.13/1.11.5/util-logging_2.13-1.11.5.jar"
      "https://repo1.maven.org/maven2/org/scala-sbt/util-logging_2.13/1.11.5/util-logging_2.13-1.11.5.pom"
    ];
    hash = "sha256-Dn2SYm8/GmsUziGtjLHLVB2X4JUJt8rlxt16ZQ6PFS4=";
    installPath = "https/repo1.maven.org/maven2/org/scala-sbt/util-logging_2.13/1.11.5";
  };

  "org.scala-sbt_util-position_2.13-1.11.5" = fetchMaven {
    name = "org.scala-sbt_util-position_2.13-1.11.5";
    urls = [
      "https://repo1.maven.org/maven2/org/scala-sbt/util-position_2.13/1.11.5/util-position_2.13-1.11.5.jar"
      "https://repo1.maven.org/maven2/org/scala-sbt/util-position_2.13/1.11.5/util-position_2.13-1.11.5.pom"
    ];
    hash = "sha256-KkVlO231rpf9BYQPIbPJKoUU7Fjl0AO+O8liWo5eHx4=";
    installPath = "https/repo1.maven.org/maven2/org/scala-sbt/util-position_2.13/1.11.5";
  };

  "org.scala-sbt_util-relation_2.13-1.11.5" = fetchMaven {
    name = "org.scala-sbt_util-relation_2.13-1.11.5";
    urls = [
      "https://repo1.maven.org/maven2/org/scala-sbt/util-relation_2.13/1.11.5/util-relation_2.13-1.11.5.jar"
      "https://repo1.maven.org/maven2/org/scala-sbt/util-relation_2.13/1.11.5/util-relation_2.13-1.11.5.pom"
    ];
    hash = "sha256-O06iXXGFcqFcd5cMvW7BQeic2HPHsNWsKHY7G9eWnE0=";
    installPath = "https/repo1.maven.org/maven2/org/scala-sbt/util-relation_2.13/1.11.5";
  };

  "org.scala-sbt_zinc-apiinfo_2.13-1.11.0" = fetchMaven {
    name = "org.scala-sbt_zinc-apiinfo_2.13-1.11.0";
    urls = [
      "https://repo1.maven.org/maven2/org/scala-sbt/zinc-apiinfo_2.13/1.11.0/zinc-apiinfo_2.13-1.11.0.jar"
      "https://repo1.maven.org/maven2/org/scala-sbt/zinc-apiinfo_2.13/1.11.0/zinc-apiinfo_2.13-1.11.0.pom"
    ];
    hash = "sha256-AYUxrGxu0q5ag82kEUUKgzDbUwaENVv0gh1lj25jmsk=";
    installPath = "https/repo1.maven.org/maven2/org/scala-sbt/zinc-apiinfo_2.13/1.11.0";
  };

  "org.scala-sbt_zinc-classfile_2.13-1.11.0" = fetchMaven {
    name = "org.scala-sbt_zinc-classfile_2.13-1.11.0";
    urls = [
      "https://repo1.maven.org/maven2/org/scala-sbt/zinc-classfile_2.13/1.11.0/zinc-classfile_2.13-1.11.0.jar"
      "https://repo1.maven.org/maven2/org/scala-sbt/zinc-classfile_2.13/1.11.0/zinc-classfile_2.13-1.11.0.pom"
    ];
    hash = "sha256-9WSfV9xawT6CFrUwJE3S/FaLXIpwvs4Oi5uL78Lw7Wo=";
    installPath = "https/repo1.maven.org/maven2/org/scala-sbt/zinc-classfile_2.13/1.11.0";
  };

  "org.scala-sbt_zinc-classpath_2.13-1.11.0" = fetchMaven {
    name = "org.scala-sbt_zinc-classpath_2.13-1.11.0";
    urls = [
      "https://repo1.maven.org/maven2/org/scala-sbt/zinc-classpath_2.13/1.11.0/zinc-classpath_2.13-1.11.0.jar"
      "https://repo1.maven.org/maven2/org/scala-sbt/zinc-classpath_2.13/1.11.0/zinc-classpath_2.13-1.11.0.pom"
    ];
    hash = "sha256-26Um+mDI/rVmSasaWHBztPT3zJ/5XSXGgtH8aZmQswQ=";
    installPath = "https/repo1.maven.org/maven2/org/scala-sbt/zinc-classpath_2.13/1.11.0";
  };

  "org.scala-sbt_zinc-compile-core_2.13-1.11.0" = fetchMaven {
    name = "org.scala-sbt_zinc-compile-core_2.13-1.11.0";
    urls = [
      "https://repo1.maven.org/maven2/org/scala-sbt/zinc-compile-core_2.13/1.11.0/zinc-compile-core_2.13-1.11.0.jar"
      "https://repo1.maven.org/maven2/org/scala-sbt/zinc-compile-core_2.13/1.11.0/zinc-compile-core_2.13-1.11.0.pom"
    ];
    hash = "sha256-esANv/MT6TOttArli9wM2Kba8lxUlxt3dR8COPely3I=";
    installPath = "https/repo1.maven.org/maven2/org/scala-sbt/zinc-compile-core_2.13/1.11.0";
  };

  "org.scala-sbt_zinc-core_2.13-1.11.0" = fetchMaven {
    name = "org.scala-sbt_zinc-core_2.13-1.11.0";
    urls = [
      "https://repo1.maven.org/maven2/org/scala-sbt/zinc-core_2.13/1.11.0/zinc-core_2.13-1.11.0.jar"
      "https://repo1.maven.org/maven2/org/scala-sbt/zinc-core_2.13/1.11.0/zinc-core_2.13-1.11.0.pom"
    ];
    hash = "sha256-1Vk1fzbRGL9+JvMUUuwQEeHqRmsN3qjv4qk0wfcCN5o=";
    installPath = "https/repo1.maven.org/maven2/org/scala-sbt/zinc-core_2.13/1.11.0";
  };

  "org.scala-sbt_zinc-persist-core-assembly-1.11.0" = fetchMaven {
    name = "org.scala-sbt_zinc-persist-core-assembly-1.11.0";
    urls = [
      "https://repo1.maven.org/maven2/org/scala-sbt/zinc-persist-core-assembly/1.11.0/zinc-persist-core-assembly-1.11.0.jar"
      "https://repo1.maven.org/maven2/org/scala-sbt/zinc-persist-core-assembly/1.11.0/zinc-persist-core-assembly-1.11.0.pom"
    ];
    hash = "sha256-LxOIbNTlXpKsp6A5poaYIsxc8V2kSTkDq7Ov42l1ppQ=";
    installPath = "https/repo1.maven.org/maven2/org/scala-sbt/zinc-persist-core-assembly/1.11.0";
  };

  "org.scala-sbt_zinc-persist_2.13-1.11.0" = fetchMaven {
    name = "org.scala-sbt_zinc-persist_2.13-1.11.0";
    urls = [
      "https://repo1.maven.org/maven2/org/scala-sbt/zinc-persist_2.13/1.11.0/zinc-persist_2.13-1.11.0.jar"
      "https://repo1.maven.org/maven2/org/scala-sbt/zinc-persist_2.13/1.11.0/zinc-persist_2.13-1.11.0.pom"
    ];
    hash = "sha256-Cd9koisM+45NdVRRc8SJR5uLXbHcPGYAVhkb100VSvw=";
    installPath = "https/repo1.maven.org/maven2/org/scala-sbt/zinc-persist_2.13/1.11.0";
  };

  "org.scala-sbt_zinc_2.13-1.11.0" = fetchMaven {
    name = "org.scala-sbt_zinc_2.13-1.11.0";
    urls = [
      "https://repo1.maven.org/maven2/org/scala-sbt/zinc_2.13/1.11.0/zinc_2.13-1.11.0.jar"
      "https://repo1.maven.org/maven2/org/scala-sbt/zinc_2.13/1.11.0/zinc_2.13-1.11.0.pom"
    ];
    hash = "sha256-ElGS5e25dr10KfzTNlrNruytEWpb/qnaonHWNMlgPbQ=";
    installPath = "https/repo1.maven.org/maven2/org/scala-sbt/zinc_2.13/1.11.0";
  };

  "org.scalacheck_scalacheck_2.13-1.18.0" = fetchMaven {
    name = "org.scalacheck_scalacheck_2.13-1.18.0";
    urls = [
      "https://repo1.maven.org/maven2/org/scalacheck/scalacheck_2.13/1.18.0/scalacheck_2.13-1.18.0.jar"
      "https://repo1.maven.org/maven2/org/scalacheck/scalacheck_2.13/1.18.0/scalacheck_2.13-1.18.0.pom"
    ];
    hash = "sha256-ZkAtOjkLULHSf0IgmrR0y61dYLYo4GPil981lX/Oe+k=";
    installPath = "https/repo1.maven.org/maven2/org/scalacheck/scalacheck_2.13/1.18.0";
  };

  "org.scalacheck_scalacheck_3-1.18.0" = fetchMaven {
    name = "org.scalacheck_scalacheck_3-1.18.0";
    urls = [
      "https://repo1.maven.org/maven2/org/scalacheck/scalacheck_3/1.18.0/scalacheck_3-1.18.0.jar"
      "https://repo1.maven.org/maven2/org/scalacheck/scalacheck_3/1.18.0/scalacheck_3-1.18.0.pom"
    ];
    hash = "sha256-T4HLW91uTkm6TeG+vRlgI+Tjn7WRBEQzi9THYuSZ+lk=";
    installPath = "https/repo1.maven.org/maven2/org/scalacheck/scalacheck_3/1.18.0";
  };

  "org.scalactic_scalactic_2.13-3.2.19" = fetchMaven {
    name = "org.scalactic_scalactic_2.13-3.2.19";
    urls = [
      "https://repo1.maven.org/maven2/org/scalactic/scalactic_2.13/3.2.19/scalactic_2.13-3.2.19.jar"
      "https://repo1.maven.org/maven2/org/scalactic/scalactic_2.13/3.2.19/scalactic_2.13-3.2.19.pom"
    ];
    hash = "sha256-qac/w1XSNFIJ3jVR0xFmX3cyaYqCQrXYHjt7U4lmzUY=";
    installPath = "https/repo1.maven.org/maven2/org/scalactic/scalactic_2.13/3.2.19";
  };

  "org.scalactic_scalactic_3-3.2.19" = fetchMaven {
    name = "org.scalactic_scalactic_3-3.2.19";
    urls = [
      "https://repo1.maven.org/maven2/org/scalactic/scalactic_3/3.2.19/scalactic_3-3.2.19.jar"
      "https://repo1.maven.org/maven2/org/scalactic/scalactic_3/3.2.19/scalactic_3-3.2.19.pom"
    ];
    hash = "sha256-Jqhhu6THq0KRcOjgCCQTiDGaUujLx6W+qK15Tocv6+8=";
    installPath = "https/repo1.maven.org/maven2/org/scalactic/scalactic_3/3.2.19";
  };

  "org.scalameta_common_2.13-4.13.8" = fetchMaven {
    name = "org.scalameta_common_2.13-4.13.8";
    urls = [
      "https://repo1.maven.org/maven2/org/scalameta/common_2.13/4.13.8/common_2.13-4.13.8.jar"
      "https://repo1.maven.org/maven2/org/scalameta/common_2.13/4.13.8/common_2.13-4.13.8.pom"
    ];
    hash = "sha256-9ibv49oA6W4lQLVu4JOy3kmVenjqbm9sgiKvKoJxzqw=";
    installPath = "https/repo1.maven.org/maven2/org/scalameta/common_2.13/4.13.8";
  };

  "org.scalameta_io_2.13-4.13.8" = fetchMaven {
    name = "org.scalameta_io_2.13-4.13.8";
    urls = [
      "https://repo1.maven.org/maven2/org/scalameta/io_2.13/4.13.8/io_2.13-4.13.8.jar"
      "https://repo1.maven.org/maven2/org/scalameta/io_2.13/4.13.8/io_2.13-4.13.8.pom"
    ];
    hash = "sha256-mVICy6QarZfS+uUrHyk2shOWZob9z5pQx8HzoauWoLs=";
    installPath = "https/repo1.maven.org/maven2/org/scalameta/io_2.13/4.13.8";
  };

  "org.scalameta_mdoc-cli_2.13-2.7.2" = fetchMaven {
    name = "org.scalameta_mdoc-cli_2.13-2.7.2";
    urls = [
      "https://repo1.maven.org/maven2/org/scalameta/mdoc-cli_2.13/2.7.2/mdoc-cli_2.13-2.7.2.jar"
      "https://repo1.maven.org/maven2/org/scalameta/mdoc-cli_2.13/2.7.2/mdoc-cli_2.13-2.7.2.pom"
    ];
    hash = "sha256-6AAeSvrS8KhoQM4sZjOZS4PR1SrXrNSoH1VdcxsvnLk=";
    installPath = "https/repo1.maven.org/maven2/org/scalameta/mdoc-cli_2.13/2.7.2";
  };

  "org.scalameta_mdoc-interfaces-2.7.2" = fetchMaven {
    name = "org.scalameta_mdoc-interfaces-2.7.2";
    urls = [
      "https://repo1.maven.org/maven2/org/scalameta/mdoc-interfaces/2.7.2/mdoc-interfaces-2.7.2.jar"
      "https://repo1.maven.org/maven2/org/scalameta/mdoc-interfaces/2.7.2/mdoc-interfaces-2.7.2.pom"
    ];
    hash = "sha256-OxWf7Waxa9R+2ar3xtmlI2JCvw1IQkasRoKGqYcFdTY=";
    installPath = "https/repo1.maven.org/maven2/org/scalameta/mdoc-interfaces/2.7.2";
  };

  "org.scalameta_mdoc-parser_2.13-2.7.2" = fetchMaven {
    name = "org.scalameta_mdoc-parser_2.13-2.7.2";
    urls = [
      "https://repo1.maven.org/maven2/org/scalameta/mdoc-parser_2.13/2.7.2/mdoc-parser_2.13-2.7.2.jar"
      "https://repo1.maven.org/maven2/org/scalameta/mdoc-parser_2.13/2.7.2/mdoc-parser_2.13-2.7.2.pom"
    ];
    hash = "sha256-1VJ5sVzLJY2zZzjOIry6OoeDV6XQ0AjKpg0FlLuwjR8=";
    installPath = "https/repo1.maven.org/maven2/org/scalameta/mdoc-parser_2.13/2.7.2";
  };

  "org.scalameta_mdoc-runtime_2.13-2.7.2" = fetchMaven {
    name = "org.scalameta_mdoc-runtime_2.13-2.7.2";
    urls = [
      "https://repo1.maven.org/maven2/org/scalameta/mdoc-runtime_2.13/2.7.2/mdoc-runtime_2.13-2.7.2.jar"
      "https://repo1.maven.org/maven2/org/scalameta/mdoc-runtime_2.13/2.7.2/mdoc-runtime_2.13-2.7.2.pom"
    ];
    hash = "sha256-4e7aJUuPBJK+InjomVSX3YjxbpRk6SrIgLGeS1rMFjU=";
    installPath = "https/repo1.maven.org/maven2/org/scalameta/mdoc-runtime_2.13/2.7.2";
  };

  "org.scalameta_mdoc_2.13-2.7.2" = fetchMaven {
    name = "org.scalameta_mdoc_2.13-2.7.2";
    urls = [
      "https://repo1.maven.org/maven2/org/scalameta/mdoc_2.13/2.7.2/mdoc_2.13-2.7.2.jar"
      "https://repo1.maven.org/maven2/org/scalameta/mdoc_2.13/2.7.2/mdoc_2.13-2.7.2.pom"
    ];
    hash = "sha256-Y3c7Mj76YVY3hpQjQV4tfJV2O3rRx9/V4CR4NkdgXsU=";
    installPath = "https/repo1.maven.org/maven2/org/scalameta/mdoc_2.13/2.7.2";
  };

  "org.scalameta_metaconfig-core_2.13-0.16.0" = fetchMaven {
    name = "org.scalameta_metaconfig-core_2.13-0.16.0";
    urls = [
      "https://repo1.maven.org/maven2/org/scalameta/metaconfig-core_2.13/0.16.0/metaconfig-core_2.13-0.16.0.jar"
      "https://repo1.maven.org/maven2/org/scalameta/metaconfig-core_2.13/0.16.0/metaconfig-core_2.13-0.16.0.pom"
    ];
    hash = "sha256-3xVDhx19yfcXxJmE1JmQQV48nR2maLE/egx1pmrD6f8=";
    installPath = "https/repo1.maven.org/maven2/org/scalameta/metaconfig-core_2.13/0.16.0";
  };

  "org.scalameta_metaconfig-pprint_2.13-0.16.0" = fetchMaven {
    name = "org.scalameta_metaconfig-pprint_2.13-0.16.0";
    urls = [
      "https://repo1.maven.org/maven2/org/scalameta/metaconfig-pprint_2.13/0.16.0/metaconfig-pprint_2.13-0.16.0.jar"
      "https://repo1.maven.org/maven2/org/scalameta/metaconfig-pprint_2.13/0.16.0/metaconfig-pprint_2.13-0.16.0.pom"
    ];
    hash = "sha256-RKJs0QOWox70zTcjtKdYchJszo++PvtFJr4SLyUjDBk=";
    installPath = "https/repo1.maven.org/maven2/org/scalameta/metaconfig-pprint_2.13/0.16.0";
  };

  "org.scalameta_metaconfig-typesafe-config_2.13-0.16.0" = fetchMaven {
    name = "org.scalameta_metaconfig-typesafe-config_2.13-0.16.0";
    urls = [
      "https://repo1.maven.org/maven2/org/scalameta/metaconfig-typesafe-config_2.13/0.16.0/metaconfig-typesafe-config_2.13-0.16.0.jar"
      "https://repo1.maven.org/maven2/org/scalameta/metaconfig-typesafe-config_2.13/0.16.0/metaconfig-typesafe-config_2.13-0.16.0.pom"
    ];
    hash = "sha256-n8rODFLTdkrpbEZYd2xP1ClnB6SsVYCe7j39HZryG20=";
    installPath = "https/repo1.maven.org/maven2/org/scalameta/metaconfig-typesafe-config_2.13/0.16.0";
  };

  "org.scalameta_parsers_2.13-4.13.8" = fetchMaven {
    name = "org.scalameta_parsers_2.13-4.13.8";
    urls = [
      "https://repo1.maven.org/maven2/org/scalameta/parsers_2.13/4.13.8/parsers_2.13-4.13.8.jar"
      "https://repo1.maven.org/maven2/org/scalameta/parsers_2.13/4.13.8/parsers_2.13-4.13.8.pom"
    ];
    hash = "sha256-GwvgS/aoXYz04MB0moJ5/U7hhfkXu4ybszwtUg+Mnq8=";
    installPath = "https/repo1.maven.org/maven2/org/scalameta/parsers_2.13/4.13.8";
  };

  "org.scalameta_scalameta_2.13-4.13.8" = fetchMaven {
    name = "org.scalameta_scalameta_2.13-4.13.8";
    urls = [
      "https://repo1.maven.org/maven2/org/scalameta/scalameta_2.13/4.13.8/scalameta_2.13-4.13.8.jar"
      "https://repo1.maven.org/maven2/org/scalameta/scalameta_2.13/4.13.8/scalameta_2.13-4.13.8.pom"
    ];
    hash = "sha256-bjMvmVt2r2QWhZzmePT9hpuxltLS+gIK9NK50T9TFyQ=";
    installPath = "https/repo1.maven.org/maven2/org/scalameta/scalameta_2.13/4.13.8";
  };

  "org.scalameta_trees_2.13-4.13.8" = fetchMaven {
    name = "org.scalameta_trees_2.13-4.13.8";
    urls = [
      "https://repo1.maven.org/maven2/org/scalameta/trees_2.13/4.13.8/trees_2.13-4.13.8.jar"
      "https://repo1.maven.org/maven2/org/scalameta/trees_2.13/4.13.8/trees_2.13-4.13.8.pom"
    ];
    hash = "sha256-tSyJ7/ec/4g/NpPJaoeDMRJjA25Eai4EBWLOhqrrtTE=";
    installPath = "https/repo1.maven.org/maven2/org/scalameta/trees_2.13/4.13.8";
  };

  "org.scalatest_scalatest-compatible-3.2.19" = fetchMaven {
    name = "org.scalatest_scalatest-compatible-3.2.19";
    urls = [
      "https://repo1.maven.org/maven2/org/scalatest/scalatest-compatible/3.2.19/scalatest-compatible-3.2.19.jar"
      "https://repo1.maven.org/maven2/org/scalatest/scalatest-compatible/3.2.19/scalatest-compatible-3.2.19.pom"
    ];
    hash = "sha256-u8EPlJzg0p/4ysBFoSEN9GC6qlacv1f5vQoShjWXZHc=";
    installPath = "https/repo1.maven.org/maven2/org/scalatest/scalatest-compatible/3.2.19";
  };

  "org.scalatest_scalatest-core_2.13-3.2.19" = fetchMaven {
    name = "org.scalatest_scalatest-core_2.13-3.2.19";
    urls = [
      "https://repo1.maven.org/maven2/org/scalatest/scalatest-core_2.13/3.2.19/scalatest-core_2.13-3.2.19.jar"
      "https://repo1.maven.org/maven2/org/scalatest/scalatest-core_2.13/3.2.19/scalatest-core_2.13-3.2.19.pom"
    ];
    hash = "sha256-m4W3GpDNdw6Mycpf18sb0HrRf/6d6+SIqthBYV/8fbA=";
    installPath = "https/repo1.maven.org/maven2/org/scalatest/scalatest-core_2.13/3.2.19";
  };

  "org.scalatest_scalatest-core_3-3.2.19" = fetchMaven {
    name = "org.scalatest_scalatest-core_3-3.2.19";
    urls = [
      "https://repo1.maven.org/maven2/org/scalatest/scalatest-core_3/3.2.19/scalatest-core_3-3.2.19.jar"
      "https://repo1.maven.org/maven2/org/scalatest/scalatest-core_3/3.2.19/scalatest-core_3-3.2.19.pom"
    ];
    hash = "sha256-hWwLH3Ax2wtIPtrR4HVtELM5+MZ8V5I8xce8ywUOMe0=";
    installPath = "https/repo1.maven.org/maven2/org/scalatest/scalatest-core_3/3.2.19";
  };

  "org.scalatest_scalatest-diagrams_2.13-3.2.19" = fetchMaven {
    name = "org.scalatest_scalatest-diagrams_2.13-3.2.19";
    urls = [
      "https://repo1.maven.org/maven2/org/scalatest/scalatest-diagrams_2.13/3.2.19/scalatest-diagrams_2.13-3.2.19.jar"
      "https://repo1.maven.org/maven2/org/scalatest/scalatest-diagrams_2.13/3.2.19/scalatest-diagrams_2.13-3.2.19.pom"
    ];
    hash = "sha256-v0VWhShh7OFf3Ef43Aqwc9uOpSvQbpuu9XXjSp33k3c=";
    installPath = "https/repo1.maven.org/maven2/org/scalatest/scalatest-diagrams_2.13/3.2.19";
  };

  "org.scalatest_scalatest-diagrams_3-3.2.19" = fetchMaven {
    name = "org.scalatest_scalatest-diagrams_3-3.2.19";
    urls = [
      "https://repo1.maven.org/maven2/org/scalatest/scalatest-diagrams_3/3.2.19/scalatest-diagrams_3-3.2.19.jar"
      "https://repo1.maven.org/maven2/org/scalatest/scalatest-diagrams_3/3.2.19/scalatest-diagrams_3-3.2.19.pom"
    ];
    hash = "sha256-ZP7MZptMf4KS/MKSOOfs+IWLd5DE5FrG/h8P3N56mFY=";
    installPath = "https/repo1.maven.org/maven2/org/scalatest/scalatest-diagrams_3/3.2.19";
  };

  "org.scalatest_scalatest-featurespec_2.13-3.2.19" = fetchMaven {
    name = "org.scalatest_scalatest-featurespec_2.13-3.2.19";
    urls = [
      "https://repo1.maven.org/maven2/org/scalatest/scalatest-featurespec_2.13/3.2.19/scalatest-featurespec_2.13-3.2.19.jar"
      "https://repo1.maven.org/maven2/org/scalatest/scalatest-featurespec_2.13/3.2.19/scalatest-featurespec_2.13-3.2.19.pom"
    ];
    hash = "sha256-cFTf4dhKLKJ3ZgoTyfFVq5th1ZQr5ZyGrtVEMaqpSvU=";
    installPath = "https/repo1.maven.org/maven2/org/scalatest/scalatest-featurespec_2.13/3.2.19";
  };

  "org.scalatest_scalatest-featurespec_3-3.2.19" = fetchMaven {
    name = "org.scalatest_scalatest-featurespec_3-3.2.19";
    urls = [
      "https://repo1.maven.org/maven2/org/scalatest/scalatest-featurespec_3/3.2.19/scalatest-featurespec_3-3.2.19.jar"
      "https://repo1.maven.org/maven2/org/scalatest/scalatest-featurespec_3/3.2.19/scalatest-featurespec_3-3.2.19.pom"
    ];
    hash = "sha256-n9z5Uf0dnUgr5vnY2MqO1thAF5s5MWw9WY5ER2dnUig=";
    installPath = "https/repo1.maven.org/maven2/org/scalatest/scalatest-featurespec_3/3.2.19";
  };

  "org.scalatest_scalatest-flatspec_2.13-3.2.19" = fetchMaven {
    name = "org.scalatest_scalatest-flatspec_2.13-3.2.19";
    urls = [
      "https://repo1.maven.org/maven2/org/scalatest/scalatest-flatspec_2.13/3.2.19/scalatest-flatspec_2.13-3.2.19.jar"
      "https://repo1.maven.org/maven2/org/scalatest/scalatest-flatspec_2.13/3.2.19/scalatest-flatspec_2.13-3.2.19.pom"
    ];
    hash = "sha256-5AjN1bMUpI6fEdx9C1I88i3YM0OtNpP507wUeL0W7TQ=";
    installPath = "https/repo1.maven.org/maven2/org/scalatest/scalatest-flatspec_2.13/3.2.19";
  };

  "org.scalatest_scalatest-flatspec_3-3.2.19" = fetchMaven {
    name = "org.scalatest_scalatest-flatspec_3-3.2.19";
    urls = [
      "https://repo1.maven.org/maven2/org/scalatest/scalatest-flatspec_3/3.2.19/scalatest-flatspec_3-3.2.19.jar"
      "https://repo1.maven.org/maven2/org/scalatest/scalatest-flatspec_3/3.2.19/scalatest-flatspec_3-3.2.19.pom"
    ];
    hash = "sha256-3ctmJs7UIAYVCe5TpeECYW77tGmdssgRUk7l6Minr5w=";
    installPath = "https/repo1.maven.org/maven2/org/scalatest/scalatest-flatspec_3/3.2.19";
  };

  "org.scalatest_scalatest-freespec_2.13-3.2.19" = fetchMaven {
    name = "org.scalatest_scalatest-freespec_2.13-3.2.19";
    urls = [
      "https://repo1.maven.org/maven2/org/scalatest/scalatest-freespec_2.13/3.2.19/scalatest-freespec_2.13-3.2.19.jar"
      "https://repo1.maven.org/maven2/org/scalatest/scalatest-freespec_2.13/3.2.19/scalatest-freespec_2.13-3.2.19.pom"
    ];
    hash = "sha256-7j1qHb8rHakvE1ETE9iuYu4P1zWuXPr5blUfTt0dzaE=";
    installPath = "https/repo1.maven.org/maven2/org/scalatest/scalatest-freespec_2.13/3.2.19";
  };

  "org.scalatest_scalatest-freespec_3-3.2.19" = fetchMaven {
    name = "org.scalatest_scalatest-freespec_3-3.2.19";
    urls = [
      "https://repo1.maven.org/maven2/org/scalatest/scalatest-freespec_3/3.2.19/scalatest-freespec_3-3.2.19.jar"
      "https://repo1.maven.org/maven2/org/scalatest/scalatest-freespec_3/3.2.19/scalatest-freespec_3-3.2.19.pom"
    ];
    hash = "sha256-+OrXSBoOl764ZWyFcrZwbia9DnmLy3Kf2rl8uEvZtK4=";
    installPath = "https/repo1.maven.org/maven2/org/scalatest/scalatest-freespec_3/3.2.19";
  };

  "org.scalatest_scalatest-funspec_2.13-3.2.19" = fetchMaven {
    name = "org.scalatest_scalatest-funspec_2.13-3.2.19";
    urls = [
      "https://repo1.maven.org/maven2/org/scalatest/scalatest-funspec_2.13/3.2.19/scalatest-funspec_2.13-3.2.19.jar"
      "https://repo1.maven.org/maven2/org/scalatest/scalatest-funspec_2.13/3.2.19/scalatest-funspec_2.13-3.2.19.pom"
    ];
    hash = "sha256-lWSulAZ067lOVTDuBXAo9x9f5MyWsw6jySLo0BOj17o=";
    installPath = "https/repo1.maven.org/maven2/org/scalatest/scalatest-funspec_2.13/3.2.19";
  };

  "org.scalatest_scalatest-funspec_3-3.2.19" = fetchMaven {
    name = "org.scalatest_scalatest-funspec_3-3.2.19";
    urls = [
      "https://repo1.maven.org/maven2/org/scalatest/scalatest-funspec_3/3.2.19/scalatest-funspec_3-3.2.19.jar"
      "https://repo1.maven.org/maven2/org/scalatest/scalatest-funspec_3/3.2.19/scalatest-funspec_3-3.2.19.pom"
    ];
    hash = "sha256-hSAtMZn+y4DXQQRiZ52axHnTAsAphdupbFgg4fKtlCc=";
    installPath = "https/repo1.maven.org/maven2/org/scalatest/scalatest-funspec_3/3.2.19";
  };

  "org.scalatest_scalatest-funsuite_2.13-3.2.19" = fetchMaven {
    name = "org.scalatest_scalatest-funsuite_2.13-3.2.19";
    urls = [
      "https://repo1.maven.org/maven2/org/scalatest/scalatest-funsuite_2.13/3.2.19/scalatest-funsuite_2.13-3.2.19.jar"
      "https://repo1.maven.org/maven2/org/scalatest/scalatest-funsuite_2.13/3.2.19/scalatest-funsuite_2.13-3.2.19.pom"
    ];
    hash = "sha256-oalqD91ZejCnNRNNucPovRCeweTqkTD5xQnM5ayl354=";
    installPath = "https/repo1.maven.org/maven2/org/scalatest/scalatest-funsuite_2.13/3.2.19";
  };

  "org.scalatest_scalatest-funsuite_3-3.2.19" = fetchMaven {
    name = "org.scalatest_scalatest-funsuite_3-3.2.19";
    urls = [
      "https://repo1.maven.org/maven2/org/scalatest/scalatest-funsuite_3/3.2.19/scalatest-funsuite_3-3.2.19.jar"
      "https://repo1.maven.org/maven2/org/scalatest/scalatest-funsuite_3/3.2.19/scalatest-funsuite_3-3.2.19.pom"
    ];
    hash = "sha256-yL3iRTPXdIQFtEuDZkZEu+dRD4+aDyfoS5qe0jFcCKg=";
    installPath = "https/repo1.maven.org/maven2/org/scalatest/scalatest-funsuite_3/3.2.19";
  };

  "org.scalatest_scalatest-matchers-core_2.13-3.2.19" = fetchMaven {
    name = "org.scalatest_scalatest-matchers-core_2.13-3.2.19";
    urls = [
      "https://repo1.maven.org/maven2/org/scalatest/scalatest-matchers-core_2.13/3.2.19/scalatest-matchers-core_2.13-3.2.19.jar"
      "https://repo1.maven.org/maven2/org/scalatest/scalatest-matchers-core_2.13/3.2.19/scalatest-matchers-core_2.13-3.2.19.pom"
    ];
    hash = "sha256-FLUXDbItfwWmKJvRuSA4ge8jl2b78ZRY068fe0M9oFM=";
    installPath = "https/repo1.maven.org/maven2/org/scalatest/scalatest-matchers-core_2.13/3.2.19";
  };

  "org.scalatest_scalatest-matchers-core_3-3.2.19" = fetchMaven {
    name = "org.scalatest_scalatest-matchers-core_3-3.2.19";
    urls = [
      "https://repo1.maven.org/maven2/org/scalatest/scalatest-matchers-core_3/3.2.19/scalatest-matchers-core_3-3.2.19.jar"
      "https://repo1.maven.org/maven2/org/scalatest/scalatest-matchers-core_3/3.2.19/scalatest-matchers-core_3-3.2.19.pom"
    ];
    hash = "sha256-bYuUz5fT4OHJlM5VJojJoCERCNBxYMQAFeYI08zIP3Q=";
    installPath = "https/repo1.maven.org/maven2/org/scalatest/scalatest-matchers-core_3/3.2.19";
  };

  "org.scalatest_scalatest-mustmatchers_2.13-3.2.19" = fetchMaven {
    name = "org.scalatest_scalatest-mustmatchers_2.13-3.2.19";
    urls = [
      "https://repo1.maven.org/maven2/org/scalatest/scalatest-mustmatchers_2.13/3.2.19/scalatest-mustmatchers_2.13-3.2.19.jar"
      "https://repo1.maven.org/maven2/org/scalatest/scalatest-mustmatchers_2.13/3.2.19/scalatest-mustmatchers_2.13-3.2.19.pom"
    ];
    hash = "sha256-b2BgcFJtCWlI07llJDrY7oX8XrWkORc3zflvugUhdxk=";
    installPath = "https/repo1.maven.org/maven2/org/scalatest/scalatest-mustmatchers_2.13/3.2.19";
  };

  "org.scalatest_scalatest-mustmatchers_3-3.2.19" = fetchMaven {
    name = "org.scalatest_scalatest-mustmatchers_3-3.2.19";
    urls = [
      "https://repo1.maven.org/maven2/org/scalatest/scalatest-mustmatchers_3/3.2.19/scalatest-mustmatchers_3-3.2.19.jar"
      "https://repo1.maven.org/maven2/org/scalatest/scalatest-mustmatchers_3/3.2.19/scalatest-mustmatchers_3-3.2.19.pom"
    ];
    hash = "sha256-OTt9o2fMMC0DBTk3V73CmCaBDKKNVOGYl/UZbcCQgx8=";
    installPath = "https/repo1.maven.org/maven2/org/scalatest/scalatest-mustmatchers_3/3.2.19";
  };

  "org.scalatest_scalatest-propspec_2.13-3.2.19" = fetchMaven {
    name = "org.scalatest_scalatest-propspec_2.13-3.2.19";
    urls = [
      "https://repo1.maven.org/maven2/org/scalatest/scalatest-propspec_2.13/3.2.19/scalatest-propspec_2.13-3.2.19.jar"
      "https://repo1.maven.org/maven2/org/scalatest/scalatest-propspec_2.13/3.2.19/scalatest-propspec_2.13-3.2.19.pom"
    ];
    hash = "sha256-TWd3bVVJ/KeK1ZHR5CJRtBup7wjGkWQhnXxKlZZSSOI=";
    installPath = "https/repo1.maven.org/maven2/org/scalatest/scalatest-propspec_2.13/3.2.19";
  };

  "org.scalatest_scalatest-propspec_3-3.2.19" = fetchMaven {
    name = "org.scalatest_scalatest-propspec_3-3.2.19";
    urls = [
      "https://repo1.maven.org/maven2/org/scalatest/scalatest-propspec_3/3.2.19/scalatest-propspec_3-3.2.19.jar"
      "https://repo1.maven.org/maven2/org/scalatest/scalatest-propspec_3/3.2.19/scalatest-propspec_3-3.2.19.pom"
    ];
    hash = "sha256-njtKYeDP7bey+YUm0DzQeQD0H6QxPNVbhNG676B4Klc=";
    installPath = "https/repo1.maven.org/maven2/org/scalatest/scalatest-propspec_3/3.2.19";
  };

  "org.scalatest_scalatest-refspec_2.13-3.2.19" = fetchMaven {
    name = "org.scalatest_scalatest-refspec_2.13-3.2.19";
    urls = [
      "https://repo1.maven.org/maven2/org/scalatest/scalatest-refspec_2.13/3.2.19/scalatest-refspec_2.13-3.2.19.jar"
      "https://repo1.maven.org/maven2/org/scalatest/scalatest-refspec_2.13/3.2.19/scalatest-refspec_2.13-3.2.19.pom"
    ];
    hash = "sha256-T0zYHq2z7fQR9XES70Oj1jxGnbrpegI+5fAUunkfTqM=";
    installPath = "https/repo1.maven.org/maven2/org/scalatest/scalatest-refspec_2.13/3.2.19";
  };

  "org.scalatest_scalatest-refspec_3-3.2.19" = fetchMaven {
    name = "org.scalatest_scalatest-refspec_3-3.2.19";
    urls = [
      "https://repo1.maven.org/maven2/org/scalatest/scalatest-refspec_3/3.2.19/scalatest-refspec_3-3.2.19.jar"
      "https://repo1.maven.org/maven2/org/scalatest/scalatest-refspec_3/3.2.19/scalatest-refspec_3-3.2.19.pom"
    ];
    hash = "sha256-fdoTTaa71TzwEZ1T20y3Vc55riNOcsOjyA4DIEe3RIA=";
    installPath = "https/repo1.maven.org/maven2/org/scalatest/scalatest-refspec_3/3.2.19";
  };

  "org.scalatest_scalatest-shouldmatchers_2.13-3.2.19" = fetchMaven {
    name = "org.scalatest_scalatest-shouldmatchers_2.13-3.2.19";
    urls = [
      "https://repo1.maven.org/maven2/org/scalatest/scalatest-shouldmatchers_2.13/3.2.19/scalatest-shouldmatchers_2.13-3.2.19.jar"
      "https://repo1.maven.org/maven2/org/scalatest/scalatest-shouldmatchers_2.13/3.2.19/scalatest-shouldmatchers_2.13-3.2.19.pom"
    ];
    hash = "sha256-kLbWJx6QCEm6PyXJ3RLzHTSckQGTdybv1ShaLHWDyZc=";
    installPath = "https/repo1.maven.org/maven2/org/scalatest/scalatest-shouldmatchers_2.13/3.2.19";
  };

  "org.scalatest_scalatest-shouldmatchers_3-3.2.19" = fetchMaven {
    name = "org.scalatest_scalatest-shouldmatchers_3-3.2.19";
    urls = [
      "https://repo1.maven.org/maven2/org/scalatest/scalatest-shouldmatchers_3/3.2.19/scalatest-shouldmatchers_3-3.2.19.jar"
      "https://repo1.maven.org/maven2/org/scalatest/scalatest-shouldmatchers_3/3.2.19/scalatest-shouldmatchers_3-3.2.19.pom"
    ];
    hash = "sha256-+QcipBjJRhpMJ7PtT0TvFOlRI/Qkes5gYrt7JXNYyRQ=";
    installPath = "https/repo1.maven.org/maven2/org/scalatest/scalatest-shouldmatchers_3/3.2.19";
  };

  "org.scalatest_scalatest-wordspec_2.13-3.2.19" = fetchMaven {
    name = "org.scalatest_scalatest-wordspec_2.13-3.2.19";
    urls = [
      "https://repo1.maven.org/maven2/org/scalatest/scalatest-wordspec_2.13/3.2.19/scalatest-wordspec_2.13-3.2.19.jar"
      "https://repo1.maven.org/maven2/org/scalatest/scalatest-wordspec_2.13/3.2.19/scalatest-wordspec_2.13-3.2.19.pom"
    ];
    hash = "sha256-Wpji+6EMpjq+1+EXZPtgzEKVhwJeQMQGxF9HOvzAr9A=";
    installPath = "https/repo1.maven.org/maven2/org/scalatest/scalatest-wordspec_2.13/3.2.19";
  };

  "org.scalatest_scalatest-wordspec_3-3.2.19" = fetchMaven {
    name = "org.scalatest_scalatest-wordspec_3-3.2.19";
    urls = [
      "https://repo1.maven.org/maven2/org/scalatest/scalatest-wordspec_3/3.2.19/scalatest-wordspec_3-3.2.19.jar"
      "https://repo1.maven.org/maven2/org/scalatest/scalatest-wordspec_3/3.2.19/scalatest-wordspec_3-3.2.19.pom"
    ];
    hash = "sha256-wR707dnpvBMMHsnecyAVChN3PeJzUnH4VLeLZqgUn/A=";
    installPath = "https/repo1.maven.org/maven2/org/scalatest/scalatest-wordspec_3/3.2.19";
  };

  "org.scalatest_scalatest_2.13-3.2.19" = fetchMaven {
    name = "org.scalatest_scalatest_2.13-3.2.19";
    urls = [
      "https://repo1.maven.org/maven2/org/scalatest/scalatest_2.13/3.2.19/scalatest_2.13-3.2.19.jar"
      "https://repo1.maven.org/maven2/org/scalatest/scalatest_2.13/3.2.19/scalatest_2.13-3.2.19.pom"
    ];
    hash = "sha256-5KO8Mdk4Jo2ZkH87x21+ykvtSsxl602WSWXtfAoN/hM=";
    installPath = "https/repo1.maven.org/maven2/org/scalatest/scalatest_2.13/3.2.19";
  };

  "org.scalatest_scalatest_3-3.2.19" = fetchMaven {
    name = "org.scalatest_scalatest_3-3.2.19";
    urls = [
      "https://repo1.maven.org/maven2/org/scalatest/scalatest_3/3.2.19/scalatest_3-3.2.19.jar"
      "https://repo1.maven.org/maven2/org/scalatest/scalatest_3/3.2.19/scalatest_3-3.2.19.pom"
    ];
    hash = "sha256-0pdgKuDpBMcv61IS75Jd7Kh2Hf4eu1Y1uhLB9dUED3c=";
    installPath = "https/repo1.maven.org/maven2/org/scalatest/scalatest_3/3.2.19";
  };

  "org.scalatestplus_scalacheck-1-18_2.13-3.2.19.0" = fetchMaven {
    name = "org.scalatestplus_scalacheck-1-18_2.13-3.2.19.0";
    urls = [
      "https://repo1.maven.org/maven2/org/scalatestplus/scalacheck-1-18_2.13/3.2.19.0/scalacheck-1-18_2.13-3.2.19.0.jar"
      "https://repo1.maven.org/maven2/org/scalatestplus/scalacheck-1-18_2.13/3.2.19.0/scalacheck-1-18_2.13-3.2.19.0.pom"
    ];
    hash = "sha256-PSYMGrma7wLPs4MzMlLl7KbpFshRB+06ngwNHCbaqDk=";
    installPath = "https/repo1.maven.org/maven2/org/scalatestplus/scalacheck-1-18_2.13/3.2.19.0";
  };

  "org.scalatestplus_scalacheck-1-18_3-3.2.19.0" = fetchMaven {
    name = "org.scalatestplus_scalacheck-1-18_3-3.2.19.0";
    urls = [
      "https://repo1.maven.org/maven2/org/scalatestplus/scalacheck-1-18_3/3.2.19.0/scalacheck-1-18_3-3.2.19.0.jar"
      "https://repo1.maven.org/maven2/org/scalatestplus/scalacheck-1-18_3/3.2.19.0/scalacheck-1-18_3-3.2.19.0.pom"
    ];
    hash = "sha256-sdEWYByZhBNnpanGWMvd3SqVbgWJAF5TosPpof1dXIM=";
    installPath = "https/repo1.maven.org/maven2/org/scalatestplus/scalacheck-1-18_3/3.2.19.0";
  };

  "org.scodec_scodec-bits_3-1.1.38" = fetchMaven {
    name = "org.scodec_scodec-bits_3-1.1.38";
    urls = [
      "https://repo1.maven.org/maven2/org/scodec/scodec-bits_3/1.1.38/scodec-bits_3-1.1.38.jar"
      "https://repo1.maven.org/maven2/org/scodec/scodec-bits_3/1.1.38/scodec-bits_3-1.1.38.pom"
    ];
    hash = "sha256-zXoZ1DHaUteZHb/+oalCeGIGJttoHxt29g4oxdgudp8=";
    installPath = "https/repo1.maven.org/maven2/org/scodec/scodec-bits_3/1.1.38";
  };

  "org.slf4j_jcl-over-slf4j-1.7.30" = fetchMaven {
    name = "org.slf4j_jcl-over-slf4j-1.7.30";
    urls = [
      "https://repo1.maven.org/maven2/org/slf4j/jcl-over-slf4j/1.7.30/jcl-over-slf4j-1.7.30.jar"
      "https://repo1.maven.org/maven2/org/slf4j/jcl-over-slf4j/1.7.30/jcl-over-slf4j-1.7.30.pom"
    ];
    hash = "sha256-kCzoxU+HfO0P4FhST+3SNgi23+nCAQOAvw5/XHssymY=";
    installPath = "https/repo1.maven.org/maven2/org/slf4j/jcl-over-slf4j/1.7.30";
  };

  "org.slf4j_jcl-over-slf4j-1.7.36" = fetchMaven {
    name = "org.slf4j_jcl-over-slf4j-1.7.36";
    urls = [
      "https://repo1.maven.org/maven2/org/slf4j/jcl-over-slf4j/1.7.36/jcl-over-slf4j-1.7.36.pom"
    ];
    hash = "sha256-pmP6GNNcADc1Mga4g3R7rjI8zHXZrsEiZIYROjh/p0U=";
    installPath = "https/repo1.maven.org/maven2/org/slf4j/jcl-over-slf4j/1.7.36";
  };

  "org.slf4j_jcl-over-slf4j-2.0.11" = fetchMaven {
    name = "org.slf4j_jcl-over-slf4j-2.0.11";
    urls = [
      "https://repo1.maven.org/maven2/org/slf4j/jcl-over-slf4j/2.0.11/jcl-over-slf4j-2.0.11.jar"
      "https://repo1.maven.org/maven2/org/slf4j/jcl-over-slf4j/2.0.11/jcl-over-slf4j-2.0.11.pom"
    ];
    hash = "sha256-MlmHazcCgdh3vEFUF38lqcmVpKfpybgUX4b7kYs9xzA=";
    installPath = "https/repo1.maven.org/maven2/org/slf4j/jcl-over-slf4j/2.0.11";
  };

  "org.slf4j_jul-to-slf4j-1.7.30" = fetchMaven {
    name = "org.slf4j_jul-to-slf4j-1.7.30";
    urls = [
      "https://repo1.maven.org/maven2/org/slf4j/jul-to-slf4j/1.7.30/jul-to-slf4j-1.7.30.jar"
      "https://repo1.maven.org/maven2/org/slf4j/jul-to-slf4j/1.7.30/jul-to-slf4j-1.7.30.pom"
    ];
    hash = "sha256-j+ngBYFB+jb0nMfdiyjuVtUM/lpGs5cAm2x62Z1Y+6Q=";
    installPath = "https/repo1.maven.org/maven2/org/slf4j/jul-to-slf4j/1.7.30";
  };

  "org.slf4j_slf4j-api-1.7.36" = fetchMaven {
    name = "org.slf4j_slf4j-api-1.7.36";
    urls = [
      "https://repo1.maven.org/maven2/org/slf4j/slf4j-api/1.7.36/slf4j-api-1.7.36.jar"
      "https://repo1.maven.org/maven2/org/slf4j/slf4j-api/1.7.36/slf4j-api-1.7.36.pom"
    ];
    hash = "sha256-Y5+xtmk/NH4v8ol1MqMr+2spKmRMVkcTL6QS1ko2EGM=";
    installPath = "https/repo1.maven.org/maven2/org/slf4j/slf4j-api/1.7.36";
  };

  "org.slf4j_slf4j-api-2.0.17" = fetchMaven {
    name = "org.slf4j_slf4j-api-2.0.17";
    urls = [
      "https://repo1.maven.org/maven2/org/slf4j/slf4j-api/2.0.17/slf4j-api-2.0.17.jar"
      "https://repo1.maven.org/maven2/org/slf4j/slf4j-api/2.0.17/slf4j-api-2.0.17.pom"
    ];
    hash = "sha256-H8Tq0N+icmvASnUUTYYRCm5dhYy03Jqvbz/pWYut/h0=";
    installPath = "https/repo1.maven.org/maven2/org/slf4j/slf4j-api/2.0.17";
  };

  "org.slf4j_slf4j-bom-2.0.11" = fetchMaven {
    name = "org.slf4j_slf4j-bom-2.0.11";
    urls = [ "https://repo1.maven.org/maven2/org/slf4j/slf4j-bom/2.0.11/slf4j-bom-2.0.11.pom" ];
    hash = "sha256-aB3WGMQ/ZoxyOi0He7zV90bZHj02FZ1lf0pw0KjU0D4=";
    installPath = "https/repo1.maven.org/maven2/org/slf4j/slf4j-bom/2.0.11";
  };

  "org.slf4j_slf4j-bom-2.0.17" = fetchMaven {
    name = "org.slf4j_slf4j-bom-2.0.17";
    urls = [ "https://repo1.maven.org/maven2/org/slf4j/slf4j-bom/2.0.17/slf4j-bom-2.0.17.pom" ];
    hash = "sha256-qzVo4Yw93XWPRmfJurfoPZ/b9JSCgRngTQmCG6cRwMA=";
    installPath = "https/repo1.maven.org/maven2/org/slf4j/slf4j-bom/2.0.17";
  };

  "org.slf4j_slf4j-parent-1.7.30" = fetchMaven {
    name = "org.slf4j_slf4j-parent-1.7.30";
    urls = [ "https://repo1.maven.org/maven2/org/slf4j/slf4j-parent/1.7.30/slf4j-parent-1.7.30.pom" ];
    hash = "sha256-poyNibR9n/DHgo+I/r5Qb4ZXkeeiEDT9ZvLLwX1PgeI=";
    installPath = "https/repo1.maven.org/maven2/org/slf4j/slf4j-parent/1.7.30";
  };

  "org.slf4j_slf4j-parent-1.7.36" = fetchMaven {
    name = "org.slf4j_slf4j-parent-1.7.36";
    urls = [ "https://repo1.maven.org/maven2/org/slf4j/slf4j-parent/1.7.36/slf4j-parent-1.7.36.pom" ];
    hash = "sha256-XOPBamOj/h7sQV4eY3tVJqwkhSPdS1EAqfeZruNTLGM=";
    installPath = "https/repo1.maven.org/maven2/org/slf4j/slf4j-parent/1.7.36";
  };

  "org.slf4j_slf4j-parent-2.0.11" = fetchMaven {
    name = "org.slf4j_slf4j-parent-2.0.11";
    urls = [ "https://repo1.maven.org/maven2/org/slf4j/slf4j-parent/2.0.11/slf4j-parent-2.0.11.pom" ];
    hash = "sha256-XKskKNRdFu6bgUQyuoRsrpKs6dJYkmSkRGjXySUwZJs=";
    installPath = "https/repo1.maven.org/maven2/org/slf4j/slf4j-parent/2.0.11";
  };

  "org.slf4j_slf4j-parent-2.0.17" = fetchMaven {
    name = "org.slf4j_slf4j-parent-2.0.17";
    urls = [ "https://repo1.maven.org/maven2/org/slf4j/slf4j-parent/2.0.17/slf4j-parent-2.0.17.pom" ];
    hash = "sha256-H/5UPMMiEV8gCId3abw3znMuG9wWYSMevo6t1zUGACw=";
    installPath = "https/repo1.maven.org/maven2/org/slf4j/slf4j-parent/2.0.17";
  };

  "org.snakeyaml_snakeyaml-engine-3.0.1" = fetchMaven {
    name = "org.snakeyaml_snakeyaml-engine-3.0.1";
    urls = [
      "https://repo1.maven.org/maven2/org/snakeyaml/snakeyaml-engine/3.0.1/snakeyaml-engine-3.0.1.jar"
      "https://repo1.maven.org/maven2/org/snakeyaml/snakeyaml-engine/3.0.1/snakeyaml-engine-3.0.1.pom"
    ];
    hash = "sha256-7iAdeB8CZ2r3BEAfH+j7Qfk6Dk9X/ThHDOaJrAS9gXY=";
    installPath = "https/repo1.maven.org/maven2/org/snakeyaml/snakeyaml-engine/3.0.1";
  };

  "org.springframework_spring-framework-bom-5.3.39" = fetchMaven {
    name = "org.springframework_spring-framework-bom-5.3.39";
    urls = [
      "https://repo1.maven.org/maven2/org/springframework/spring-framework-bom/5.3.39/spring-framework-bom-5.3.39.pom"
    ];
    hash = "sha256-V+sR9AvokPz2NrvEFCxdLHl3jrW2o9dP3gisCDAUUDA=";
    installPath = "https/repo1.maven.org/maven2/org/springframework/spring-framework-bom/5.3.39";
  };

  "org.testcontainers_testcontainers-bom-1.21.3" = fetchMaven {
    name = "org.testcontainers_testcontainers-bom-1.21.3";
    urls = [
      "https://repo1.maven.org/maven2/org/testcontainers/testcontainers-bom/1.21.3/testcontainers-bom-1.21.3.pom"
    ];
    hash = "sha256-Bxij8f7vFPr7ipZu8m5yr5VfI/KrHnENaUfQtlC2xy8=";
    installPath = "https/repo1.maven.org/maven2/org/testcontainers/testcontainers-bom/1.21.3";
  };

  "org.tukaani_xz-1.10" = fetchMaven {
    name = "org.tukaani_xz-1.10";
    urls = [
      "https://repo1.maven.org/maven2/org/tukaani/xz/1.10/xz-1.10.jar"
      "https://repo1.maven.org/maven2/org/tukaani/xz/1.10/xz-1.10.pom"
    ];
    hash = "sha256-VKJG7cDEWkgts0KEMgjW1RCn1YXwfFemS+tpniUTZwY=";
    installPath = "https/repo1.maven.org/maven2/org/tukaani/xz/1.10";
  };

  "org.typelevel_case-insensitive_3-1.4.0" = fetchMaven {
    name = "org.typelevel_case-insensitive_3-1.4.0";
    urls = [
      "https://repo1.maven.org/maven2/org/typelevel/case-insensitive_3/1.4.0/case-insensitive_3-1.4.0.jar"
      "https://repo1.maven.org/maven2/org/typelevel/case-insensitive_3/1.4.0/case-insensitive_3-1.4.0.pom"
    ];
    hash = "sha256-qf4RctNOpGPDZFjnXxvSb8cKObtQoCoV5V4rdFfZGPs=";
    installPath = "https/repo1.maven.org/maven2/org/typelevel/case-insensitive_3/1.4.0";
  };

  "org.typelevel_cats-core_3-2.10.0" = fetchMaven {
    name = "org.typelevel_cats-core_3-2.10.0";
    urls = [
      "https://repo1.maven.org/maven2/org/typelevel/cats-core_3/2.10.0/cats-core_3-2.10.0.jar"
      "https://repo1.maven.org/maven2/org/typelevel/cats-core_3/2.10.0/cats-core_3-2.10.0.pom"
    ];
    hash = "sha256-YSKn/raANcDd/ELTk6AZj+UntdSDyUuqT9gBmlEE/RA=";
    installPath = "https/repo1.maven.org/maven2/org/typelevel/cats-core_3/2.10.0";
  };

  "org.typelevel_cats-effect-kernel_3-3.5.2" = fetchMaven {
    name = "org.typelevel_cats-effect-kernel_3-3.5.2";
    urls = [
      "https://repo1.maven.org/maven2/org/typelevel/cats-effect-kernel_3/3.5.2/cats-effect-kernel_3-3.5.2.jar"
      "https://repo1.maven.org/maven2/org/typelevel/cats-effect-kernel_3/3.5.2/cats-effect-kernel_3-3.5.2.pom"
    ];
    hash = "sha256-XU2fPHiwC2KAaFMSqy3KjUGeK3zgsQITaEom5mnl/Tw=";
    installPath = "https/repo1.maven.org/maven2/org/typelevel/cats-effect-kernel_3/3.5.2";
  };

  "org.typelevel_cats-effect-std_3-3.5.2" = fetchMaven {
    name = "org.typelevel_cats-effect-std_3-3.5.2";
    urls = [
      "https://repo1.maven.org/maven2/org/typelevel/cats-effect-std_3/3.5.2/cats-effect-std_3-3.5.2.jar"
      "https://repo1.maven.org/maven2/org/typelevel/cats-effect-std_3/3.5.2/cats-effect-std_3-3.5.2.pom"
    ];
    hash = "sha256-t9TTs+tGshsiUmFZAF35aTg9AglECUjdVw9AhufL8bA=";
    installPath = "https/repo1.maven.org/maven2/org/typelevel/cats-effect-std_3/3.5.2";
  };

  "org.typelevel_cats-effect_3-3.5.2" = fetchMaven {
    name = "org.typelevel_cats-effect_3-3.5.2";
    urls = [
      "https://repo1.maven.org/maven2/org/typelevel/cats-effect_3/3.5.2/cats-effect_3-3.5.2.jar"
      "https://repo1.maven.org/maven2/org/typelevel/cats-effect_3/3.5.2/cats-effect_3-3.5.2.pom"
    ];
    hash = "sha256-WuDkqUQ+Vz40IFrNO3XeczvEBunTST9guxWXqAGISjI=";
    installPath = "https/repo1.maven.org/maven2/org/typelevel/cats-effect_3/3.5.2";
  };

  "org.typelevel_cats-kernel_3-2.10.0" = fetchMaven {
    name = "org.typelevel_cats-kernel_3-2.10.0";
    urls = [
      "https://repo1.maven.org/maven2/org/typelevel/cats-kernel_3/2.10.0/cats-kernel_3-2.10.0.jar"
      "https://repo1.maven.org/maven2/org/typelevel/cats-kernel_3/2.10.0/cats-kernel_3-2.10.0.pom"
    ];
    hash = "sha256-buLl7EmvSxxpptqe3Qmr6nSjEzkkM9SUyQkwbqhQ/hE=";
    installPath = "https/repo1.maven.org/maven2/org/typelevel/cats-kernel_3/2.10.0";
  };

  "org.typelevel_cats-parse_3-1.0.0" = fetchMaven {
    name = "org.typelevel_cats-parse_3-1.0.0";
    urls = [
      "https://repo1.maven.org/maven2/org/typelevel/cats-parse_3/1.0.0/cats-parse_3-1.0.0.jar"
      "https://repo1.maven.org/maven2/org/typelevel/cats-parse_3/1.0.0/cats-parse_3-1.0.0.pom"
    ];
    hash = "sha256-8FdTecQu4Qb40bZwH9DwuIC4nhfzXJApfBCwSQjUxaE=";
    installPath = "https/repo1.maven.org/maven2/org/typelevel/cats-parse_3/1.0.0";
  };

  "org.typelevel_jawn-fs2_3-2.4.0" = fetchMaven {
    name = "org.typelevel_jawn-fs2_3-2.4.0";
    urls = [
      "https://repo1.maven.org/maven2/org/typelevel/jawn-fs2_3/2.4.0/jawn-fs2_3-2.4.0.jar"
      "https://repo1.maven.org/maven2/org/typelevel/jawn-fs2_3/2.4.0/jawn-fs2_3-2.4.0.pom"
    ];
    hash = "sha256-0kb8V1Z9UpRja0oZXkROloUqFDQ66EPnYHia+TMdg3U=";
    installPath = "https/repo1.maven.org/maven2/org/typelevel/jawn-fs2_3/2.4.0";
  };

  "org.typelevel_jawn-parser_3-1.5.1" = fetchMaven {
    name = "org.typelevel_jawn-parser_3-1.5.1";
    urls = [
      "https://repo1.maven.org/maven2/org/typelevel/jawn-parser_3/1.5.1/jawn-parser_3-1.5.1.jar"
      "https://repo1.maven.org/maven2/org/typelevel/jawn-parser_3/1.5.1/jawn-parser_3-1.5.1.pom"
    ];
    hash = "sha256-Gg2FNQ42pedPZU+voZsxnUjqsjzQNRBr5kQmTNNCKg4=";
    installPath = "https/repo1.maven.org/maven2/org/typelevel/jawn-parser_3/1.5.1";
  };

  "org.typelevel_literally_3-1.1.0" = fetchMaven {
    name = "org.typelevel_literally_3-1.1.0";
    urls = [
      "https://repo1.maven.org/maven2/org/typelevel/literally_3/1.1.0/literally_3-1.1.0.jar"
      "https://repo1.maven.org/maven2/org/typelevel/literally_3/1.1.0/literally_3-1.1.0.pom"
    ];
    hash = "sha256-QOZD/Uif1A+s/T7OE3ULbOeILbRRjv9fSWqqG3A8Tkg=";
    installPath = "https/repo1.maven.org/maven2/org/typelevel/literally_3/1.1.0";
  };

  "org.typelevel_log4cats-core_3-2.6.0" = fetchMaven {
    name = "org.typelevel_log4cats-core_3-2.6.0";
    urls = [
      "https://repo1.maven.org/maven2/org/typelevel/log4cats-core_3/2.6.0/log4cats-core_3-2.6.0.jar"
      "https://repo1.maven.org/maven2/org/typelevel/log4cats-core_3/2.6.0/log4cats-core_3-2.6.0.pom"
    ];
    hash = "sha256-n64/FqAR6DghgzZSX2ZeLXw7Fhgj4InQ8+Wuc0GBt68=";
    installPath = "https/repo1.maven.org/maven2/org/typelevel/log4cats-core_3/2.6.0";
  };

  "org.typelevel_log4cats-slf4j_3-2.6.0" = fetchMaven {
    name = "org.typelevel_log4cats-slf4j_3-2.6.0";
    urls = [
      "https://repo1.maven.org/maven2/org/typelevel/log4cats-slf4j_3/2.6.0/log4cats-slf4j_3-2.6.0.jar"
      "https://repo1.maven.org/maven2/org/typelevel/log4cats-slf4j_3/2.6.0/log4cats-slf4j_3-2.6.0.pom"
    ];
    hash = "sha256-GRkJuD153kh+PQfZD2IXMMOlFbUCiqr+sazUKvwWf8o=";
    installPath = "https/repo1.maven.org/maven2/org/typelevel/log4cats-slf4j_3/2.6.0";
  };

  "org.typelevel_paiges-core_2.13-0.4.4" = fetchMaven {
    name = "org.typelevel_paiges-core_2.13-0.4.4";
    urls = [
      "https://repo1.maven.org/maven2/org/typelevel/paiges-core_2.13/0.4.4/paiges-core_2.13-0.4.4.jar"
      "https://repo1.maven.org/maven2/org/typelevel/paiges-core_2.13/0.4.4/paiges-core_2.13-0.4.4.pom"
    ];
    hash = "sha256-jDLknbLWlHezQZNFHFhHJEebufEOKEwK3ZyMIatxvoY=";
    installPath = "https/repo1.maven.org/maven2/org/typelevel/paiges-core_2.13/0.4.4";
  };

  "org.typelevel_vault_3-3.5.0" = fetchMaven {
    name = "org.typelevel_vault_3-3.5.0";
    urls = [
      "https://repo1.maven.org/maven2/org/typelevel/vault_3/3.5.0/vault_3-3.5.0.jar"
      "https://repo1.maven.org/maven2/org/typelevel/vault_3/3.5.0/vault_3-3.5.0.pom"
    ];
    hash = "sha256-kymF7ibZKKSAykGq810b/bx2vmEW0jTCoykUCwwkS4s=";
    installPath = "https/repo1.maven.org/maven2/org/typelevel/vault_3/3.5.0";
  };

  "org.virtuslab_using_directives-1.1.4" = fetchMaven {
    name = "org.virtuslab_using_directives-1.1.4";
    urls = [
      "https://repo1.maven.org/maven2/org/virtuslab/using_directives/1.1.4/using_directives-1.1.4.jar"
      "https://repo1.maven.org/maven2/org/virtuslab/using_directives/1.1.4/using_directives-1.1.4.pom"
    ];
    hash = "sha256-pnvGXmfkY+Ab7VI/5wL15RkxdE6LZ9hjfBL/UMVejUI=";
    installPath = "https/repo1.maven.org/maven2/org/virtuslab/using_directives/1.1.4";
  };

  "org.yaml_snakeyaml-2.0" = fetchMaven {
    name = "org.yaml_snakeyaml-2.0";
    urls = [
      "https://repo1.maven.org/maven2/org/yaml/snakeyaml/2.0/snakeyaml-2.0.jar"
      "https://repo1.maven.org/maven2/org/yaml/snakeyaml/2.0/snakeyaml-2.0.pom"
    ];
    hash = "sha256-4/5l8lMWWNxqv1JGr0n8QtEo0KGAUGULj7lmdy9TODI=";
    installPath = "https/repo1.maven.org/maven2/org/yaml/snakeyaml/2.0";
  };

  "ch.epfl.scala_bsp4j-2.2.0-M2" = fetchMaven {
    name = "ch.epfl.scala_bsp4j-2.2.0-M2";
    urls = [
      "https://repo1.maven.org/maven2/ch/epfl/scala/bsp4j/2.2.0-M2/bsp4j-2.2.0-M2.jar"
      "https://repo1.maven.org/maven2/ch/epfl/scala/bsp4j/2.2.0-M2/bsp4j-2.2.0-M2.pom"
    ];
    hash = "sha256-p9YcDs64uhLxgsiPpx7xhTwhifvU5YdsBSs5dq5NWzU=";
    installPath = "https/repo1.maven.org/maven2/ch/epfl/scala/bsp4j/2.2.0-M2";
  };

  "ch.qos.logback_logback-classic-1.5.18" = fetchMaven {
    name = "ch.qos.logback_logback-classic-1.5.18";
    urls = [
      "https://repo1.maven.org/maven2/ch/qos/logback/logback-classic/1.5.18/logback-classic-1.5.18.jar"
      "https://repo1.maven.org/maven2/ch/qos/logback/logback-classic/1.5.18/logback-classic-1.5.18.pom"
    ];
    hash = "sha256-VS8stqAkz85ytPwTH7Zdn65MHGZtUEnTotbKwI+j8aw=";
    installPath = "https/repo1.maven.org/maven2/ch/qos/logback/logback-classic/1.5.18";
  };

  "ch.qos.logback_logback-core-1.5.18" = fetchMaven {
    name = "ch.qos.logback_logback-core-1.5.18";
    urls = [
      "https://repo1.maven.org/maven2/ch/qos/logback/logback-core/1.5.18/logback-core-1.5.18.jar"
      "https://repo1.maven.org/maven2/ch/qos/logback/logback-core/1.5.18/logback-core-1.5.18.pom"
    ];
    hash = "sha256-oOq8chWL+W07XHYqhWxlget1Au0A6hgoA3PQsIKdkAU=";
    installPath = "https/repo1.maven.org/maven2/ch/qos/logback/logback-core/1.5.18";
  };

  "ch.qos.logback_logback-parent-1.5.18" = fetchMaven {
    name = "ch.qos.logback_logback-parent-1.5.18";
    urls = [
      "https://repo1.maven.org/maven2/ch/qos/logback/logback-parent/1.5.18/logback-parent-1.5.18.pom"
    ];
    hash = "sha256-IMxGdBnrc/GxIl2KyftcjuveTaCfcTYNEL/pSN4vaqg=";
    installPath = "https/repo1.maven.org/maven2/ch/qos/logback/logback-parent/1.5.18";
  };

  "com.eed3si9n.jarjar_jarjar-1.16.0" = fetchMaven {
    name = "com.eed3si9n.jarjar_jarjar-1.16.0";
    urls = [
      "https://repo1.maven.org/maven2/com/eed3si9n/jarjar/jarjar/1.16.0/jarjar-1.16.0.jar"
      "https://repo1.maven.org/maven2/com/eed3si9n/jarjar/jarjar/1.16.0/jarjar-1.16.0.pom"
    ];
    hash = "sha256-7yeu2GEZWT35zIdhx12PASb7z1iRTbfLqInMmcWgOnY=";
    installPath = "https/repo1.maven.org/maven2/com/eed3si9n/jarjar/jarjar/1.16.0";
  };

  "com.eed3si9n.jarjarabrams_jarjar-abrams-core_3-1.16.0" = fetchMaven {
    name = "com.eed3si9n.jarjarabrams_jarjar-abrams-core_3-1.16.0";
    urls = [
      "https://repo1.maven.org/maven2/com/eed3si9n/jarjarabrams/jarjar-abrams-core_3/1.16.0/jarjar-abrams-core_3-1.16.0.jar"
      "https://repo1.maven.org/maven2/com/eed3si9n/jarjarabrams/jarjar-abrams-core_3/1.16.0/jarjar-abrams-core_3-1.16.0.pom"
    ];
    hash = "sha256-W5DKe0MH8VvL8ijEhNThoGF+XDs2C2AL1vYh9VdWf2I=";
    installPath = "https/repo1.maven.org/maven2/com/eed3si9n/jarjarabrams/jarjar-abrams-core_3/1.16.0";
  };

  "com.fasterxml.jackson_jackson-base-2.12.1" = fetchMaven {
    name = "com.fasterxml.jackson_jackson-base-2.12.1";
    urls = [
      "https://repo1.maven.org/maven2/com/fasterxml/jackson/jackson-base/2.12.1/jackson-base-2.12.1.pom"
    ];
    hash = "sha256-QdwEWejSbiS//t8L9WxLqUxc0QQMY90a7ckBf6YzS2M=";
    installPath = "https/repo1.maven.org/maven2/com/fasterxml/jackson/jackson-base/2.12.1";
  };

  "com.fasterxml.jackson_jackson-base-2.15.1" = fetchMaven {
    name = "com.fasterxml.jackson_jackson-base-2.15.1";
    urls = [
      "https://repo1.maven.org/maven2/com/fasterxml/jackson/jackson-base/2.15.1/jackson-base-2.15.1.pom"
    ];
    hash = "sha256-DEG+wnRgBDaKE+g5oWHRRWcpgUH3rSj+eex3MKkiDYA=";
    installPath = "https/repo1.maven.org/maven2/com/fasterxml/jackson/jackson-base/2.15.1";
  };

  "com.fasterxml.jackson_jackson-bom-2.12.1" = fetchMaven {
    name = "com.fasterxml.jackson_jackson-bom-2.12.1";
    urls = [
      "https://repo1.maven.org/maven2/com/fasterxml/jackson/jackson-bom/2.12.1/jackson-bom-2.12.1.pom"
    ];
    hash = "sha256-IVTSEkQzRB352EzD1i+FXx8n+HSzPMD5TGq4Ez0VTzc=";
    installPath = "https/repo1.maven.org/maven2/com/fasterxml/jackson/jackson-bom/2.12.1";
  };

  "com.fasterxml.jackson_jackson-bom-2.15.1" = fetchMaven {
    name = "com.fasterxml.jackson_jackson-bom-2.15.1";
    urls = [
      "https://repo1.maven.org/maven2/com/fasterxml/jackson/jackson-bom/2.15.1/jackson-bom-2.15.1.pom"
    ];
    hash = "sha256-xTY1hTkw6E3dYAMDZnockm2fm43WPMcIRt0k2oxO2O8=";
    installPath = "https/repo1.maven.org/maven2/com/fasterxml/jackson/jackson-bom/2.15.1";
  };

  "com.fasterxml.jackson_jackson-bom-2.19.1" = fetchMaven {
    name = "com.fasterxml.jackson_jackson-bom-2.19.1";
    urls = [
      "https://repo1.maven.org/maven2/com/fasterxml/jackson/jackson-bom/2.19.1/jackson-bom-2.19.1.pom"
    ];
    hash = "sha256-kP82dKMabZd8AmRR6GziNerM2PpeLKxnpJN/XjbxSAk=";
    installPath = "https/repo1.maven.org/maven2/com/fasterxml/jackson/jackson-bom/2.19.1";
  };

  "com.fasterxml.jackson_jackson-bom-2.19.2" = fetchMaven {
    name = "com.fasterxml.jackson_jackson-bom-2.19.2";
    urls = [
      "https://repo1.maven.org/maven2/com/fasterxml/jackson/jackson-bom/2.19.2/jackson-bom-2.19.2.pom"
    ];
    hash = "sha256-XrLBhVEzqBqa3dXh8GHjdvDM/aMAKB0HgdkGLl1Zi3g=";
    installPath = "https/repo1.maven.org/maven2/com/fasterxml/jackson/jackson-bom/2.19.2";
  };

  "com.fasterxml.jackson_jackson-parent-2.12" = fetchMaven {
    name = "com.fasterxml.jackson_jackson-parent-2.12";
    urls = [
      "https://repo1.maven.org/maven2/com/fasterxml/jackson/jackson-parent/2.12/jackson-parent-2.12.pom"
    ];
    hash = "sha256-1XZX837v+3OgmuIWerAxNmHU3KA9W6GDs10dtM+w11o=";
    installPath = "https/repo1.maven.org/maven2/com/fasterxml/jackson/jackson-parent/2.12";
  };

  "com.fasterxml.jackson_jackson-parent-2.15" = fetchMaven {
    name = "com.fasterxml.jackson_jackson-parent-2.15";
    urls = [
      "https://repo1.maven.org/maven2/com/fasterxml/jackson/jackson-parent/2.15/jackson-parent-2.15.pom"
    ];
    hash = "sha256-Rybw8nineMf0Xjlc5GhV4ayVQMYocW1rCXiNhgdXiXc=";
    installPath = "https/repo1.maven.org/maven2/com/fasterxml/jackson/jackson-parent/2.15";
  };

  "com.fasterxml.jackson_jackson-parent-2.19.2" = fetchMaven {
    name = "com.fasterxml.jackson_jackson-parent-2.19.2";
    urls = [
      "https://repo1.maven.org/maven2/com/fasterxml/jackson/jackson-parent/2.19.2/jackson-parent-2.19.2.pom"
    ];
    hash = "sha256-v56LQyKnjsiVrubSyUM68hAFq28kAKkV/3eMBV/TduI=";
    installPath = "https/repo1.maven.org/maven2/com/fasterxml/jackson/jackson-parent/2.19.2";
  };

  "com.fasterxml.jackson_jackson-parent-2.19.3" = fetchMaven {
    name = "com.fasterxml.jackson_jackson-parent-2.19.3";
    urls = [
      "https://repo1.maven.org/maven2/com/fasterxml/jackson/jackson-parent/2.19.3/jackson-parent-2.19.3.pom"
    ];
    hash = "sha256-GB3zF0z0V1AtR3lbqQEBXSTp5AcLgqKAm6+//qyIO6E=";
    installPath = "https/repo1.maven.org/maven2/com/fasterxml/jackson/jackson-parent/2.19.3";
  };

  "com.fasterxml.woodstox_woodstox-core-6.5.1" = fetchMaven {
    name = "com.fasterxml.woodstox_woodstox-core-6.5.1";
    urls = [
      "https://repo1.maven.org/maven2/com/fasterxml/woodstox/woodstox-core/6.5.1/woodstox-core-6.5.1.jar"
      "https://repo1.maven.org/maven2/com/fasterxml/woodstox/woodstox-core/6.5.1/woodstox-core-6.5.1.pom"
    ];
    hash = "sha256-eCl3xBwccT4meQMH+TvrsREBEfqEtG9dT1g54Sf7MqE=";
    installPath = "https/repo1.maven.org/maven2/com/fasterxml/woodstox/woodstox-core/6.5.1";
  };

  "com.github.lolgab_mill-mima-worker-api_3-0.2.0" = fetchMaven {
    name = "com.github.lolgab_mill-mima-worker-api_3-0.2.0";
    urls = [
      "https://repo1.maven.org/maven2/com/github/lolgab/mill-mima-worker-api_3/0.2.0/mill-mima-worker-api_3-0.2.0.jar"
      "https://repo1.maven.org/maven2/com/github/lolgab/mill-mima-worker-api_3/0.2.0/mill-mima-worker-api_3-0.2.0.pom"
    ];
    hash = "sha256-022Fb/nNWex9VrwdnhmUPRD6lfy0ZTTZJL6FCaivpuQ=";
    installPath = "https/repo1.maven.org/maven2/com/github/lolgab/mill-mima-worker-api_3/0.2.0";
  };

  "com.github.lolgab_mill-mima_mill1_3-0.2.0" = fetchMaven {
    name = "com.github.lolgab_mill-mima_mill1_3-0.2.0";
    urls = [
      "https://repo1.maven.org/maven2/com/github/lolgab/mill-mima_mill1_3/0.2.0/mill-mima_mill1_3-0.2.0.jar"
      "https://repo1.maven.org/maven2/com/github/lolgab/mill-mima_mill1_3/0.2.0/mill-mima_mill1_3-0.2.0.pom"
    ];
    hash = "sha256-j9Wcu9zHRxN5+9Q0NeYm3dBThKfaNooitI4erEse4cM=";
    installPath = "https/repo1.maven.org/maven2/com/github/lolgab/mill-mima_mill1_3/0.2.0";
  };

  "com.github.luben_zstd-jni-1.5.7-4" = fetchMaven {
    name = "com.github.luben_zstd-jni-1.5.7-4";
    urls = [
      "https://repo1.maven.org/maven2/com/github/luben/zstd-jni/1.5.7-4/zstd-jni-1.5.7-4.jar"
      "https://repo1.maven.org/maven2/com/github/luben/zstd-jni/1.5.7-4/zstd-jni-1.5.7-4.pom"
    ];
    hash = "sha256-2EcBFO5+wfh8ciQ9vjvr0QK5poRO50kCCG8F4E6EzWk=";
    installPath = "https/repo1.maven.org/maven2/com/github/luben/zstd-jni/1.5.7-4";
  };

  "com.github.scopt_scopt_2.13-4.1.0" = fetchMaven {
    name = "com.github.scopt_scopt_2.13-4.1.0";
    urls = [
      "https://repo1.maven.org/maven2/com/github/scopt/scopt_2.13/4.1.0/scopt_2.13-4.1.0.jar"
      "https://repo1.maven.org/maven2/com/github/scopt/scopt_2.13/4.1.0/scopt_2.13-4.1.0.pom"
    ];
    hash = "sha256-8vlB7LBM6HNfmGOrsljlfCJ0SbMMpqR2Kmo9QWAKzJ8=";
    installPath = "https/repo1.maven.org/maven2/com/github/scopt/scopt_2.13/4.1.0";
  };

  "com.github.scopt_scopt_3-4.1.0" = fetchMaven {
    name = "com.github.scopt_scopt_3-4.1.0";
    urls = [
      "https://repo1.maven.org/maven2/com/github/scopt/scopt_3/4.1.0/scopt_3-4.1.0.jar"
      "https://repo1.maven.org/maven2/com/github/scopt/scopt_3/4.1.0/scopt_3-4.1.0.pom"
    ];
    hash = "sha256-Ivb94CUxeQR5SBz5sk2xXWRiRhbOlF3xrcB5y0trKG4=";
    installPath = "https/repo1.maven.org/maven2/com/github/scopt/scopt_3/4.1.0";
  };

  "com.google.errorprone_error_prone_annotations-2.38.0" = fetchMaven {
    name = "com.google.errorprone_error_prone_annotations-2.38.0";
    urls = [
      "https://repo1.maven.org/maven2/com/google/errorprone/error_prone_annotations/2.38.0/error_prone_annotations-2.38.0.jar"
      "https://repo1.maven.org/maven2/com/google/errorprone/error_prone_annotations/2.38.0/error_prone_annotations-2.38.0.pom"
    ];
    hash = "sha256-6o+9flsTZ2S4KuVyB+E684YdCMNLI/MFIWZtxueUblQ=";
    installPath = "https/repo1.maven.org/maven2/com/google/errorprone/error_prone_annotations/2.38.0";
  };

  "com.google.errorprone_error_prone_annotations-2.41.0" = fetchMaven {
    name = "com.google.errorprone_error_prone_annotations-2.41.0";
    urls = [
      "https://repo1.maven.org/maven2/com/google/errorprone/error_prone_annotations/2.41.0/error_prone_annotations-2.41.0.jar"
      "https://repo1.maven.org/maven2/com/google/errorprone/error_prone_annotations/2.41.0/error_prone_annotations-2.41.0.pom"
    ];
    hash = "sha256-Q+YOxLcD0WwrMI3uw1kKqAolxt4KZVdjuT6eGEubaPg=";
    installPath = "https/repo1.maven.org/maven2/com/google/errorprone/error_prone_annotations/2.41.0";
  };

  "com.google.errorprone_error_prone_parent-2.38.0" = fetchMaven {
    name = "com.google.errorprone_error_prone_parent-2.38.0";
    urls = [
      "https://repo1.maven.org/maven2/com/google/errorprone/error_prone_parent/2.38.0/error_prone_parent-2.38.0.pom"
    ];
    hash = "sha256-Slpqzg9HCEbtOt/SB8Ll4RqByiuo6jFAtRbTS2oT5U4=";
    installPath = "https/repo1.maven.org/maven2/com/google/errorprone/error_prone_parent/2.38.0";
  };

  "com.google.errorprone_error_prone_parent-2.41.0" = fetchMaven {
    name = "com.google.errorprone_error_prone_parent-2.41.0";
    urls = [
      "https://repo1.maven.org/maven2/com/google/errorprone/error_prone_parent/2.41.0/error_prone_parent-2.41.0.pom"
    ];
    hash = "sha256-wefFIBCjvUfqdaGh1inO6L3MQMqWkSRp2rE8kotNxm4=";
    installPath = "https/repo1.maven.org/maven2/com/google/errorprone/error_prone_parent/2.41.0";
  };

  "com.google.guava_failureaccess-1.0.1" = fetchMaven {
    name = "com.google.guava_failureaccess-1.0.1";
    urls = [
      "https://repo1.maven.org/maven2/com/google/guava/failureaccess/1.0.1/failureaccess-1.0.1.jar"
      "https://repo1.maven.org/maven2/com/google/guava/failureaccess/1.0.1/failureaccess-1.0.1.pom"
    ];
    hash = "sha256-keXAVKG0tjTFYMrmNnwUhTz9Tdvv6YgMTVf3WGPaWmM=";
    installPath = "https/repo1.maven.org/maven2/com/google/guava/failureaccess/1.0.1";
  };

  "com.google.guava_guava-30.1-jre" = fetchMaven {
    name = "com.google.guava_guava-30.1-jre";
    urls = [
      "https://repo1.maven.org/maven2/com/google/guava/guava/30.1-jre/guava-30.1-jre.jar"
      "https://repo1.maven.org/maven2/com/google/guava/guava/30.1-jre/guava-30.1-jre.pom"
    ];
    hash = "sha256-SILksEdHjUqzx9HshT4MC4yCKHLZ27GI9kw08BUmtXg=";
    installPath = "https/repo1.maven.org/maven2/com/google/guava/guava/30.1-jre";
  };

  "com.google.guava_guava-parent-26.0-android" = fetchMaven {
    name = "com.google.guava_guava-parent-26.0-android";
    urls = [
      "https://repo1.maven.org/maven2/com/google/guava/guava-parent/26.0-android/guava-parent-26.0-android.pom"
    ];
    hash = "sha256-E6Ip+1cPpK0zjeeIs6nlA7UKdoaVt4c+rJic/rZqXmU=";
    installPath = "https/repo1.maven.org/maven2/com/google/guava/guava-parent/26.0-android";
  };

  "com.google.guava_guava-parent-30.1-jre" = fetchMaven {
    name = "com.google.guava_guava-parent-30.1-jre";
    urls = [
      "https://repo1.maven.org/maven2/com/google/guava/guava-parent/30.1-jre/guava-parent-30.1-jre.pom"
    ];
    hash = "sha256-yB95NC1JrIdRkg/+VR6T5N1NbHSIt0v1mLCOqmJ5W3s=";
    installPath = "https/repo1.maven.org/maven2/com/google/guava/guava-parent/30.1-jre";
  };

  "com.google.guava_listenablefuture-9999.0-empty-to-avoid-conflict-with-guava" = fetchMaven {
    name = "com.google.guava_listenablefuture-9999.0-empty-to-avoid-conflict-with-guava";
    urls = [
      "https://repo1.maven.org/maven2/com/google/guava/listenablefuture/9999.0-empty-to-avoid-conflict-with-guava/listenablefuture-9999.0-empty-to-avoid-conflict-with-guava.jar"
      "https://repo1.maven.org/maven2/com/google/guava/listenablefuture/9999.0-empty-to-avoid-conflict-with-guava/listenablefuture-9999.0-empty-to-avoid-conflict-with-guava.pom"
    ];
    hash = "sha256-RKtfF6GYbf2zSPY1m+gj8UN8qpI0GcTyMCX6xPLTdq8=";
    installPath = "https/repo1.maven.org/maven2/com/google/guava/listenablefuture/9999.0-empty-to-avoid-conflict-with-guava";
  };

  "com.google.j2objc_j2objc-annotations-1.3" = fetchMaven {
    name = "com.google.j2objc_j2objc-annotations-1.3";
    urls = [
      "https://repo1.maven.org/maven2/com/google/j2objc/j2objc-annotations/1.3/j2objc-annotations-1.3.jar"
      "https://repo1.maven.org/maven2/com/google/j2objc/j2objc-annotations/1.3/j2objc-annotations-1.3.pom"
    ];
    hash = "sha256-66DvifOQZUx1Dp1O4uKA7mylXcgFQOBqcCIL7qVklbI=";
    installPath = "https/repo1.maven.org/maven2/com/google/j2objc/j2objc-annotations/1.3";
  };

  "com.googlecode.java-diff-utils_diffutils-1.3.0" = fetchMaven {
    name = "com.googlecode.java-diff-utils_diffutils-1.3.0";
    urls = [
      "https://repo1.maven.org/maven2/com/googlecode/java-diff-utils/diffutils/1.3.0/diffutils-1.3.0.jar"
      "https://repo1.maven.org/maven2/com/googlecode/java-diff-utils/diffutils/1.3.0/diffutils-1.3.0.pom"
    ];
    hash = "sha256-kazx/KomS1zOIS6BYlZXlYk5HzaJ47XlreWkjSKRXDg=";
    installPath = "https/repo1.maven.org/maven2/com/googlecode/java-diff-utils/diffutils/1.3.0";
  };

  "com.googlecode.javaewah_JavaEWAH-1.2.3" = fetchMaven {
    name = "com.googlecode.javaewah_JavaEWAH-1.2.3";
    urls = [
      "https://repo1.maven.org/maven2/com/googlecode/javaewah/JavaEWAH/1.2.3/JavaEWAH-1.2.3.jar"
      "https://repo1.maven.org/maven2/com/googlecode/javaewah/JavaEWAH/1.2.3/JavaEWAH-1.2.3.pom"
    ];
    hash = "sha256-1DO+Mxt7yFlIdMrR3v7xdPPSQcCEVLA0Lxn4ZwunmJU=";
    installPath = "https/repo1.maven.org/maven2/com/googlecode/javaewah/JavaEWAH/1.2.3";
  };

  "com.ibm.icu_icu4j-72.1" = fetchMaven {
    name = "com.ibm.icu_icu4j-72.1";
    urls = [
      "https://repo1.maven.org/maven2/com/ibm/icu/icu4j/72.1/icu4j-72.1.jar"
      "https://repo1.maven.org/maven2/com/ibm/icu/icu4j/72.1/icu4j-72.1.pom"
    ];
    hash = "sha256-3p8gpca1T8Q+zF/vIsgWBK5IpGsOH7roKSM1DCT+tBE=";
    installPath = "https/repo1.maven.org/maven2/com/ibm/icu/icu4j/72.1";
  };

  "com.vladsch.flexmark_flexmark-0.62.2" = fetchMaven {
    name = "com.vladsch.flexmark_flexmark-0.62.2";
    urls = [
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark/0.62.2/flexmark-0.62.2.jar"
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark/0.62.2/flexmark-0.62.2.pom"
    ];
    hash = "sha256-CMbMcOs3cMmCu7+sAh6qiwj63tMDlJ6qIrZRbHF2gDE=";
    installPath = "https/repo1.maven.org/maven2/com/vladsch/flexmark/flexmark/0.62.2";
  };

  "com.vladsch.flexmark_flexmark-0.64.8" = fetchMaven {
    name = "com.vladsch.flexmark_flexmark-0.64.8";
    urls = [
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark/0.64.8/flexmark-0.64.8.jar"
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark/0.64.8/flexmark-0.64.8.pom"
    ];
    hash = "sha256-92WRsOx/dAeEv+eFiXs5TOpndP2K3YiswytHaSbqXT4=";
    installPath = "https/repo1.maven.org/maven2/com/vladsch/flexmark/flexmark/0.64.8";
  };

  "com.vladsch.flexmark_flexmark-all-0.64.8" = fetchMaven {
    name = "com.vladsch.flexmark_flexmark-all-0.64.8";
    urls = [
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-all/0.64.8/flexmark-all-0.64.8.jar"
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-all/0.64.8/flexmark-all-0.64.8.pom"
    ];
    hash = "sha256-1zmirrJkV0JFCffmiEGFNOsMNBfdUb9f6OaNuwHj144=";
    installPath = "https/repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-all/0.64.8";
  };

  "com.vladsch.flexmark_flexmark-ext-abbreviation-0.64.8" = fetchMaven {
    name = "com.vladsch.flexmark_flexmark-ext-abbreviation-0.64.8";
    urls = [
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-abbreviation/0.64.8/flexmark-ext-abbreviation-0.64.8.jar"
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-abbreviation/0.64.8/flexmark-ext-abbreviation-0.64.8.pom"
    ];
    hash = "sha256-AlgqgNuOPqUuX9zMyChz+RM3u8e9rXyskWMushENhOk=";
    installPath = "https/repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-abbreviation/0.64.8";
  };

  "com.vladsch.flexmark_flexmark-ext-admonition-0.64.8" = fetchMaven {
    name = "com.vladsch.flexmark_flexmark-ext-admonition-0.64.8";
    urls = [
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-admonition/0.64.8/flexmark-ext-admonition-0.64.8.jar"
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-admonition/0.64.8/flexmark-ext-admonition-0.64.8.pom"
    ];
    hash = "sha256-SsQiTKo7EgJlX+agBipijxyJCYnG3o+GXQ78zpIkO0U=";
    installPath = "https/repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-admonition/0.64.8";
  };

  "com.vladsch.flexmark_flexmark-ext-anchorlink-0.62.2" = fetchMaven {
    name = "com.vladsch.flexmark_flexmark-ext-anchorlink-0.62.2";
    urls = [
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-anchorlink/0.62.2/flexmark-ext-anchorlink-0.62.2.jar"
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-anchorlink/0.62.2/flexmark-ext-anchorlink-0.62.2.pom"
    ];
    hash = "sha256-weHNR6k/69NjAg2Vs72ce1wOZ1rwBicv4TMLDS9jnGE=";
    installPath = "https/repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-anchorlink/0.62.2";
  };

  "com.vladsch.flexmark_flexmark-ext-anchorlink-0.64.8" = fetchMaven {
    name = "com.vladsch.flexmark_flexmark-ext-anchorlink-0.64.8";
    urls = [
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-anchorlink/0.64.8/flexmark-ext-anchorlink-0.64.8.jar"
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-anchorlink/0.64.8/flexmark-ext-anchorlink-0.64.8.pom"
    ];
    hash = "sha256-WPH5S3+E6Hq9f6P0Hg88TFQC77fjVYj4LrTfJ7u1O6g=";
    installPath = "https/repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-anchorlink/0.64.8";
  };

  "com.vladsch.flexmark_flexmark-ext-aside-0.64.8" = fetchMaven {
    name = "com.vladsch.flexmark_flexmark-ext-aside-0.64.8";
    urls = [
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-aside/0.64.8/flexmark-ext-aside-0.64.8.jar"
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-aside/0.64.8/flexmark-ext-aside-0.64.8.pom"
    ];
    hash = "sha256-u8MVmPOkCjjBXXVaU06bOjNYgP1bHsoibMoRQtIW3lw=";
    installPath = "https/repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-aside/0.64.8";
  };

  "com.vladsch.flexmark_flexmark-ext-attributes-0.64.8" = fetchMaven {
    name = "com.vladsch.flexmark_flexmark-ext-attributes-0.64.8";
    urls = [
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-attributes/0.64.8/flexmark-ext-attributes-0.64.8.jar"
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-attributes/0.64.8/flexmark-ext-attributes-0.64.8.pom"
    ];
    hash = "sha256-OOYFacg8Osm3t2Nvwp6ev1iFtAIplHWigPnmiS+UxVc=";
    installPath = "https/repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-attributes/0.64.8";
  };

  "com.vladsch.flexmark_flexmark-ext-autolink-0.62.2" = fetchMaven {
    name = "com.vladsch.flexmark_flexmark-ext-autolink-0.62.2";
    urls = [
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-autolink/0.62.2/flexmark-ext-autolink-0.62.2.jar"
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-autolink/0.62.2/flexmark-ext-autolink-0.62.2.pom"
    ];
    hash = "sha256-15OH05RylvbLSzEu47GBdhtKZvyP3ibjXETb+3Sn5+Y=";
    installPath = "https/repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-autolink/0.62.2";
  };

  "com.vladsch.flexmark_flexmark-ext-autolink-0.64.8" = fetchMaven {
    name = "com.vladsch.flexmark_flexmark-ext-autolink-0.64.8";
    urls = [
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-autolink/0.64.8/flexmark-ext-autolink-0.64.8.jar"
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-autolink/0.64.8/flexmark-ext-autolink-0.64.8.pom"
    ];
    hash = "sha256-jmm081mvpaM4gq6hEmaJsKB+jXHp24Ld6G4+4pU/Iek=";
    installPath = "https/repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-autolink/0.64.8";
  };

  "com.vladsch.flexmark_flexmark-ext-definition-0.64.8" = fetchMaven {
    name = "com.vladsch.flexmark_flexmark-ext-definition-0.64.8";
    urls = [
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-definition/0.64.8/flexmark-ext-definition-0.64.8.jar"
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-definition/0.64.8/flexmark-ext-definition-0.64.8.pom"
    ];
    hash = "sha256-95HZNsLWJTnpV/+O+qyPZGSAiB/My6NGa+Etc6zDXdk=";
    installPath = "https/repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-definition/0.64.8";
  };

  "com.vladsch.flexmark_flexmark-ext-emoji-0.62.2" = fetchMaven {
    name = "com.vladsch.flexmark_flexmark-ext-emoji-0.62.2";
    urls = [
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-emoji/0.62.2/flexmark-ext-emoji-0.62.2.jar"
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-emoji/0.62.2/flexmark-ext-emoji-0.62.2.pom"
    ];
    hash = "sha256-UHbh+WMLnLqFzhE9GIdc3pwFEBy94rNpWT6olRGnIvI=";
    installPath = "https/repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-emoji/0.62.2";
  };

  "com.vladsch.flexmark_flexmark-ext-emoji-0.64.8" = fetchMaven {
    name = "com.vladsch.flexmark_flexmark-ext-emoji-0.64.8";
    urls = [
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-emoji/0.64.8/flexmark-ext-emoji-0.64.8.jar"
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-emoji/0.64.8/flexmark-ext-emoji-0.64.8.pom"
    ];
    hash = "sha256-mvlxVlLTcOD8jMO0XjFDd5H/JrrEQK38ohEG5tgWAOo=";
    installPath = "https/repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-emoji/0.64.8";
  };

  "com.vladsch.flexmark_flexmark-ext-enumerated-reference-0.64.8" = fetchMaven {
    name = "com.vladsch.flexmark_flexmark-ext-enumerated-reference-0.64.8";
    urls = [
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-enumerated-reference/0.64.8/flexmark-ext-enumerated-reference-0.64.8.jar"
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-enumerated-reference/0.64.8/flexmark-ext-enumerated-reference-0.64.8.pom"
    ];
    hash = "sha256-WR/iUP1E5IvbmUDxD7R23MrMg0K38hEvbhvw7tp9znI=";
    installPath = "https/repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-enumerated-reference/0.64.8";
  };

  "com.vladsch.flexmark_flexmark-ext-escaped-character-0.64.8" = fetchMaven {
    name = "com.vladsch.flexmark_flexmark-ext-escaped-character-0.64.8";
    urls = [
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-escaped-character/0.64.8/flexmark-ext-escaped-character-0.64.8.jar"
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-escaped-character/0.64.8/flexmark-ext-escaped-character-0.64.8.pom"
    ];
    hash = "sha256-rhZ4W3hSz+rvR/qV8whRBDS2GOM86JKZszbc0z5/U/A=";
    installPath = "https/repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-escaped-character/0.64.8";
  };

  "com.vladsch.flexmark_flexmark-ext-footnotes-0.64.8" = fetchMaven {
    name = "com.vladsch.flexmark_flexmark-ext-footnotes-0.64.8";
    urls = [
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-footnotes/0.64.8/flexmark-ext-footnotes-0.64.8.jar"
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-footnotes/0.64.8/flexmark-ext-footnotes-0.64.8.pom"
    ];
    hash = "sha256-tSxgeVxXDbAEcUvT8TT504gQrLSGuEJGr31C85YZTQ0=";
    installPath = "https/repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-footnotes/0.64.8";
  };

  "com.vladsch.flexmark_flexmark-ext-gfm-issues-0.64.8" = fetchMaven {
    name = "com.vladsch.flexmark_flexmark-ext-gfm-issues-0.64.8";
    urls = [
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-gfm-issues/0.64.8/flexmark-ext-gfm-issues-0.64.8.jar"
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-gfm-issues/0.64.8/flexmark-ext-gfm-issues-0.64.8.pom"
    ];
    hash = "sha256-8wb9gYvA93Tif964YCBARvJ8nRVyTd49JFvoOmQYnLc=";
    installPath = "https/repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-gfm-issues/0.64.8";
  };

  "com.vladsch.flexmark_flexmark-ext-gfm-strikethrough-0.62.2" = fetchMaven {
    name = "com.vladsch.flexmark_flexmark-ext-gfm-strikethrough-0.62.2";
    urls = [
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-gfm-strikethrough/0.62.2/flexmark-ext-gfm-strikethrough-0.62.2.jar"
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-gfm-strikethrough/0.62.2/flexmark-ext-gfm-strikethrough-0.62.2.pom"
    ];
    hash = "sha256-1l/E13+s+Pc/CVD28MVSrqRUkkrfwKD6K0+2zvCQX8o=";
    installPath = "https/repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-gfm-strikethrough/0.62.2";
  };

  "com.vladsch.flexmark_flexmark-ext-gfm-strikethrough-0.64.8" = fetchMaven {
    name = "com.vladsch.flexmark_flexmark-ext-gfm-strikethrough-0.64.8";
    urls = [
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-gfm-strikethrough/0.64.8/flexmark-ext-gfm-strikethrough-0.64.8.jar"
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-gfm-strikethrough/0.64.8/flexmark-ext-gfm-strikethrough-0.64.8.pom"
    ];
    hash = "sha256-zNDfvFkH8sbZHjRDmtTwWklkSxBO7K7/Sa1K/wxclZY=";
    installPath = "https/repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-gfm-strikethrough/0.64.8";
  };

  "com.vladsch.flexmark_flexmark-ext-gfm-tasklist-0.62.2" = fetchMaven {
    name = "com.vladsch.flexmark_flexmark-ext-gfm-tasklist-0.62.2";
    urls = [
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-gfm-tasklist/0.62.2/flexmark-ext-gfm-tasklist-0.62.2.jar"
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-gfm-tasklist/0.62.2/flexmark-ext-gfm-tasklist-0.62.2.pom"
    ];
    hash = "sha256-gtACK+9qTISC22QYuWoyvgNeTXmuSOZxXuojXESKAvE=";
    installPath = "https/repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-gfm-tasklist/0.62.2";
  };

  "com.vladsch.flexmark_flexmark-ext-gfm-tasklist-0.64.8" = fetchMaven {
    name = "com.vladsch.flexmark_flexmark-ext-gfm-tasklist-0.64.8";
    urls = [
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-gfm-tasklist/0.64.8/flexmark-ext-gfm-tasklist-0.64.8.jar"
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-gfm-tasklist/0.64.8/flexmark-ext-gfm-tasklist-0.64.8.pom"
    ];
    hash = "sha256-67B3bimRIZMTml19nYEFCY+0gMQGMJsbUakTysESq7c=";
    installPath = "https/repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-gfm-tasklist/0.64.8";
  };

  "com.vladsch.flexmark_flexmark-ext-gfm-users-0.64.8" = fetchMaven {
    name = "com.vladsch.flexmark_flexmark-ext-gfm-users-0.64.8";
    urls = [
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-gfm-users/0.64.8/flexmark-ext-gfm-users-0.64.8.jar"
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-gfm-users/0.64.8/flexmark-ext-gfm-users-0.64.8.pom"
    ];
    hash = "sha256-5HxajGHbwijC9jMK9olXZwIODSDOXPEo6lmGPFqE14g=";
    installPath = "https/repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-gfm-users/0.64.8";
  };

  "com.vladsch.flexmark_flexmark-ext-gitlab-0.64.8" = fetchMaven {
    name = "com.vladsch.flexmark_flexmark-ext-gitlab-0.64.8";
    urls = [
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-gitlab/0.64.8/flexmark-ext-gitlab-0.64.8.jar"
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-gitlab/0.64.8/flexmark-ext-gitlab-0.64.8.pom"
    ];
    hash = "sha256-nv1ZSJxPZyexZ8QG2HK/d+enHeFAZv/EEGg2D6uCcmQ=";
    installPath = "https/repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-gitlab/0.64.8";
  };

  "com.vladsch.flexmark_flexmark-ext-ins-0.62.2" = fetchMaven {
    name = "com.vladsch.flexmark_flexmark-ext-ins-0.62.2";
    urls = [
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-ins/0.62.2/flexmark-ext-ins-0.62.2.jar"
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-ins/0.62.2/flexmark-ext-ins-0.62.2.pom"
    ];
    hash = "sha256-VIKNuMXAxAbmNWnk2nWPgpSzbkoGfpA6miKQuvOUmF4=";
    installPath = "https/repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-ins/0.62.2";
  };

  "com.vladsch.flexmark_flexmark-ext-ins-0.64.8" = fetchMaven {
    name = "com.vladsch.flexmark_flexmark-ext-ins-0.64.8";
    urls = [
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-ins/0.64.8/flexmark-ext-ins-0.64.8.jar"
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-ins/0.64.8/flexmark-ext-ins-0.64.8.pom"
    ];
    hash = "sha256-J31G3JnuDiQmp/K0/E7xbgauwtVJNHWYmjuIneH9J9Q=";
    installPath = "https/repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-ins/0.64.8";
  };

  "com.vladsch.flexmark_flexmark-ext-jekyll-front-matter-0.64.8" = fetchMaven {
    name = "com.vladsch.flexmark_flexmark-ext-jekyll-front-matter-0.64.8";
    urls = [
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-jekyll-front-matter/0.64.8/flexmark-ext-jekyll-front-matter-0.64.8.jar"
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-jekyll-front-matter/0.64.8/flexmark-ext-jekyll-front-matter-0.64.8.pom"
    ];
    hash = "sha256-/I0CVRsqoqMpXe2DzhpbEnI15W2tgXVfNArS8P7n7zI=";
    installPath = "https/repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-jekyll-front-matter/0.64.8";
  };

  "com.vladsch.flexmark_flexmark-ext-jekyll-tag-0.64.8" = fetchMaven {
    name = "com.vladsch.flexmark_flexmark-ext-jekyll-tag-0.64.8";
    urls = [
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-jekyll-tag/0.64.8/flexmark-ext-jekyll-tag-0.64.8.jar"
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-jekyll-tag/0.64.8/flexmark-ext-jekyll-tag-0.64.8.pom"
    ];
    hash = "sha256-ZjKn2HPnEcYcFu2WlHhYL/VfLTfSpblK6mGGA2Oi3dw=";
    installPath = "https/repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-jekyll-tag/0.64.8";
  };

  "com.vladsch.flexmark_flexmark-ext-macros-0.64.8" = fetchMaven {
    name = "com.vladsch.flexmark_flexmark-ext-macros-0.64.8";
    urls = [
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-macros/0.64.8/flexmark-ext-macros-0.64.8.jar"
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-macros/0.64.8/flexmark-ext-macros-0.64.8.pom"
    ];
    hash = "sha256-2z4B5Cda+wwnTvBUVAiD5oIp/iyQa+e4Kr7/xhZkmaY=";
    installPath = "https/repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-macros/0.64.8";
  };

  "com.vladsch.flexmark_flexmark-ext-media-tags-0.64.8" = fetchMaven {
    name = "com.vladsch.flexmark_flexmark-ext-media-tags-0.64.8";
    urls = [
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-media-tags/0.64.8/flexmark-ext-media-tags-0.64.8.jar"
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-media-tags/0.64.8/flexmark-ext-media-tags-0.64.8.pom"
    ];
    hash = "sha256-+NOkiJ8LT2kg0v2ndJrQsFgRFiFi0Ldiq6ibUc1Fn/8=";
    installPath = "https/repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-media-tags/0.64.8";
  };

  "com.vladsch.flexmark_flexmark-ext-resizable-image-0.64.8" = fetchMaven {
    name = "com.vladsch.flexmark_flexmark-ext-resizable-image-0.64.8";
    urls = [
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-resizable-image/0.64.8/flexmark-ext-resizable-image-0.64.8.jar"
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-resizable-image/0.64.8/flexmark-ext-resizable-image-0.64.8.pom"
    ];
    hash = "sha256-AfK2ExZ0gD7dk5XC68byUFpf53qL9+ZRDIMVGr3NbUQ=";
    installPath = "https/repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-resizable-image/0.64.8";
  };

  "com.vladsch.flexmark_flexmark-ext-superscript-0.62.2" = fetchMaven {
    name = "com.vladsch.flexmark_flexmark-ext-superscript-0.62.2";
    urls = [
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-superscript/0.62.2/flexmark-ext-superscript-0.62.2.jar"
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-superscript/0.62.2/flexmark-ext-superscript-0.62.2.pom"
    ];
    hash = "sha256-pfRu434uIlDIkwSEaFwxZFwcUjTnU5cbuSfsG578PC4=";
    installPath = "https/repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-superscript/0.62.2";
  };

  "com.vladsch.flexmark_flexmark-ext-superscript-0.64.8" = fetchMaven {
    name = "com.vladsch.flexmark_flexmark-ext-superscript-0.64.8";
    urls = [
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-superscript/0.64.8/flexmark-ext-superscript-0.64.8.jar"
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-superscript/0.64.8/flexmark-ext-superscript-0.64.8.pom"
    ];
    hash = "sha256-uOc872jXRxOHS2gdv40fgau9JNG88YjVB+TzT2g5WUc=";
    installPath = "https/repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-superscript/0.64.8";
  };

  "com.vladsch.flexmark_flexmark-ext-tables-0.62.2" = fetchMaven {
    name = "com.vladsch.flexmark_flexmark-ext-tables-0.62.2";
    urls = [
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-tables/0.62.2/flexmark-ext-tables-0.62.2.jar"
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-tables/0.62.2/flexmark-ext-tables-0.62.2.pom"
    ];
    hash = "sha256-3Fef3ZHc6jjwTHjvOGsVvLAMbRMwJHlZ5X7SKIaCj6w=";
    installPath = "https/repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-tables/0.62.2";
  };

  "com.vladsch.flexmark_flexmark-ext-tables-0.64.8" = fetchMaven {
    name = "com.vladsch.flexmark_flexmark-ext-tables-0.64.8";
    urls = [
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-tables/0.64.8/flexmark-ext-tables-0.64.8.jar"
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-tables/0.64.8/flexmark-ext-tables-0.64.8.pom"
    ];
    hash = "sha256-4dbI3CvpiM4YzNKRN3vNgmR4mWKUTfJ+xk3G5+w1t1A=";
    installPath = "https/repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-tables/0.64.8";
  };

  "com.vladsch.flexmark_flexmark-ext-toc-0.64.8" = fetchMaven {
    name = "com.vladsch.flexmark_flexmark-ext-toc-0.64.8";
    urls = [
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-toc/0.64.8/flexmark-ext-toc-0.64.8.jar"
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-toc/0.64.8/flexmark-ext-toc-0.64.8.pom"
    ];
    hash = "sha256-BF0aQe+S00NVwNsw57jywGSpelGpSZp6GPu3FgimwmY=";
    installPath = "https/repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-toc/0.64.8";
  };

  "com.vladsch.flexmark_flexmark-ext-typographic-0.64.8" = fetchMaven {
    name = "com.vladsch.flexmark_flexmark-ext-typographic-0.64.8";
    urls = [
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-typographic/0.64.8/flexmark-ext-typographic-0.64.8.jar"
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-typographic/0.64.8/flexmark-ext-typographic-0.64.8.pom"
    ];
    hash = "sha256-xvZoylw/O55Frg0RuD+cAJ8ubrOF9xPTuOInu0Sq1bg=";
    installPath = "https/repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-typographic/0.64.8";
  };

  "com.vladsch.flexmark_flexmark-ext-wikilink-0.62.2" = fetchMaven {
    name = "com.vladsch.flexmark_flexmark-ext-wikilink-0.62.2";
    urls = [
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-wikilink/0.62.2/flexmark-ext-wikilink-0.62.2.jar"
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-wikilink/0.62.2/flexmark-ext-wikilink-0.62.2.pom"
    ];
    hash = "sha256-NQtfUT4F3p6+nGk6o07EwlX1kZvkXarCfWw07QQgYyE=";
    installPath = "https/repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-wikilink/0.62.2";
  };

  "com.vladsch.flexmark_flexmark-ext-wikilink-0.64.8" = fetchMaven {
    name = "com.vladsch.flexmark_flexmark-ext-wikilink-0.64.8";
    urls = [
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-wikilink/0.64.8/flexmark-ext-wikilink-0.64.8.jar"
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-wikilink/0.64.8/flexmark-ext-wikilink-0.64.8.pom"
    ];
    hash = "sha256-AmdM6/UcOQnj+6J7BofGMU0bT4Gensge6Cd5Mv9WRtQ=";
    installPath = "https/repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-wikilink/0.64.8";
  };

  "com.vladsch.flexmark_flexmark-ext-xwiki-macros-0.64.8" = fetchMaven {
    name = "com.vladsch.flexmark_flexmark-ext-xwiki-macros-0.64.8";
    urls = [
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-xwiki-macros/0.64.8/flexmark-ext-xwiki-macros-0.64.8.jar"
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-xwiki-macros/0.64.8/flexmark-ext-xwiki-macros-0.64.8.pom"
    ];
    hash = "sha256-ilFcAdy5Os3KLt6a2kL8ELZMJYyTSFAlEZETEHTrOLE=";
    installPath = "https/repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-xwiki-macros/0.64.8";
  };

  "com.vladsch.flexmark_flexmark-ext-yaml-front-matter-0.62.2" = fetchMaven {
    name = "com.vladsch.flexmark_flexmark-ext-yaml-front-matter-0.62.2";
    urls = [
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-yaml-front-matter/0.62.2/flexmark-ext-yaml-front-matter-0.62.2.jar"
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-yaml-front-matter/0.62.2/flexmark-ext-yaml-front-matter-0.62.2.pom"
    ];
    hash = "sha256-tc0KpVAhnflMmVlFUXFqwocYsXuL3PiXeFtdO+p9Ta4=";
    installPath = "https/repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-yaml-front-matter/0.62.2";
  };

  "com.vladsch.flexmark_flexmark-ext-yaml-front-matter-0.64.8" = fetchMaven {
    name = "com.vladsch.flexmark_flexmark-ext-yaml-front-matter-0.64.8";
    urls = [
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-yaml-front-matter/0.64.8/flexmark-ext-yaml-front-matter-0.64.8.jar"
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-yaml-front-matter/0.64.8/flexmark-ext-yaml-front-matter-0.64.8.pom"
    ];
    hash = "sha256-V6UI6lpxcApE3qu0m4rB6U897uBfmoG6objZ5OFDdhk=";
    installPath = "https/repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-yaml-front-matter/0.64.8";
  };

  "com.vladsch.flexmark_flexmark-ext-youtube-embedded-0.64.8" = fetchMaven {
    name = "com.vladsch.flexmark_flexmark-ext-youtube-embedded-0.64.8";
    urls = [
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-youtube-embedded/0.64.8/flexmark-ext-youtube-embedded-0.64.8.jar"
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-youtube-embedded/0.64.8/flexmark-ext-youtube-embedded-0.64.8.pom"
    ];
    hash = "sha256-sIhCO2F41Z2TCN/JZ4ZiOAB8yp0Bgq5JKapNZTuh++o=";
    installPath = "https/repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-ext-youtube-embedded/0.64.8";
  };

  "com.vladsch.flexmark_flexmark-html2md-converter-0.64.8" = fetchMaven {
    name = "com.vladsch.flexmark_flexmark-html2md-converter-0.64.8";
    urls = [
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-html2md-converter/0.64.8/flexmark-html2md-converter-0.64.8.jar"
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-html2md-converter/0.64.8/flexmark-html2md-converter-0.64.8.pom"
    ];
    hash = "sha256-q6uV+sG+hXlvXarWO4mhBZJNqK/o90viLhg0sGdmZ5A=";
    installPath = "https/repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-html2md-converter/0.64.8";
  };

  "com.vladsch.flexmark_flexmark-java-0.62.2" = fetchMaven {
    name = "com.vladsch.flexmark_flexmark-java-0.62.2";
    urls = [
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-java/0.62.2/flexmark-java-0.62.2.pom"
    ];
    hash = "sha256-DlxcWCry0vUFs1L54guu8FLGgpuYD9+ksL2x5sv6E9c=";
    installPath = "https/repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-java/0.62.2";
  };

  "com.vladsch.flexmark_flexmark-java-0.64.8" = fetchMaven {
    name = "com.vladsch.flexmark_flexmark-java-0.64.8";
    urls = [
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-java/0.64.8/flexmark-java-0.64.8.pom"
    ];
    hash = "sha256-9t8wYGad4ScGv1NTAfdPCRBQmzGHKfBWCEe7u20zf5o=";
    installPath = "https/repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-java/0.64.8";
  };

  "com.vladsch.flexmark_flexmark-jira-converter-0.62.2" = fetchMaven {
    name = "com.vladsch.flexmark_flexmark-jira-converter-0.62.2";
    urls = [
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-jira-converter/0.62.2/flexmark-jira-converter-0.62.2.jar"
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-jira-converter/0.62.2/flexmark-jira-converter-0.62.2.pom"
    ];
    hash = "sha256-k4eeiCIqq4fE5F0MPS9FMDEdlWEb+Gd36pDNxQSFMFY=";
    installPath = "https/repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-jira-converter/0.62.2";
  };

  "com.vladsch.flexmark_flexmark-jira-converter-0.64.8" = fetchMaven {
    name = "com.vladsch.flexmark_flexmark-jira-converter-0.64.8";
    urls = [
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-jira-converter/0.64.8/flexmark-jira-converter-0.64.8.jar"
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-jira-converter/0.64.8/flexmark-jira-converter-0.64.8.pom"
    ];
    hash = "sha256-Rh+v0qIN10o4eO/87wBajGSm8Vqjrfks3Zm0F7yDUW4=";
    installPath = "https/repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-jira-converter/0.64.8";
  };

  "com.vladsch.flexmark_flexmark-pdf-converter-0.64.8" = fetchMaven {
    name = "com.vladsch.flexmark_flexmark-pdf-converter-0.64.8";
    urls = [
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-pdf-converter/0.64.8/flexmark-pdf-converter-0.64.8.jar"
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-pdf-converter/0.64.8/flexmark-pdf-converter-0.64.8.pom"
    ];
    hash = "sha256-LYhyIU3XPcpwKYI0HmUzsc/vPV78xq43KyXjnYIgpIk=";
    installPath = "https/repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-pdf-converter/0.64.8";
  };

  "com.vladsch.flexmark_flexmark-profile-pegdown-0.64.8" = fetchMaven {
    name = "com.vladsch.flexmark_flexmark-profile-pegdown-0.64.8";
    urls = [
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-profile-pegdown/0.64.8/flexmark-profile-pegdown-0.64.8.jar"
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-profile-pegdown/0.64.8/flexmark-profile-pegdown-0.64.8.pom"
    ];
    hash = "sha256-rf4JAwATbuU70MTXxnewoebOqnLwe009svUnuN00GWY=";
    installPath = "https/repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-profile-pegdown/0.64.8";
  };

  "com.vladsch.flexmark_flexmark-util-0.62.2" = fetchMaven {
    name = "com.vladsch.flexmark_flexmark-util-0.62.2";
    urls = [
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-util/0.62.2/flexmark-util-0.62.2.jar"
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-util/0.62.2/flexmark-util-0.62.2.pom"
    ];
    hash = "sha256-A3coPMDIx8qFH4WcoKFEcAY6MDeICS9olH/SPgIEbeI=";
    installPath = "https/repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-util/0.62.2";
  };

  "com.vladsch.flexmark_flexmark-util-0.64.8" = fetchMaven {
    name = "com.vladsch.flexmark_flexmark-util-0.64.8";
    urls = [
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-util/0.64.8/flexmark-util-0.64.8.jar"
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-util/0.64.8/flexmark-util-0.64.8.pom"
    ];
    hash = "sha256-6FXXKHH/0JhQt8nWJne0pYsDxldZz6Ro2KXoQGNnjEg=";
    installPath = "https/repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-util/0.64.8";
  };

  "com.vladsch.flexmark_flexmark-util-ast-0.62.2" = fetchMaven {
    name = "com.vladsch.flexmark_flexmark-util-ast-0.62.2";
    urls = [
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-util-ast/0.62.2/flexmark-util-ast-0.62.2.jar"
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-util-ast/0.62.2/flexmark-util-ast-0.62.2.pom"
    ];
    hash = "sha256-bT7Cqm3k63wFdcC63M3WAtz5p0QqArmmCvpfPGuvDjw=";
    installPath = "https/repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-util-ast/0.62.2";
  };

  "com.vladsch.flexmark_flexmark-util-ast-0.64.8" = fetchMaven {
    name = "com.vladsch.flexmark_flexmark-util-ast-0.64.8";
    urls = [
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-util-ast/0.64.8/flexmark-util-ast-0.64.8.jar"
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-util-ast/0.64.8/flexmark-util-ast-0.64.8.pom"
    ];
    hash = "sha256-wmS6AiF8kOYu/C/0LVSNtTPAFtp1v6F7yE0tqNLpOgs=";
    installPath = "https/repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-util-ast/0.64.8";
  };

  "com.vladsch.flexmark_flexmark-util-builder-0.62.2" = fetchMaven {
    name = "com.vladsch.flexmark_flexmark-util-builder-0.62.2";
    urls = [
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-util-builder/0.62.2/flexmark-util-builder-0.62.2.jar"
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-util-builder/0.62.2/flexmark-util-builder-0.62.2.pom"
    ];
    hash = "sha256-+kjX932WxGRANJw+UPDyy8MJB6wKUXI7tf+PyOAYbJM=";
    installPath = "https/repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-util-builder/0.62.2";
  };

  "com.vladsch.flexmark_flexmark-util-builder-0.64.8" = fetchMaven {
    name = "com.vladsch.flexmark_flexmark-util-builder-0.64.8";
    urls = [
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-util-builder/0.64.8/flexmark-util-builder-0.64.8.jar"
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-util-builder/0.64.8/flexmark-util-builder-0.64.8.pom"
    ];
    hash = "sha256-kPW7NjRgtQbDS/b21kCX1D4RkhUZCXp9GOgUJJMkfKQ=";
    installPath = "https/repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-util-builder/0.64.8";
  };

  "com.vladsch.flexmark_flexmark-util-collection-0.62.2" = fetchMaven {
    name = "com.vladsch.flexmark_flexmark-util-collection-0.62.2";
    urls = [
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-util-collection/0.62.2/flexmark-util-collection-0.62.2.jar"
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-util-collection/0.62.2/flexmark-util-collection-0.62.2.pom"
    ];
    hash = "sha256-vsdaPDU/TcTKnim4MAWhcXp4P0upYTWIMLMSCeg6Wx4=";
    installPath = "https/repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-util-collection/0.62.2";
  };

  "com.vladsch.flexmark_flexmark-util-collection-0.64.8" = fetchMaven {
    name = "com.vladsch.flexmark_flexmark-util-collection-0.64.8";
    urls = [
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-util-collection/0.64.8/flexmark-util-collection-0.64.8.jar"
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-util-collection/0.64.8/flexmark-util-collection-0.64.8.pom"
    ];
    hash = "sha256-6CLn1LMnS3NiOPKvXKTP5i2cqBNvK+G/WdOZLKUreXE=";
    installPath = "https/repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-util-collection/0.64.8";
  };

  "com.vladsch.flexmark_flexmark-util-data-0.62.2" = fetchMaven {
    name = "com.vladsch.flexmark_flexmark-util-data-0.62.2";
    urls = [
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-util-data/0.62.2/flexmark-util-data-0.62.2.jar"
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-util-data/0.62.2/flexmark-util-data-0.62.2.pom"
    ];
    hash = "sha256-m3S05kD1HNXWdGXPwXapNqzLv4g2WicpuaNUJjvZDW4=";
    installPath = "https/repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-util-data/0.62.2";
  };

  "com.vladsch.flexmark_flexmark-util-data-0.64.8" = fetchMaven {
    name = "com.vladsch.flexmark_flexmark-util-data-0.64.8";
    urls = [
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-util-data/0.64.8/flexmark-util-data-0.64.8.jar"
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-util-data/0.64.8/flexmark-util-data-0.64.8.pom"
    ];
    hash = "sha256-zjv3PUBdz0/uVhh+M0MnRyPEIjRCnNCcgjCnsDjB9Lk=";
    installPath = "https/repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-util-data/0.64.8";
  };

  "com.vladsch.flexmark_flexmark-util-dependency-0.62.2" = fetchMaven {
    name = "com.vladsch.flexmark_flexmark-util-dependency-0.62.2";
    urls = [
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-util-dependency/0.62.2/flexmark-util-dependency-0.62.2.jar"
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-util-dependency/0.62.2/flexmark-util-dependency-0.62.2.pom"
    ];
    hash = "sha256-nSFsXZXFD67UbxMv6hAZEjv6VfCmewH9PsP6zk7vLR4=";
    installPath = "https/repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-util-dependency/0.62.2";
  };

  "com.vladsch.flexmark_flexmark-util-dependency-0.64.8" = fetchMaven {
    name = "com.vladsch.flexmark_flexmark-util-dependency-0.64.8";
    urls = [
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-util-dependency/0.64.8/flexmark-util-dependency-0.64.8.jar"
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-util-dependency/0.64.8/flexmark-util-dependency-0.64.8.pom"
    ];
    hash = "sha256-QBPR6rl4wVjXgxMG+cQwKzeuBu3rMK29YGtLuhXLjEk=";
    installPath = "https/repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-util-dependency/0.64.8";
  };

  "com.vladsch.flexmark_flexmark-util-format-0.62.2" = fetchMaven {
    name = "com.vladsch.flexmark_flexmark-util-format-0.62.2";
    urls = [
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-util-format/0.62.2/flexmark-util-format-0.62.2.jar"
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-util-format/0.62.2/flexmark-util-format-0.62.2.pom"
    ];
    hash = "sha256-j7GbAIjjp00wTPbuXCTO//af5J5JooOPmHh2Da3jBd0=";
    installPath = "https/repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-util-format/0.62.2";
  };

  "com.vladsch.flexmark_flexmark-util-format-0.64.8" = fetchMaven {
    name = "com.vladsch.flexmark_flexmark-util-format-0.64.8";
    urls = [
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-util-format/0.64.8/flexmark-util-format-0.64.8.jar"
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-util-format/0.64.8/flexmark-util-format-0.64.8.pom"
    ];
    hash = "sha256-NJ6eaKI162fMED4aE6XY16sRn05Pa/bpvlm006Hh+w8=";
    installPath = "https/repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-util-format/0.64.8";
  };

  "com.vladsch.flexmark_flexmark-util-html-0.62.2" = fetchMaven {
    name = "com.vladsch.flexmark_flexmark-util-html-0.62.2";
    urls = [
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-util-html/0.62.2/flexmark-util-html-0.62.2.jar"
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-util-html/0.62.2/flexmark-util-html-0.62.2.pom"
    ];
    hash = "sha256-9MSBM5awDcqrCDRtRKKCrxD35X5DYf+U7NmUR8OOW94=";
    installPath = "https/repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-util-html/0.62.2";
  };

  "com.vladsch.flexmark_flexmark-util-html-0.64.8" = fetchMaven {
    name = "com.vladsch.flexmark_flexmark-util-html-0.64.8";
    urls = [
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-util-html/0.64.8/flexmark-util-html-0.64.8.jar"
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-util-html/0.64.8/flexmark-util-html-0.64.8.pom"
    ];
    hash = "sha256-ZyHVY1zlxf/enFsHwu6plMpg4Udoj6uWUao1mUkS5Bk=";
    installPath = "https/repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-util-html/0.64.8";
  };

  "com.vladsch.flexmark_flexmark-util-misc-0.62.2" = fetchMaven {
    name = "com.vladsch.flexmark_flexmark-util-misc-0.62.2";
    urls = [
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-util-misc/0.62.2/flexmark-util-misc-0.62.2.jar"
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-util-misc/0.62.2/flexmark-util-misc-0.62.2.pom"
    ];
    hash = "sha256-VfG2y0OgXWkcDF0VNHFTnOsf1jjmZtSZThZABQ0yc5A=";
    installPath = "https/repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-util-misc/0.62.2";
  };

  "com.vladsch.flexmark_flexmark-util-misc-0.64.8" = fetchMaven {
    name = "com.vladsch.flexmark_flexmark-util-misc-0.64.8";
    urls = [
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-util-misc/0.64.8/flexmark-util-misc-0.64.8.jar"
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-util-misc/0.64.8/flexmark-util-misc-0.64.8.pom"
    ];
    hash = "sha256-bnfhnTTht1CpZRYjn+GPfvDf+dg4fFFlF4WWteG3A3k=";
    installPath = "https/repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-util-misc/0.64.8";
  };

  "com.vladsch.flexmark_flexmark-util-options-0.62.2" = fetchMaven {
    name = "com.vladsch.flexmark_flexmark-util-options-0.62.2";
    urls = [
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-util-options/0.62.2/flexmark-util-options-0.62.2.jar"
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-util-options/0.62.2/flexmark-util-options-0.62.2.pom"
    ];
    hash = "sha256-Px6MK19ozVJLQGj3fCpDhMTUtrWLzhiqdDDRdBpf8i8=";
    installPath = "https/repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-util-options/0.62.2";
  };

  "com.vladsch.flexmark_flexmark-util-options-0.64.8" = fetchMaven {
    name = "com.vladsch.flexmark_flexmark-util-options-0.64.8";
    urls = [
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-util-options/0.64.8/flexmark-util-options-0.64.8.jar"
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-util-options/0.64.8/flexmark-util-options-0.64.8.pom"
    ];
    hash = "sha256-h5rTaSPmzDzGgmJt6oO4mmL/HFsnjL23r03fuqzIkHk=";
    installPath = "https/repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-util-options/0.64.8";
  };

  "com.vladsch.flexmark_flexmark-util-sequence-0.62.2" = fetchMaven {
    name = "com.vladsch.flexmark_flexmark-util-sequence-0.62.2";
    urls = [
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-util-sequence/0.62.2/flexmark-util-sequence-0.62.2.jar"
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-util-sequence/0.62.2/flexmark-util-sequence-0.62.2.pom"
    ];
    hash = "sha256-J8ZXFheFBaMP+b9VMZ02j5Sonvtf26k6DR7C5AspxVg=";
    installPath = "https/repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-util-sequence/0.62.2";
  };

  "com.vladsch.flexmark_flexmark-util-sequence-0.64.8" = fetchMaven {
    name = "com.vladsch.flexmark_flexmark-util-sequence-0.64.8";
    urls = [
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-util-sequence/0.64.8/flexmark-util-sequence-0.64.8.jar"
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-util-sequence/0.64.8/flexmark-util-sequence-0.64.8.pom"
    ];
    hash = "sha256-zPgr56DT8JdZ2hKOTIMA29n4BVJNhCsYlaWokKvSd6k=";
    installPath = "https/repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-util-sequence/0.64.8";
  };

  "com.vladsch.flexmark_flexmark-util-visitor-0.62.2" = fetchMaven {
    name = "com.vladsch.flexmark_flexmark-util-visitor-0.62.2";
    urls = [
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-util-visitor/0.62.2/flexmark-util-visitor-0.62.2.jar"
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-util-visitor/0.62.2/flexmark-util-visitor-0.62.2.pom"
    ];
    hash = "sha256-sGUXA1qXnyVQTMPXJoAh4L1+L895QeeW7oazG3/NqyI=";
    installPath = "https/repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-util-visitor/0.62.2";
  };

  "com.vladsch.flexmark_flexmark-util-visitor-0.64.8" = fetchMaven {
    name = "com.vladsch.flexmark_flexmark-util-visitor-0.64.8";
    urls = [
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-util-visitor/0.64.8/flexmark-util-visitor-0.64.8.jar"
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-util-visitor/0.64.8/flexmark-util-visitor-0.64.8.pom"
    ];
    hash = "sha256-ui7YSn3e66rvQQYL+sHI9JGAr1JaXpLSV9E3SgTC9Vg=";
    installPath = "https/repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-util-visitor/0.64.8";
  };

  "com.vladsch.flexmark_flexmark-youtrack-converter-0.64.8" = fetchMaven {
    name = "com.vladsch.flexmark_flexmark-youtrack-converter-0.64.8";
    urls = [
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-youtrack-converter/0.64.8/flexmark-youtrack-converter-0.64.8.jar"
      "https://repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-youtrack-converter/0.64.8/flexmark-youtrack-converter-0.64.8.pom"
    ];
    hash = "sha256-LN7CLPKCgZRDIbt6QG456qSZykEsGfAMPLuL+VtldbI=";
    installPath = "https/repo1.maven.org/maven2/com/vladsch/flexmark/flexmark-youtrack-converter/0.64.8";
  };

  "de.rototor.pdfbox_graphics2d-0.32" = fetchMaven {
    name = "de.rototor.pdfbox_graphics2d-0.32";
    urls = [
      "https://repo1.maven.org/maven2/de/rototor/pdfbox/graphics2d/0.32/graphics2d-0.32.jar"
      "https://repo1.maven.org/maven2/de/rototor/pdfbox/graphics2d/0.32/graphics2d-0.32.pom"
    ];
    hash = "sha256-FnyCH+Gp4EVeY1og2+nuUG/pNZ0FpJAqqNQxK1/OAOo=";
    installPath = "https/repo1.maven.org/maven2/de/rototor/pdfbox/graphics2d/0.32";
  };

  "de.rototor.pdfbox_pdfboxgraphics2d-parent-0.32" = fetchMaven {
    name = "de.rototor.pdfbox_pdfboxgraphics2d-parent-0.32";
    urls = [
      "https://repo1.maven.org/maven2/de/rototor/pdfbox/pdfboxgraphics2d-parent/0.32/pdfboxgraphics2d-parent-0.32.pom"
    ];
    hash = "sha256-T8C23/tDcJVUSICquql+croeT0rQuoWdi02l2XZFIDI=";
    installPath = "https/repo1.maven.org/maven2/de/rototor/pdfbox/pdfboxgraphics2d-parent/0.32";
  };

  "io.get-coursier.jniutils_windows-jni-utils-0.3.3" = fetchMaven {
    name = "io.get-coursier.jniutils_windows-jni-utils-0.3.3";
    urls = [
      "https://repo1.maven.org/maven2/io/get-coursier/jniutils/windows-jni-utils/0.3.3/windows-jni-utils-0.3.3.jar"
      "https://repo1.maven.org/maven2/io/get-coursier/jniutils/windows-jni-utils/0.3.3/windows-jni-utils-0.3.3.pom"
    ];
    hash = "sha256-OgBT8ULqeyvpNMGSmXrwpYXR4VOAlmSIMs+BejCP56c=";
    installPath = "https/repo1.maven.org/maven2/io/get-coursier/jniutils/windows-jni-utils/0.3.3";
  };

  "io.github.alexarchambault_concurrent-reference-hash-map-1.1.0" = fetchMaven {
    name = "io.github.alexarchambault_concurrent-reference-hash-map-1.1.0";
    urls = [
      "https://repo1.maven.org/maven2/io/github/alexarchambault/concurrent-reference-hash-map/1.1.0/concurrent-reference-hash-map-1.1.0.jar"
      "https://repo1.maven.org/maven2/io/github/alexarchambault/concurrent-reference-hash-map/1.1.0/concurrent-reference-hash-map-1.1.0.pom"
    ];
    hash = "sha256-949g3dbXxz773bZlkiK2Xh3XiY5Ofc+1k6i8LM6s+yI=";
    installPath = "https/repo1.maven.org/maven2/io/github/alexarchambault/concurrent-reference-hash-map/1.1.0";
  };

  "io.github.alexarchambault_data-class_2.13-0.2.7" = fetchMaven {
    name = "io.github.alexarchambault_data-class_2.13-0.2.7";
    urls = [
      "https://repo1.maven.org/maven2/io/github/alexarchambault/data-class_2.13/0.2.7/data-class_2.13-0.2.7.jar"
      "https://repo1.maven.org/maven2/io/github/alexarchambault/data-class_2.13/0.2.7/data-class_2.13-0.2.7.pom"
    ];
    hash = "sha256-PZ9by0bd2Rv4MWgWqJnmsVhQVLMaEOf7nmlfKB34JJs=";
    installPath = "https/repo1.maven.org/maven2/io/github/alexarchambault/data-class_2.13/0.2.7";
  };

  "io.github.alexarchambault_is-terminal-0.1.2" = fetchMaven {
    name = "io.github.alexarchambault_is-terminal-0.1.2";
    urls = [
      "https://repo1.maven.org/maven2/io/github/alexarchambault/is-terminal/0.1.2/is-terminal-0.1.2.jar"
      "https://repo1.maven.org/maven2/io/github/alexarchambault/is-terminal/0.1.2/is-terminal-0.1.2.pom"
    ];
    hash = "sha256-j9aW4Y/zyD4aYu2XykzfEpdGUXideUCkVTFSvtzlH48=";
    installPath = "https/repo1.maven.org/maven2/io/github/alexarchambault/is-terminal/0.1.2";
  };

  "io.github.classgraph_classgraph-4.8.184" = fetchMaven {
    name = "io.github.classgraph_classgraph-4.8.184";
    urls = [
      "https://repo1.maven.org/maven2/io/github/classgraph/classgraph/4.8.184/classgraph-4.8.184.jar"
      "https://repo1.maven.org/maven2/io/github/classgraph/classgraph/4.8.184/classgraph-4.8.184.pom"
    ];
    hash = "sha256-TexK9sAgGTT4cAEZYYyi1pq/J2XPQFHMlvzzRSs1Eok=";
    installPath = "https/repo1.maven.org/maven2/io/github/classgraph/classgraph/4.8.184";
  };

  "io.github.java-diff-utils_java-diff-utils-4.12" = fetchMaven {
    name = "io.github.java-diff-utils_java-diff-utils-4.12";
    urls = [
      "https://repo1.maven.org/maven2/io/github/java-diff-utils/java-diff-utils/4.12/java-diff-utils-4.12.jar"
      "https://repo1.maven.org/maven2/io/github/java-diff-utils/java-diff-utils/4.12/java-diff-utils-4.12.pom"
    ];
    hash = "sha256-SMNRfv+BvfxjgwFH0fHU16fd1bDn/QMrPQN8Eyb6deA=";
    installPath = "https/repo1.maven.org/maven2/io/github/java-diff-utils/java-diff-utils/4.12";
  };

  "io.github.java-diff-utils_java-diff-utils-4.15" = fetchMaven {
    name = "io.github.java-diff-utils_java-diff-utils-4.15";
    urls = [
      "https://repo1.maven.org/maven2/io/github/java-diff-utils/java-diff-utils/4.15/java-diff-utils-4.15.jar"
      "https://repo1.maven.org/maven2/io/github/java-diff-utils/java-diff-utils/4.15/java-diff-utils-4.15.pom"
    ];
    hash = "sha256-SfOhFqK/GsStfRZLQm3yGJat/CQWb3YbJnoXd84l/R0=";
    installPath = "https/repo1.maven.org/maven2/io/github/java-diff-utils/java-diff-utils/4.15";
  };

  "io.github.java-diff-utils_java-diff-utils-4.16" = fetchMaven {
    name = "io.github.java-diff-utils_java-diff-utils-4.16";
    urls = [
      "https://repo1.maven.org/maven2/io/github/java-diff-utils/java-diff-utils/4.16/java-diff-utils-4.16.jar"
      "https://repo1.maven.org/maven2/io/github/java-diff-utils/java-diff-utils/4.16/java-diff-utils-4.16.pom"
    ];
    hash = "sha256-15LUj8y+rX9dpYNtYQw85LW3IS5atH2xCbIVRyRRCAQ=";
    installPath = "https/repo1.maven.org/maven2/io/github/java-diff-utils/java-diff-utils/4.16";
  };

  "io.github.java-diff-utils_java-diff-utils-parent-4.12" = fetchMaven {
    name = "io.github.java-diff-utils_java-diff-utils-parent-4.12";
    urls = [
      "https://repo1.maven.org/maven2/io/github/java-diff-utils/java-diff-utils-parent/4.12/java-diff-utils-parent-4.12.pom"
    ];
    hash = "sha256-l9MekOAkDQrHpgMMLkbZQJtiaSmyE7h0XneiHciAFOI=";
    installPath = "https/repo1.maven.org/maven2/io/github/java-diff-utils/java-diff-utils-parent/4.12";
  };

  "io.github.java-diff-utils_java-diff-utils-parent-4.15" = fetchMaven {
    name = "io.github.java-diff-utils_java-diff-utils-parent-4.15";
    urls = [
      "https://repo1.maven.org/maven2/io/github/java-diff-utils/java-diff-utils-parent/4.15/java-diff-utils-parent-4.15.pom"
    ];
    hash = "sha256-7U+fEo0qYFash7diRi0E8Ejv0MY8T70NzU+HswbmO34=";
    installPath = "https/repo1.maven.org/maven2/io/github/java-diff-utils/java-diff-utils-parent/4.15";
  };

  "io.github.java-diff-utils_java-diff-utils-parent-4.16" = fetchMaven {
    name = "io.github.java-diff-utils_java-diff-utils-parent-4.16";
    urls = [
      "https://repo1.maven.org/maven2/io/github/java-diff-utils/java-diff-utils-parent/4.16/java-diff-utils-parent-4.16.pom"
    ];
    hash = "sha256-7JgQEqR/C4N4vRyTZ+KlsV4VmaSYEpYaG/rlDdQZGGc=";
    installPath = "https/repo1.maven.org/maven2/io/github/java-diff-utils/java-diff-utils-parent/4.16";
  };

  "io.github.json4s_json4s-ast_2.13-4.1.0" = fetchMaven {
    name = "io.github.json4s_json4s-ast_2.13-4.1.0";
    urls = [
      "https://repo1.maven.org/maven2/io/github/json4s/json4s-ast_2.13/4.1.0/json4s-ast_2.13-4.1.0.jar"
      "https://repo1.maven.org/maven2/io/github/json4s/json4s-ast_2.13/4.1.0/json4s-ast_2.13-4.1.0.pom"
    ];
    hash = "sha256-FNezjLgtHJ1MIbxi9sNWsjRkFI9j7jxZ8hdVFy8omlw=";
    installPath = "https/repo1.maven.org/maven2/io/github/json4s/json4s-ast_2.13/4.1.0";
  };

  "io.github.json4s_json4s-ast_3-4.1.0" = fetchMaven {
    name = "io.github.json4s_json4s-ast_3-4.1.0";
    urls = [
      "https://repo1.maven.org/maven2/io/github/json4s/json4s-ast_3/4.1.0/json4s-ast_3-4.1.0.jar"
      "https://repo1.maven.org/maven2/io/github/json4s/json4s-ast_3/4.1.0/json4s-ast_3-4.1.0.pom"
    ];
    hash = "sha256-jpALdFMMvyzIIzYZliz4hewALpRfffTnBH9gegAJ8CA=";
    installPath = "https/repo1.maven.org/maven2/io/github/json4s/json4s-ast_3/4.1.0";
  };

  "io.github.json4s_json4s-core_2.13-4.1.0" = fetchMaven {
    name = "io.github.json4s_json4s-core_2.13-4.1.0";
    urls = [
      "https://repo1.maven.org/maven2/io/github/json4s/json4s-core_2.13/4.1.0/json4s-core_2.13-4.1.0.jar"
      "https://repo1.maven.org/maven2/io/github/json4s/json4s-core_2.13/4.1.0/json4s-core_2.13-4.1.0.pom"
    ];
    hash = "sha256-CCBI1OyNAwA9/fCllnOo+EsGWqCtSkhWtB5VpxN1Wgo=";
    installPath = "https/repo1.maven.org/maven2/io/github/json4s/json4s-core_2.13/4.1.0";
  };

  "io.github.json4s_json4s-core_3-4.1.0" = fetchMaven {
    name = "io.github.json4s_json4s-core_3-4.1.0";
    urls = [
      "https://repo1.maven.org/maven2/io/github/json4s/json4s-core_3/4.1.0/json4s-core_3-4.1.0.jar"
      "https://repo1.maven.org/maven2/io/github/json4s/json4s-core_3/4.1.0/json4s-core_3-4.1.0.pom"
    ];
    hash = "sha256-L7KcsiaWcSKkzZ64pGIBrb9+YOwUDu5kHHYy3OjMavI=";
    installPath = "https/repo1.maven.org/maven2/io/github/json4s/json4s-core_3/4.1.0";
  };

  "io.github.json4s_json4s-native-core_2.13-4.1.0" = fetchMaven {
    name = "io.github.json4s_json4s-native-core_2.13-4.1.0";
    urls = [
      "https://repo1.maven.org/maven2/io/github/json4s/json4s-native-core_2.13/4.1.0/json4s-native-core_2.13-4.1.0.jar"
      "https://repo1.maven.org/maven2/io/github/json4s/json4s-native-core_2.13/4.1.0/json4s-native-core_2.13-4.1.0.pom"
    ];
    hash = "sha256-JaWdzmnggpBEJZxYyRfChNSwnvOPaHKSE+2gwufbQcg=";
    installPath = "https/repo1.maven.org/maven2/io/github/json4s/json4s-native-core_2.13/4.1.0";
  };

  "io.github.json4s_json4s-native-core_3-4.1.0" = fetchMaven {
    name = "io.github.json4s_json4s-native-core_3-4.1.0";
    urls = [
      "https://repo1.maven.org/maven2/io/github/json4s/json4s-native-core_3/4.1.0/json4s-native-core_3-4.1.0.jar"
      "https://repo1.maven.org/maven2/io/github/json4s/json4s-native-core_3/4.1.0/json4s-native-core_3-4.1.0.pom"
    ];
    hash = "sha256-PCPj3yMkHXHISPdTPtPyRLzwmjVgcAjAeTuer/BrXqU=";
    installPath = "https/repo1.maven.org/maven2/io/github/json4s/json4s-native-core_3/4.1.0";
  };

  "io.github.json4s_json4s-native_2.13-4.1.0" = fetchMaven {
    name = "io.github.json4s_json4s-native_2.13-4.1.0";
    urls = [
      "https://repo1.maven.org/maven2/io/github/json4s/json4s-native_2.13/4.1.0/json4s-native_2.13-4.1.0.jar"
      "https://repo1.maven.org/maven2/io/github/json4s/json4s-native_2.13/4.1.0/json4s-native_2.13-4.1.0.pom"
    ];
    hash = "sha256-7jD21JvMj201F7KVGzN7Zo3XmreD9C3nccov0EEK/ok=";
    installPath = "https/repo1.maven.org/maven2/io/github/json4s/json4s-native_2.13/4.1.0";
  };

  "io.github.json4s_json4s-native_3-4.1.0" = fetchMaven {
    name = "io.github.json4s_json4s-native_3-4.1.0";
    urls = [
      "https://repo1.maven.org/maven2/io/github/json4s/json4s-native_3/4.1.0/json4s-native_3-4.1.0.jar"
      "https://repo1.maven.org/maven2/io/github/json4s/json4s-native_3/4.1.0/json4s-native_3-4.1.0.pom"
    ];
    hash = "sha256-02hAUvlcS8ryt+SZ6r2Fqbk0bSjvYR5RBZNDLj/kcUM=";
    installPath = "https/repo1.maven.org/maven2/io/github/json4s/json4s-native_3/4.1.0";
  };

  "io.github.json4s_json4s-scalap_2.13-4.1.0" = fetchMaven {
    name = "io.github.json4s_json4s-scalap_2.13-4.1.0";
    urls = [
      "https://repo1.maven.org/maven2/io/github/json4s/json4s-scalap_2.13/4.1.0/json4s-scalap_2.13-4.1.0.jar"
      "https://repo1.maven.org/maven2/io/github/json4s/json4s-scalap_2.13/4.1.0/json4s-scalap_2.13-4.1.0.pom"
    ];
    hash = "sha256-GsrgLA9CycN4MIXSVO07IYhyD4nvIt/s0vMRkpd/NXM=";
    installPath = "https/repo1.maven.org/maven2/io/github/json4s/json4s-scalap_2.13/4.1.0";
  };

  "net.sf.jopt-simple_jopt-simple-5.0.4" = fetchMaven {
    name = "net.sf.jopt-simple_jopt-simple-5.0.4";
    urls = [
      "https://repo1.maven.org/maven2/net/sf/jopt-simple/jopt-simple/5.0.4/jopt-simple-5.0.4.jar"
      "https://repo1.maven.org/maven2/net/sf/jopt-simple/jopt-simple/5.0.4/jopt-simple-5.0.4.pom"
    ];
    hash = "sha256-/l4TgZ+p8AP432PBNvhoHUw7VjAHgsP7PBKjYnqxFB0=";
    installPath = "https/repo1.maven.org/maven2/net/sf/jopt-simple/jopt-simple/5.0.4";
  };

  "org.apache.commons_commons-compress-1.28.0" = fetchMaven {
    name = "org.apache.commons_commons-compress-1.28.0";
    urls = [
      "https://repo1.maven.org/maven2/org/apache/commons/commons-compress/1.28.0/commons-compress-1.28.0.jar"
      "https://repo1.maven.org/maven2/org/apache/commons/commons-compress/1.28.0/commons-compress-1.28.0.pom"
    ];
    hash = "sha256-dT70h6cIwxdIJVO9eFn4/P1q2530bl+046ZjQ3EVGgU=";
    installPath = "https/repo1.maven.org/maven2/org/apache/commons/commons-compress/1.28.0";
  };

  "org.apache.commons_commons-lang3-3.18.0" = fetchMaven {
    name = "org.apache.commons_commons-lang3-3.18.0";
    urls = [
      "https://repo1.maven.org/maven2/org/apache/commons/commons-lang3/3.18.0/commons-lang3-3.18.0.jar"
      "https://repo1.maven.org/maven2/org/apache/commons/commons-lang3/3.18.0/commons-lang3-3.18.0.pom"
    ];
    hash = "sha256-IzLzlGs2SlGRKZ+baXEo/jh3JY2oTXa5wdIl2KlBy2E=";
    installPath = "https/repo1.maven.org/maven2/org/apache/commons/commons-lang3/3.18.0";
  };

  "org.apache.commons_commons-lang3-3.8.1" = fetchMaven {
    name = "org.apache.commons_commons-lang3-3.8.1";
    urls = [
      "https://repo1.maven.org/maven2/org/apache/commons/commons-lang3/3.8.1/commons-lang3-3.8.1.pom"
    ];
    hash = "sha256-sRwL9YM4DOzOxwPnBOgJyanP0m39AKrpy4hbtdM12q0=";
    installPath = "https/repo1.maven.org/maven2/org/apache/commons/commons-lang3/3.8.1";
  };

  "org.apache.commons_commons-math3-3.6.1" = fetchMaven {
    name = "org.apache.commons_commons-math3-3.6.1";
    urls = [
      "https://repo1.maven.org/maven2/org/apache/commons/commons-math3/3.6.1/commons-math3-3.6.1.jar"
      "https://repo1.maven.org/maven2/org/apache/commons/commons-math3/3.6.1/commons-math3-3.6.1.pom"
    ];
    hash = "sha256-sqDIGsP9PknsQ5oCeL3PHftqLMZG5tWNBB6q0r6KPbc=";
    installPath = "https/repo1.maven.org/maven2/org/apache/commons/commons-math3/3.6.1";
  };

  "org.apache.commons_commons-parent-34" = fetchMaven {
    name = "org.apache.commons_commons-parent-34";
    urls = [
      "https://repo1.maven.org/maven2/org/apache/commons/commons-parent/34/commons-parent-34.pom"
    ];
    hash = "sha256-4uhgIF+JAhewPTk4Ooi+2m732h2khAjtCDELWlCkCkc=";
    installPath = "https/repo1.maven.org/maven2/org/apache/commons/commons-parent/34";
  };

  "org.apache.commons_commons-parent-39" = fetchMaven {
    name = "org.apache.commons_commons-parent-39";
    urls = [
      "https://repo1.maven.org/maven2/org/apache/commons/commons-parent/39/commons-parent-39.pom"
    ];
    hash = "sha256-13xay430GiGOMcS0VRxQl7mimf26s+wMLChdekIoyuY=";
    installPath = "https/repo1.maven.org/maven2/org/apache/commons/commons-parent/39";
  };

  "org.apache.commons_commons-parent-47" = fetchMaven {
    name = "org.apache.commons_commons-parent-47";
    urls = [
      "https://repo1.maven.org/maven2/org/apache/commons/commons-parent/47/commons-parent-47.pom"
    ];
    hash = "sha256-3nKXz/Cqz3ed8sPyeJUIYW5uQ/1nCy8N5gPATIkI9DQ=";
    installPath = "https/repo1.maven.org/maven2/org/apache/commons/commons-parent/47";
  };

  "org.apache.commons_commons-parent-58" = fetchMaven {
    name = "org.apache.commons_commons-parent-58";
    urls = [
      "https://repo1.maven.org/maven2/org/apache/commons/commons-parent/58/commons-parent-58.pom"
    ];
    hash = "sha256-2sfFGq2rn5ryC4a0ydWRF5S9y4kDg/V19+eLftdfM7s=";
    installPath = "https/repo1.maven.org/maven2/org/apache/commons/commons-parent/58";
  };

  "org.apache.commons_commons-parent-69" = fetchMaven {
    name = "org.apache.commons_commons-parent-69";
    urls = [
      "https://repo1.maven.org/maven2/org/apache/commons/commons-parent/69/commons-parent-69.pom"
    ];
    hash = "sha256-XDFSOofSIPQI87JPu4s21bhzz9SDiYXZ4rIoURJ4feI=";
    installPath = "https/repo1.maven.org/maven2/org/apache/commons/commons-parent/69";
  };

  "org.apache.commons_commons-parent-85" = fetchMaven {
    name = "org.apache.commons_commons-parent-85";
    urls = [
      "https://repo1.maven.org/maven2/org/apache/commons/commons-parent/85/commons-parent-85.pom"
    ];
    hash = "sha256-Xj15VDFcZhPE5qzqmellS3KSQJENr1wgjG5fOKbbyJA=";
    installPath = "https/repo1.maven.org/maven2/org/apache/commons/commons-parent/85";
  };

  "org.apache.commons_commons-text-1.14.0" = fetchMaven {
    name = "org.apache.commons_commons-text-1.14.0";
    urls = [
      "https://repo1.maven.org/maven2/org/apache/commons/commons-text/1.14.0/commons-text-1.14.0.jar"
      "https://repo1.maven.org/maven2/org/apache/commons/commons-text/1.14.0/commons-text-1.14.0.pom"
    ];
    hash = "sha256-w46wtbm7X3BqO12R0PTq7741SWc7QIFyPqMBB02rMto=";
    installPath = "https/repo1.maven.org/maven2/org/apache/commons/commons-text/1.14.0";
  };

  "org.apache.cxf_cxf-4.0.8" = fetchMaven {
    name = "org.apache.cxf_cxf-4.0.8";
    urls = [ "https://repo1.maven.org/maven2/org/apache/cxf/cxf/4.0.8/cxf-4.0.8.pom" ];
    hash = "sha256-EMFiaB2kPp18dxCfe5/hlgto4cSoYUS9voakCNb2Jqg=";
    installPath = "https/repo1.maven.org/maven2/org/apache/cxf/cxf/4.0.8";
  };

  "org.apache.cxf_cxf-bom-4.0.8" = fetchMaven {
    name = "org.apache.cxf_cxf-bom-4.0.8";
    urls = [ "https://repo1.maven.org/maven2/org/apache/cxf/cxf-bom/4.0.8/cxf-bom-4.0.8.pom" ];
    hash = "sha256-CW6MvHvgRSGsgcEkdPygMwfkQG+T1OmRBYfMDI38/9A=";
    installPath = "https/repo1.maven.org/maven2/org/apache/cxf/cxf-bom/4.0.8";
  };

  "org.apache.groovy_groovy-bom-4.0.27" = fetchMaven {
    name = "org.apache.groovy_groovy-bom-4.0.27";
    urls = [
      "https://repo1.maven.org/maven2/org/apache/groovy/groovy-bom/4.0.27/groovy-bom-4.0.27.pom"
    ];
    hash = "sha256-LpFKTYYoMwe70YPF1kycfpUSmm2Q+G+KtWRPny2CupQ=";
    installPath = "https/repo1.maven.org/maven2/org/apache/groovy/groovy-bom/4.0.27";
  };

  "org.apache.httpcomponents_httpclient-4.5.14" = fetchMaven {
    name = "org.apache.httpcomponents_httpclient-4.5.14";
    urls = [
      "https://repo1.maven.org/maven2/org/apache/httpcomponents/httpclient/4.5.14/httpclient-4.5.14.jar"
      "https://repo1.maven.org/maven2/org/apache/httpcomponents/httpclient/4.5.14/httpclient-4.5.14.pom"
    ];
    hash = "sha256-55zpch8AVFbKXIE2/4JYbfQorwpS9VqPaAvLxAeKXdg=";
    installPath = "https/repo1.maven.org/maven2/org/apache/httpcomponents/httpclient/4.5.14";
  };

  "org.apache.httpcomponents_httpcomponents-client-4.5.14" = fetchMaven {
    name = "org.apache.httpcomponents_httpcomponents-client-4.5.14";
    urls = [
      "https://repo1.maven.org/maven2/org/apache/httpcomponents/httpcomponents-client/4.5.14/httpcomponents-client-4.5.14.pom"
    ];
    hash = "sha256-+dqqOffWKlw1XKZAh+XtXP+SdFmr2k/9jGpjKDIau6k=";
    installPath = "https/repo1.maven.org/maven2/org/apache/httpcomponents/httpcomponents-client/4.5.14";
  };

  "org.apache.httpcomponents_httpcomponents-core-4.4.16" = fetchMaven {
    name = "org.apache.httpcomponents_httpcomponents-core-4.4.16";
    urls = [
      "https://repo1.maven.org/maven2/org/apache/httpcomponents/httpcomponents-core/4.4.16/httpcomponents-core-4.4.16.pom"
    ];
    hash = "sha256-oXXZSC8HkHnQrfmH1ZkyVvHwR2S45PXRQuQDBqth5mM=";
    installPath = "https/repo1.maven.org/maven2/org/apache/httpcomponents/httpcomponents-core/4.4.16";
  };

  "org.apache.httpcomponents_httpcomponents-parent-11" = fetchMaven {
    name = "org.apache.httpcomponents_httpcomponents-parent-11";
    urls = [
      "https://repo1.maven.org/maven2/org/apache/httpcomponents/httpcomponents-parent/11/httpcomponents-parent-11.pom"
    ];
    hash = "sha256-FD6Li7OCbNJ4Jl1OvxPwo/xfmbqFoUUZQvybGHyBpN4=";
    installPath = "https/repo1.maven.org/maven2/org/apache/httpcomponents/httpcomponents-parent/11";
  };

  "org.apache.httpcomponents_httpcore-4.4.16" = fetchMaven {
    name = "org.apache.httpcomponents_httpcore-4.4.16";
    urls = [
      "https://repo1.maven.org/maven2/org/apache/httpcomponents/httpcore/4.4.16/httpcore-4.4.16.jar"
      "https://repo1.maven.org/maven2/org/apache/httpcomponents/httpcore/4.4.16/httpcore-4.4.16.pom"
    ];
    hash = "sha256-mu7WvFsj3uIAcZyz9g8gvUq3EFOu9yNr2CbfsFP6/BQ=";
    installPath = "https/repo1.maven.org/maven2/org/apache/httpcomponents/httpcore/4.4.16";
  };

  "org.apache.maven_maven-4.0.0-alpha-12" = fetchMaven {
    name = "org.apache.maven_maven-4.0.0-alpha-12";
    urls = [
      "https://repo1.maven.org/maven2/org/apache/maven/maven/4.0.0-alpha-12/maven-4.0.0-alpha-12.pom"
    ];
    hash = "sha256-UEY7WGWEWTYUjOU1I4DWc4DadpsopHgRnk7Da8MowRE=";
    installPath = "https/repo1.maven.org/maven2/org/apache/maven/maven/4.0.0-alpha-12";
  };

  "org.apache.maven_maven-api-4.0.0-alpha-12" = fetchMaven {
    name = "org.apache.maven_maven-api-4.0.0-alpha-12";
    urls = [
      "https://repo1.maven.org/maven2/org/apache/maven/maven-api/4.0.0-alpha-12/maven-api-4.0.0-alpha-12.pom"
    ];
    hash = "sha256-MzKk5ZoshSi3wc+ZhvufNRaXuQCTyQQfm3MSGQs0SQo=";
    installPath = "https/repo1.maven.org/maven2/org/apache/maven/maven-api/4.0.0-alpha-12";
  };

  "org.apache.maven_maven-api-core-4.0.0-alpha-12" = fetchMaven {
    name = "org.apache.maven_maven-api-core-4.0.0-alpha-12";
    urls = [
      "https://repo1.maven.org/maven2/org/apache/maven/maven-api-core/4.0.0-alpha-12/maven-api-core-4.0.0-alpha-12.jar"
      "https://repo1.maven.org/maven2/org/apache/maven/maven-api-core/4.0.0-alpha-12/maven-api-core-4.0.0-alpha-12.pom"
    ];
    hash = "sha256-hKUIh2S0dlEduarFLa+kyMsEkmeuMsOr3amEXYr2P9A=";
    installPath = "https/repo1.maven.org/maven2/org/apache/maven/maven-api-core/4.0.0-alpha-12";
  };

  "org.apache.maven_maven-api-meta-4.0.0-alpha-12" = fetchMaven {
    name = "org.apache.maven_maven-api-meta-4.0.0-alpha-12";
    urls = [
      "https://repo1.maven.org/maven2/org/apache/maven/maven-api-meta/4.0.0-alpha-12/maven-api-meta-4.0.0-alpha-12.jar"
      "https://repo1.maven.org/maven2/org/apache/maven/maven-api-meta/4.0.0-alpha-12/maven-api-meta-4.0.0-alpha-12.pom"
    ];
    hash = "sha256-TrmSJvYCcOr/owk0BFQvW7xyvrPjZmH1ueJMukzhPb8=";
    installPath = "https/repo1.maven.org/maven2/org/apache/maven/maven-api-meta/4.0.0-alpha-12";
  };

  "org.apache.maven_maven-api-model-4.0.0-alpha-12" = fetchMaven {
    name = "org.apache.maven_maven-api-model-4.0.0-alpha-12";
    urls = [
      "https://repo1.maven.org/maven2/org/apache/maven/maven-api-model/4.0.0-alpha-12/maven-api-model-4.0.0-alpha-12.jar"
      "https://repo1.maven.org/maven2/org/apache/maven/maven-api-model/4.0.0-alpha-12/maven-api-model-4.0.0-alpha-12.pom"
    ];
    hash = "sha256-0SLEalO3uEbh+PsvWyMiEq0NeVWTD1Vq6LmBrap7k2U=";
    installPath = "https/repo1.maven.org/maven2/org/apache/maven/maven-api-model/4.0.0-alpha-12";
  };

  "org.apache.maven_maven-api-plugin-4.0.0-alpha-12" = fetchMaven {
    name = "org.apache.maven_maven-api-plugin-4.0.0-alpha-12";
    urls = [
      "https://repo1.maven.org/maven2/org/apache/maven/maven-api-plugin/4.0.0-alpha-12/maven-api-plugin-4.0.0-alpha-12.jar"
      "https://repo1.maven.org/maven2/org/apache/maven/maven-api-plugin/4.0.0-alpha-12/maven-api-plugin-4.0.0-alpha-12.pom"
    ];
    hash = "sha256-yW1TZsC1OiE08KZVO2l+Yki3fxvgHhdvowK9QKF/vOQ=";
    installPath = "https/repo1.maven.org/maven2/org/apache/maven/maven-api-plugin/4.0.0-alpha-12";
  };

  "org.apache.maven_maven-api-settings-4.0.0-alpha-12" = fetchMaven {
    name = "org.apache.maven_maven-api-settings-4.0.0-alpha-12";
    urls = [
      "https://repo1.maven.org/maven2/org/apache/maven/maven-api-settings/4.0.0-alpha-12/maven-api-settings-4.0.0-alpha-12.jar"
      "https://repo1.maven.org/maven2/org/apache/maven/maven-api-settings/4.0.0-alpha-12/maven-api-settings-4.0.0-alpha-12.pom"
    ];
    hash = "sha256-QtxFe3YEjA30FKIyRtohr6O4l9YrQlMaTNIBttiMtkY=";
    installPath = "https/repo1.maven.org/maven2/org/apache/maven/maven-api-settings/4.0.0-alpha-12";
  };

  "org.apache.maven_maven-api-spi-4.0.0-alpha-12" = fetchMaven {
    name = "org.apache.maven_maven-api-spi-4.0.0-alpha-12";
    urls = [
      "https://repo1.maven.org/maven2/org/apache/maven/maven-api-spi/4.0.0-alpha-12/maven-api-spi-4.0.0-alpha-12.jar"
      "https://repo1.maven.org/maven2/org/apache/maven/maven-api-spi/4.0.0-alpha-12/maven-api-spi-4.0.0-alpha-12.pom"
    ];
    hash = "sha256-FGbbGJy7om1ieQKqYOBgdWcugEXeW68x5UGCocs9zp4=";
    installPath = "https/repo1.maven.org/maven2/org/apache/maven/maven-api-spi/4.0.0-alpha-12";
  };

  "org.apache.maven_maven-api-toolchain-4.0.0-alpha-12" = fetchMaven {
    name = "org.apache.maven_maven-api-toolchain-4.0.0-alpha-12";
    urls = [
      "https://repo1.maven.org/maven2/org/apache/maven/maven-api-toolchain/4.0.0-alpha-12/maven-api-toolchain-4.0.0-alpha-12.jar"
      "https://repo1.maven.org/maven2/org/apache/maven/maven-api-toolchain/4.0.0-alpha-12/maven-api-toolchain-4.0.0-alpha-12.pom"
    ];
    hash = "sha256-QkwVMiNGpz8lTjn6npQa1RHa+9JeKYkx4PhLCK7khYw=";
    installPath = "https/repo1.maven.org/maven2/org/apache/maven/maven-api-toolchain/4.0.0-alpha-12";
  };

  "org.apache.maven_maven-api-xml-4.0.0-alpha-12" = fetchMaven {
    name = "org.apache.maven_maven-api-xml-4.0.0-alpha-12";
    urls = [
      "https://repo1.maven.org/maven2/org/apache/maven/maven-api-xml/4.0.0-alpha-12/maven-api-xml-4.0.0-alpha-12.jar"
      "https://repo1.maven.org/maven2/org/apache/maven/maven-api-xml/4.0.0-alpha-12/maven-api-xml-4.0.0-alpha-12.pom"
    ];
    hash = "sha256-CubyhDptPTkZ/S3r3yQAmQJyerUAe5BR+9/QbYvlaa8=";
    installPath = "https/repo1.maven.org/maven2/org/apache/maven/maven-api-xml/4.0.0-alpha-12";
  };

  "org.apache.maven_maven-builder-support-4.0.0-alpha-12" = fetchMaven {
    name = "org.apache.maven_maven-builder-support-4.0.0-alpha-12";
    urls = [
      "https://repo1.maven.org/maven2/org/apache/maven/maven-builder-support/4.0.0-alpha-12/maven-builder-support-4.0.0-alpha-12.jar"
      "https://repo1.maven.org/maven2/org/apache/maven/maven-builder-support/4.0.0-alpha-12/maven-builder-support-4.0.0-alpha-12.pom"
    ];
    hash = "sha256-koZBG6hsBbsjvKEMWfSrZxUuM2zhJzhZFxP0bSyYgCE=";
    installPath = "https/repo1.maven.org/maven2/org/apache/maven/maven-builder-support/4.0.0-alpha-12";
  };

  "org.apache.maven_maven-model-4.0.0-alpha-12" = fetchMaven {
    name = "org.apache.maven_maven-model-4.0.0-alpha-12";
    urls = [
      "https://repo1.maven.org/maven2/org/apache/maven/maven-model/4.0.0-alpha-12/maven-model-4.0.0-alpha-12.jar"
      "https://repo1.maven.org/maven2/org/apache/maven/maven-model/4.0.0-alpha-12/maven-model-4.0.0-alpha-12.pom"
    ];
    hash = "sha256-p42jogqqW8paKltRYYqnXQ1GN6QHH677ThjjlvPCRDY=";
    installPath = "https/repo1.maven.org/maven2/org/apache/maven/maven-model/4.0.0-alpha-12";
  };

  "org.apache.maven_maven-model-builder-4.0.0-alpha-12" = fetchMaven {
    name = "org.apache.maven_maven-model-builder-4.0.0-alpha-12";
    urls = [
      "https://repo1.maven.org/maven2/org/apache/maven/maven-model-builder/4.0.0-alpha-12/maven-model-builder-4.0.0-alpha-12.jar"
      "https://repo1.maven.org/maven2/org/apache/maven/maven-model-builder/4.0.0-alpha-12/maven-model-builder-4.0.0-alpha-12.pom"
    ];
    hash = "sha256-wT/myhzbcT0AHYrX6X6DXKaR1sCOWxInV+f/He67qRE=";
    installPath = "https/repo1.maven.org/maven2/org/apache/maven/maven-model-builder/4.0.0-alpha-12";
  };

  "org.apache.maven_maven-parent-40" = fetchMaven {
    name = "org.apache.maven_maven-parent-40";
    urls = [ "https://repo1.maven.org/maven2/org/apache/maven/maven-parent/40/maven-parent-40.pom" ];
    hash = "sha256-rPZYAfC3gBjjBM/1wE7r4SxLQNzCaHPxaKJ+uSHqxQ4=";
    installPath = "https/repo1.maven.org/maven2/org/apache/maven/maven-parent/40";
  };

  "org.apache.maven_maven-parent-41" = fetchMaven {
    name = "org.apache.maven_maven-parent-41";
    urls = [ "https://repo1.maven.org/maven2/org/apache/maven/maven-parent/41/maven-parent-41.pom" ];
    hash = "sha256-TT0jqnf/TqRqzJO0KWxw4/FGHGpp5FEY5KweH12TFlQ=";
    installPath = "https/repo1.maven.org/maven2/org/apache/maven/maven-parent/41";
  };

  "org.apache.maven_maven-parent-45" = fetchMaven {
    name = "org.apache.maven_maven-parent-45";
    urls = [ "https://repo1.maven.org/maven2/org/apache/maven/maven-parent/45/maven-parent-45.pom" ];
    hash = "sha256-mOATuf387Q7QZlIKpb+h42ZB/xflJKqqOGKWtl0Kv90=";
    installPath = "https/repo1.maven.org/maven2/org/apache/maven/maven-parent/45";
  };

  "org.apache.maven_maven-repository-metadata-4.0.0-alpha-12" = fetchMaven {
    name = "org.apache.maven_maven-repository-metadata-4.0.0-alpha-12";
    urls = [
      "https://repo1.maven.org/maven2/org/apache/maven/maven-repository-metadata/4.0.0-alpha-12/maven-repository-metadata-4.0.0-alpha-12.jar"
      "https://repo1.maven.org/maven2/org/apache/maven/maven-repository-metadata/4.0.0-alpha-12/maven-repository-metadata-4.0.0-alpha-12.pom"
    ];
    hash = "sha256-gJz5Y29eSl+8VgAnwQ6fizGioWdPtAwkmwIDO+BbXoY=";
    installPath = "https/repo1.maven.org/maven2/org/apache/maven/maven-repository-metadata/4.0.0-alpha-12";
  };

  "org.apache.maven_maven-resolver-provider-4.0.0-alpha-12" = fetchMaven {
    name = "org.apache.maven_maven-resolver-provider-4.0.0-alpha-12";
    urls = [
      "https://repo1.maven.org/maven2/org/apache/maven/maven-resolver-provider/4.0.0-alpha-12/maven-resolver-provider-4.0.0-alpha-12.jar"
      "https://repo1.maven.org/maven2/org/apache/maven/maven-resolver-provider/4.0.0-alpha-12/maven-resolver-provider-4.0.0-alpha-12.pom"
    ];
    hash = "sha256-pTFEcAgWfCLVsdJseFjsYEx2bprtZIeFQMIGz2Nx82Y=";
    installPath = "https/repo1.maven.org/maven2/org/apache/maven/maven-resolver-provider/4.0.0-alpha-12";
  };

  "org.apache.maven_maven-xml-impl-4.0.0-alpha-12" = fetchMaven {
    name = "org.apache.maven_maven-xml-impl-4.0.0-alpha-12";
    urls = [
      "https://repo1.maven.org/maven2/org/apache/maven/maven-xml-impl/4.0.0-alpha-12/maven-xml-impl-4.0.0-alpha-12.jar"
      "https://repo1.maven.org/maven2/org/apache/maven/maven-xml-impl/4.0.0-alpha-12/maven-xml-impl-4.0.0-alpha-12.pom"
    ];
    hash = "sha256-i4cDYY2x8f1U7xW094VlyGjJHrvEYtPNhPQaPkSr750=";
    installPath = "https/repo1.maven.org/maven2/org/apache/maven/maven-xml-impl/4.0.0-alpha-12";
  };

  "org.apache.pdfbox_fontbox-2.0.24" = fetchMaven {
    name = "org.apache.pdfbox_fontbox-2.0.24";
    urls = [
      "https://repo1.maven.org/maven2/org/apache/pdfbox/fontbox/2.0.24/fontbox-2.0.24.jar"
      "https://repo1.maven.org/maven2/org/apache/pdfbox/fontbox/2.0.24/fontbox-2.0.24.pom"
    ];
    hash = "sha256-cuUQSLL9pFUKbLSmi56cJjBSp7AEOHq6LJOtbcAeNRs=";
    installPath = "https/repo1.maven.org/maven2/org/apache/pdfbox/fontbox/2.0.24";
  };

  "org.apache.pdfbox_pdfbox-2.0.24" = fetchMaven {
    name = "org.apache.pdfbox_pdfbox-2.0.24";
    urls = [
      "https://repo1.maven.org/maven2/org/apache/pdfbox/pdfbox/2.0.24/pdfbox-2.0.24.jar"
      "https://repo1.maven.org/maven2/org/apache/pdfbox/pdfbox/2.0.24/pdfbox-2.0.24.pom"
    ];
    hash = "sha256-guOQxczlj6ICcJbTOOFRCyAX/5TGjut4RIaLDLjKeEI=";
    installPath = "https/repo1.maven.org/maven2/org/apache/pdfbox/pdfbox/2.0.24";
  };

  "org.apache.pdfbox_pdfbox-parent-2.0.24" = fetchMaven {
    name = "org.apache.pdfbox_pdfbox-parent-2.0.24";
    urls = [
      "https://repo1.maven.org/maven2/org/apache/pdfbox/pdfbox-parent/2.0.24/pdfbox-parent-2.0.24.pom"
    ];
    hash = "sha256-/SfCH4zCIlX1+GFvfZx5F/4STtkBlbIxbvCcg5Ys+h0=";
    installPath = "https/repo1.maven.org/maven2/org/apache/pdfbox/pdfbox-parent/2.0.24";
  };

  "org.apache.pdfbox_xmpbox-2.0.24" = fetchMaven {
    name = "org.apache.pdfbox_xmpbox-2.0.24";
    urls = [
      "https://repo1.maven.org/maven2/org/apache/pdfbox/xmpbox/2.0.24/xmpbox-2.0.24.jar"
      "https://repo1.maven.org/maven2/org/apache/pdfbox/xmpbox/2.0.24/xmpbox-2.0.24.pom"
    ];
    hash = "sha256-DzuKiRs1dVnFW9j8oL/MXQx1p2pCMfdqgylz+wSCwOQ=";
    installPath = "https/repo1.maven.org/maven2/org/apache/pdfbox/xmpbox/2.0.24";
  };

  "org.apache.tika_tika-core-3.2.2" = fetchMaven {
    name = "org.apache.tika_tika-core-3.2.2";
    urls = [
      "https://repo1.maven.org/maven2/org/apache/tika/tika-core/3.2.2/tika-core-3.2.2.jar"
      "https://repo1.maven.org/maven2/org/apache/tika/tika-core/3.2.2/tika-core-3.2.2.pom"
    ];
    hash = "sha256-oBCCWweWTcI+Pxe1DoW6oME8eMHvlaYN8TSeZOs+3m4=";
    installPath = "https/repo1.maven.org/maven2/org/apache/tika/tika-core/3.2.2";
  };

  "org.apache.tika_tika-parent-3.2.2" = fetchMaven {
    name = "org.apache.tika_tika-parent-3.2.2";
    urls = [ "https://repo1.maven.org/maven2/org/apache/tika/tika-parent/3.2.2/tika-parent-3.2.2.pom" ];
    hash = "sha256-0r34rBuw+UCBfIBbxOb6icnPi7TShICFlYCG6tPRrV4=";
    installPath = "https/repo1.maven.org/maven2/org/apache/tika/tika-parent/3.2.2";
  };

  "org.apache.xbean_xbean-3.7" = fetchMaven {
    name = "org.apache.xbean_xbean-3.7";
    urls = [ "https://repo1.maven.org/maven2/org/apache/xbean/xbean/3.7/xbean-3.7.pom" ];
    hash = "sha256-7moEcdxl+B1i7xstWBlWabSFr9QLszuciySggKYvpAE=";
    installPath = "https/repo1.maven.org/maven2/org/apache/xbean/xbean/3.7";
  };

  "org.apache.xbean_xbean-reflect-3.7" = fetchMaven {
    name = "org.apache.xbean_xbean-reflect-3.7";
    urls = [
      "https://repo1.maven.org/maven2/org/apache/xbean/xbean-reflect/3.7/xbean-reflect-3.7.jar"
      "https://repo1.maven.org/maven2/org/apache/xbean/xbean-reflect/3.7/xbean-reflect-3.7.pom"
    ];
    hash = "sha256-Zp97nk/YwipUj92NnhjU5tKNXgUmPWh2zWic2FoS434=";
    installPath = "https/repo1.maven.org/maven2/org/apache/xbean/xbean-reflect/3.7";
  };

  "org.codehaus.plexus_plexus-16" = fetchMaven {
    name = "org.codehaus.plexus_plexus-16";
    urls = [ "https://repo1.maven.org/maven2/org/codehaus/plexus/plexus/16/plexus-16.pom" ];
    hash = "sha256-fIl1IAqHDxqC/64NXN+0OBRg4v/536Qo60amvc9AotY=";
    installPath = "https/repo1.maven.org/maven2/org/codehaus/plexus/plexus/16";
  };

  "org.codehaus.plexus_plexus-18" = fetchMaven {
    name = "org.codehaus.plexus_plexus-18";
    urls = [ "https://repo1.maven.org/maven2/org/codehaus/plexus/plexus/18/plexus-18.pom" ];
    hash = "sha256-MW5t8h+IK6i4Gm58Lz3ucsEXD1GRupWWNKcizh2Osr0=";
    installPath = "https/repo1.maven.org/maven2/org/codehaus/plexus/plexus/18";
  };

  "org.codehaus.plexus_plexus-23" = fetchMaven {
    name = "org.codehaus.plexus_plexus-23";
    urls = [ "https://repo1.maven.org/maven2/org/codehaus/plexus/plexus/23/plexus-23.pom" ];
    hash = "sha256-hfuOp5V1JkqkgUp/MenShYhqaWO0rreRYZR1zYo0SHI=";
    installPath = "https/repo1.maven.org/maven2/org/codehaus/plexus/plexus/23";
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

  "org.codehaus.plexus_plexus-archiver-4.10.1" = fetchMaven {
    name = "org.codehaus.plexus_plexus-archiver-4.10.1";
    urls = [
      "https://repo1.maven.org/maven2/org/codehaus/plexus/plexus-archiver/4.10.1/plexus-archiver-4.10.1.jar"
      "https://repo1.maven.org/maven2/org/codehaus/plexus/plexus-archiver/4.10.1/plexus-archiver-4.10.1.pom"
    ];
    hash = "sha256-L/etOVVp6XR3CvYhKP+fhEkMLh46agHsHdoQ76HO96M=";
    installPath = "https/repo1.maven.org/maven2/org/codehaus/plexus/plexus-archiver/4.10.1";
  };

  "org.codehaus.plexus_plexus-classworlds-2.6.0" = fetchMaven {
    name = "org.codehaus.plexus_plexus-classworlds-2.6.0";
    urls = [
      "https://repo1.maven.org/maven2/org/codehaus/plexus/plexus-classworlds/2.6.0/plexus-classworlds-2.6.0.jar"
      "https://repo1.maven.org/maven2/org/codehaus/plexus/plexus-classworlds/2.6.0/plexus-classworlds-2.6.0.pom"
    ];
    hash = "sha256-vh7/TKxdcZVxXljM5MLGppoP0Bc28QyI/WsrPc6XSEA=";
    installPath = "https/repo1.maven.org/maven2/org/codehaus/plexus/plexus-classworlds/2.6.0";
  };

  "org.codehaus.plexus_plexus-container-default-2.1.1" = fetchMaven {
    name = "org.codehaus.plexus_plexus-container-default-2.1.1";
    urls = [
      "https://repo1.maven.org/maven2/org/codehaus/plexus/plexus-container-default/2.1.1/plexus-container-default-2.1.1.jar"
      "https://repo1.maven.org/maven2/org/codehaus/plexus/plexus-container-default/2.1.1/plexus-container-default-2.1.1.pom"
    ];
    hash = "sha256-E0Dt5DQRVlxg8fddMJZpvhU5cfNwB9MJTi/GJ1PVt3A=";
    installPath = "https/repo1.maven.org/maven2/org/codehaus/plexus/plexus-container-default/2.1.1";
  };

  "org.codehaus.plexus_plexus-containers-2.1.1" = fetchMaven {
    name = "org.codehaus.plexus_plexus-containers-2.1.1";
    urls = [
      "https://repo1.maven.org/maven2/org/codehaus/plexus/plexus-containers/2.1.1/plexus-containers-2.1.1.pom"
    ];
    hash = "sha256-LR5FBjo4qAjwjKpHajTnuUBN7cLKbeTJRtYYc8q4FNw=";
    installPath = "https/repo1.maven.org/maven2/org/codehaus/plexus/plexus-containers/2.1.1";
  };

  "org.codehaus.plexus_plexus-interpolation-1.26" = fetchMaven {
    name = "org.codehaus.plexus_plexus-interpolation-1.26";
    urls = [
      "https://repo1.maven.org/maven2/org/codehaus/plexus/plexus-interpolation/1.26/plexus-interpolation-1.26.jar"
      "https://repo1.maven.org/maven2/org/codehaus/plexus/plexus-interpolation/1.26/plexus-interpolation-1.26.pom"
    ];
    hash = "sha256-S4ygIRTl+oiAC6C6MzktlDDQA6NZOAZM7VOErfTyTx0=";
    installPath = "https/repo1.maven.org/maven2/org/codehaus/plexus/plexus-interpolation/1.26";
  };

  "org.codehaus.plexus_plexus-io-3.5.1" = fetchMaven {
    name = "org.codehaus.plexus_plexus-io-3.5.1";
    urls = [
      "https://repo1.maven.org/maven2/org/codehaus/plexus/plexus-io/3.5.1/plexus-io-3.5.1.jar"
      "https://repo1.maven.org/maven2/org/codehaus/plexus/plexus-io/3.5.1/plexus-io-3.5.1.pom"
    ];
    hash = "sha256-v3IFzpebAB3MuOebhq2W4+qNOVYL8RLfokLiPnenDjg=";
    installPath = "https/repo1.maven.org/maven2/org/codehaus/plexus/plexus-io/3.5.1";
  };

  "org.codehaus.plexus_plexus-utils-4.0.2" = fetchMaven {
    name = "org.codehaus.plexus_plexus-utils-4.0.2";
    urls = [
      "https://repo1.maven.org/maven2/org/codehaus/plexus/plexus-utils/4.0.2/plexus-utils-4.0.2.jar"
      "https://repo1.maven.org/maven2/org/codehaus/plexus/plexus-utils/4.0.2/plexus-utils-4.0.2.pom"
    ];
    hash = "sha256-MVSJkxMgT9VJmYVXcxFx6eh4qYt0xwErey0uxIlYz9Q=";
    installPath = "https/repo1.maven.org/maven2/org/codehaus/plexus/plexus-utils/4.0.2";
  };

  "org.codehaus.plexus_plexus-xml-4.0.3" = fetchMaven {
    name = "org.codehaus.plexus_plexus-xml-4.0.3";
    urls = [
      "https://repo1.maven.org/maven2/org/codehaus/plexus/plexus-xml/4.0.3/plexus-xml-4.0.3.jar"
      "https://repo1.maven.org/maven2/org/codehaus/plexus/plexus-xml/4.0.3/plexus-xml-4.0.3.pom"
    ];
    hash = "sha256-AQAatpJoQOX0GoSUPf2G0AucPYJhxNshbKuv38F28s0=";
    installPath = "https/repo1.maven.org/maven2/org/codehaus/plexus/plexus-xml/4.0.3";
  };

  "org.codehaus.woodstox_stax2-api-4.2.1" = fetchMaven {
    name = "org.codehaus.woodstox_stax2-api-4.2.1";
    urls = [
      "https://repo1.maven.org/maven2/org/codehaus/woodstox/stax2-api/4.2.1/stax2-api-4.2.1.jar"
      "https://repo1.maven.org/maven2/org/codehaus/woodstox/stax2-api/4.2.1/stax2-api-4.2.1.pom"
    ];
    hash = "sha256-A+ESTOq1CZ6zfSR7QybErw/iIbDhBVaE6YaVALzUvfA=";
    installPath = "https/repo1.maven.org/maven2/org/codehaus/woodstox/stax2-api/4.2.1";
  };

  "org.eclipse.ee4j_project-1.0.6" = fetchMaven {
    name = "org.eclipse.ee4j_project-1.0.6";
    urls = [ "https://repo1.maven.org/maven2/org/eclipse/ee4j/project/1.0.6/project-1.0.6.pom" ];
    hash = "sha256-YppoNcfuYeqIc0xAX4a66cc5qtP8pi9rHHGF+mscbtc=";
    installPath = "https/repo1.maven.org/maven2/org/eclipse/ee4j/project/1.0.6";
  };

  "org.eclipse.ee4j_project-1.0.7" = fetchMaven {
    name = "org.eclipse.ee4j_project-1.0.7";
    urls = [ "https://repo1.maven.org/maven2/org/eclipse/ee4j/project/1.0.7/project-1.0.7.pom" ];
    hash = "sha256-1HxZiJ0aeo1n8AWjwGKEoPwVFP9kndMBye7xwgYEal8=";
    installPath = "https/repo1.maven.org/maven2/org/eclipse/ee4j/project/1.0.7";
  };

  "org.eclipse.jetty_jetty-bom-10.0.20" = fetchMaven {
    name = "org.eclipse.jetty_jetty-bom-10.0.20";
    urls = [
      "https://repo1.maven.org/maven2/org/eclipse/jetty/jetty-bom/10.0.20/jetty-bom-10.0.20.pom"
    ];
    hash = "sha256-lkjM2F2M+hB8xzp8+0G7aadIb0dMIj6Giara0yMAd7s=";
    installPath = "https/repo1.maven.org/maven2/org/eclipse/jetty/jetty-bom/10.0.20";
  };

  "org.eclipse.jetty_jetty-bom-10.0.25" = fetchMaven {
    name = "org.eclipse.jetty_jetty-bom-10.0.25";
    urls = [
      "https://repo1.maven.org/maven2/org/eclipse/jetty/jetty-bom/10.0.25/jetty-bom-10.0.25.pom"
    ];
    hash = "sha256-ctFcTObwWmx0vtOhVp4fXFoUuehQU2+5PsjF9jRXl3Q=";
    installPath = "https/repo1.maven.org/maven2/org/eclipse/jetty/jetty-bom/10.0.25";
  };

  "org.eclipse.jetty_jetty-bom-11.0.25" = fetchMaven {
    name = "org.eclipse.jetty_jetty-bom-11.0.25";
    urls = [
      "https://repo1.maven.org/maven2/org/eclipse/jetty/jetty-bom/11.0.25/jetty-bom-11.0.25.pom"
    ];
    hash = "sha256-bhzFoom7RMwyP2fnXZT4JaUb2SiDvSX/5BNOmoK5e70=";
    installPath = "https/repo1.maven.org/maven2/org/eclipse/jetty/jetty-bom/11.0.25";
  };

  "org.eclipse.jgit_org.eclipse.jgit-6.10.1.202505221210-r" = fetchMaven {
    name = "org.eclipse.jgit_org.eclipse.jgit-6.10.1.202505221210-r";
    urls = [
      "https://repo1.maven.org/maven2/org/eclipse/jgit/org.eclipse.jgit/6.10.1.202505221210-r/org.eclipse.jgit-6.10.1.202505221210-r.jar"
      "https://repo1.maven.org/maven2/org/eclipse/jgit/org.eclipse.jgit/6.10.1.202505221210-r/org.eclipse.jgit-6.10.1.202505221210-r.pom"
    ];
    hash = "sha256-3ijBX3433YFfGKNC9IVIw1lk8kgyHNcIxtYVrqSJxec=";
    installPath = "https/repo1.maven.org/maven2/org/eclipse/jgit/org.eclipse.jgit/6.10.1.202505221210-r";
  };

  "org.eclipse.jgit_org.eclipse.jgit-parent-6.10.1.202505221210-r" = fetchMaven {
    name = "org.eclipse.jgit_org.eclipse.jgit-parent-6.10.1.202505221210-r";
    urls = [
      "https://repo1.maven.org/maven2/org/eclipse/jgit/org.eclipse.jgit-parent/6.10.1.202505221210-r/org.eclipse.jgit-parent-6.10.1.202505221210-r.pom"
    ];
    hash = "sha256-rOXXAD10TWwE+xnSTNenN1lwS8e14eJzxT+cPa1yq6c=";
    installPath = "https/repo1.maven.org/maven2/org/eclipse/jgit/org.eclipse.jgit-parent/6.10.1.202505221210-r";
  };

  "org.eclipse.lsp4j_org.eclipse.lsp4j.generator-0.20.1" = fetchMaven {
    name = "org.eclipse.lsp4j_org.eclipse.lsp4j.generator-0.20.1";
    urls = [
      "https://repo1.maven.org/maven2/org/eclipse/lsp4j/org.eclipse.lsp4j.generator/0.20.1/org.eclipse.lsp4j.generator-0.20.1.jar"
      "https://repo1.maven.org/maven2/org/eclipse/lsp4j/org.eclipse.lsp4j.generator/0.20.1/org.eclipse.lsp4j.generator-0.20.1.pom"
    ];
    hash = "sha256-YihOE4ZIhHUljdpQd9FATS7AzAkRiATjJz4r4IhsBOs=";
    installPath = "https/repo1.maven.org/maven2/org/eclipse/lsp4j/org.eclipse.lsp4j.generator/0.20.1";
  };

  "org.eclipse.lsp4j_org.eclipse.lsp4j.jsonrpc-0.20.1" = fetchMaven {
    name = "org.eclipse.lsp4j_org.eclipse.lsp4j.jsonrpc-0.20.1";
    urls = [
      "https://repo1.maven.org/maven2/org/eclipse/lsp4j/org.eclipse.lsp4j.jsonrpc/0.20.1/org.eclipse.lsp4j.jsonrpc-0.20.1.jar"
      "https://repo1.maven.org/maven2/org/eclipse/lsp4j/org.eclipse.lsp4j.jsonrpc/0.20.1/org.eclipse.lsp4j.jsonrpc-0.20.1.pom"
    ];
    hash = "sha256-lLLBglY2iO5Xm7gfaKHb95jm7Yd2tKI+RUlVIqKSx5U=";
    installPath = "https/repo1.maven.org/maven2/org/eclipse/lsp4j/org.eclipse.lsp4j.jsonrpc/0.20.1";
  };

  "org.eclipse.xtend_org.eclipse.xtend.lib-2.28.0" = fetchMaven {
    name = "org.eclipse.xtend_org.eclipse.xtend.lib-2.28.0";
    urls = [
      "https://repo1.maven.org/maven2/org/eclipse/xtend/org.eclipse.xtend.lib/2.28.0/org.eclipse.xtend.lib-2.28.0.jar"
      "https://repo1.maven.org/maven2/org/eclipse/xtend/org.eclipse.xtend.lib/2.28.0/org.eclipse.xtend.lib-2.28.0.pom"
    ];
    hash = "sha256-ch5uYaECYGox+AL4EU0OC614gqTK/IkWmlxCW+FYusU=";
    installPath = "https/repo1.maven.org/maven2/org/eclipse/xtend/org.eclipse.xtend.lib/2.28.0";
  };

  "org.eclipse.xtend_org.eclipse.xtend.lib.macro-2.28.0" = fetchMaven {
    name = "org.eclipse.xtend_org.eclipse.xtend.lib.macro-2.28.0";
    urls = [
      "https://repo1.maven.org/maven2/org/eclipse/xtend/org.eclipse.xtend.lib.macro/2.28.0/org.eclipse.xtend.lib.macro-2.28.0.jar"
      "https://repo1.maven.org/maven2/org/eclipse/xtend/org.eclipse.xtend.lib.macro/2.28.0/org.eclipse.xtend.lib.macro-2.28.0.pom"
    ];
    hash = "sha256-xu5Ogojl3XzSTfETwsFodjvZydpdi2jZXY9wu5zMyOQ=";
    installPath = "https/repo1.maven.org/maven2/org/eclipse/xtend/org.eclipse.xtend.lib.macro/2.28.0";
  };

  "org.eclipse.xtext_org.eclipse.xtext.xbase.lib-2.28.0" = fetchMaven {
    name = "org.eclipse.xtext_org.eclipse.xtext.xbase.lib-2.28.0";
    urls = [
      "https://repo1.maven.org/maven2/org/eclipse/xtext/org.eclipse.xtext.xbase.lib/2.28.0/org.eclipse.xtext.xbase.lib-2.28.0.jar"
      "https://repo1.maven.org/maven2/org/eclipse/xtext/org.eclipse.xtext.xbase.lib/2.28.0/org.eclipse.xtext.xbase.lib-2.28.0.pom"
    ];
    hash = "sha256-J9fEh2WXIT3xrhzNQZBoYphh2DUrkas0wpJPWhWRvbI=";
    installPath = "https/repo1.maven.org/maven2/org/eclipse/xtext/org.eclipse.xtext.xbase.lib/2.28.0";
  };

  "org.eclipse.xtext_xtext-dev-bom-2.28.0" = fetchMaven {
    name = "org.eclipse.xtext_xtext-dev-bom-2.28.0";
    urls = [
      "https://repo1.maven.org/maven2/org/eclipse/xtext/xtext-dev-bom/2.28.0/xtext-dev-bom-2.28.0.pom"
    ];
    hash = "sha256-g4xSwbZW3JjZV+BF16ohvZ+v3o7JkVkv5CsiKT6ixVY=";
    installPath = "https/repo1.maven.org/maven2/org/eclipse/xtext/xtext-dev-bom/2.28.0";
  };

  "org.fusesource.jansi_jansi-2.4.1" = fetchMaven {
    name = "org.fusesource.jansi_jansi-2.4.1";
    urls = [
      "https://repo1.maven.org/maven2/org/fusesource/jansi/jansi/2.4.1/jansi-2.4.1.jar"
      "https://repo1.maven.org/maven2/org/fusesource/jansi/jansi/2.4.1/jansi-2.4.1.pom"
    ];
    hash = "sha256-M9G+H9TA5eB6NwlBmDP0ghxZzjbvLimPXNRZHyxJXac=";
    installPath = "https/repo1.maven.org/maven2/org/fusesource/jansi/jansi/2.4.1";
  };

  "org.jboss.logging_jboss-logging-3.4.1.Final" = fetchMaven {
    name = "org.jboss.logging_jboss-logging-3.4.1.Final";
    urls = [
      "https://repo1.maven.org/maven2/org/jboss/logging/jboss-logging/3.4.1.Final/jboss-logging-3.4.1.Final.pom"
    ];
    hash = "sha256-g+WbzY4Tia4lIUqhWxfJCNGaOzi0Pr95TmCChsoPZlg=";
    installPath = "https/repo1.maven.org/maven2/org/jboss/logging/jboss-logging/3.4.1.Final";
  };

  "org.jboss.logging_jboss-logging-3.4.3.Final" = fetchMaven {
    name = "org.jboss.logging_jboss-logging-3.4.3.Final";
    urls = [
      "https://repo1.maven.org/maven2/org/jboss/logging/jboss-logging/3.4.3.Final/jboss-logging-3.4.3.Final.jar"
      "https://repo1.maven.org/maven2/org/jboss/logging/jboss-logging/3.4.3.Final/jboss-logging-3.4.3.Final.pom"
    ];
    hash = "sha256-1ZB/2DFjnX2Em7N38ve7X9KhcKBNX3RFiUKI9nk4CII=";
    installPath = "https/repo1.maven.org/maven2/org/jboss/logging/jboss-logging/3.4.3.Final";
  };

  "org.jboss.threads_jboss-threads-3.1.0.Final" = fetchMaven {
    name = "org.jboss.threads_jboss-threads-3.1.0.Final";
    urls = [
      "https://repo1.maven.org/maven2/org/jboss/threads/jboss-threads/3.1.0.Final/jboss-threads-3.1.0.Final.jar"
      "https://repo1.maven.org/maven2/org/jboss/threads/jboss-threads/3.1.0.Final/jboss-threads-3.1.0.Final.pom"
    ];
    hash = "sha256-pv+dRK27px5papyth5tDQxKhP6KKsRzwrbEoVxiaE14=";
    installPath = "https/repo1.maven.org/maven2/org/jboss/threads/jboss-threads/3.1.0.Final";
  };

  "org.jboss.xnio_xnio-all-3.8.16.Final" = fetchMaven {
    name = "org.jboss.xnio_xnio-all-3.8.16.Final";
    urls = [
      "https://repo1.maven.org/maven2/org/jboss/xnio/xnio-all/3.8.16.Final/xnio-all-3.8.16.Final.pom"
    ];
    hash = "sha256-CMpwH7HkPFYVt1392rXjjRAytnLie8i1E5Bw8semC4g=";
    installPath = "https/repo1.maven.org/maven2/org/jboss/xnio/xnio-all/3.8.16.Final";
  };

  "org.jboss.xnio_xnio-api-3.8.16.Final" = fetchMaven {
    name = "org.jboss.xnio_xnio-api-3.8.16.Final";
    urls = [
      "https://repo1.maven.org/maven2/org/jboss/xnio/xnio-api/3.8.16.Final/xnio-api-3.8.16.Final.jar"
      "https://repo1.maven.org/maven2/org/jboss/xnio/xnio-api/3.8.16.Final/xnio-api-3.8.16.Final.pom"
    ];
    hash = "sha256-+N27/kGWXVgyic7f8wQGBrWW0caZKfFMnZjO2XiuVdw=";
    installPath = "https/repo1.maven.org/maven2/org/jboss/xnio/xnio-api/3.8.16.Final";
  };

  "org.jboss.xnio_xnio-nio-3.8.16.Final" = fetchMaven {
    name = "org.jboss.xnio_xnio-nio-3.8.16.Final";
    urls = [
      "https://repo1.maven.org/maven2/org/jboss/xnio/xnio-nio/3.8.16.Final/xnio-nio-3.8.16.Final.jar"
      "https://repo1.maven.org/maven2/org/jboss/xnio/xnio-nio/3.8.16.Final/xnio-nio-3.8.16.Final.pom"
    ];
    hash = "sha256-hdLkn9qpCHBPfaiTqT3fSlZnG9JpuyZzo5e42OkIpCk=";
    installPath = "https/repo1.maven.org/maven2/org/jboss/xnio/xnio-nio/3.8.16.Final";
  };

  "org.nibor.autolink_autolink-0.6.0" = fetchMaven {
    name = "org.nibor.autolink_autolink-0.6.0";
    urls = [
      "https://repo1.maven.org/maven2/org/nibor/autolink/autolink/0.6.0/autolink-0.6.0.jar"
      "https://repo1.maven.org/maven2/org/nibor/autolink/autolink/0.6.0/autolink-0.6.0.pom"
    ];
    hash = "sha256-UyOje39E9ysUXMK3ey2jrm7S6e8EVQboYC46t+B6sdo=";
    installPath = "https/repo1.maven.org/maven2/org/nibor/autolink/autolink/0.6.0";
  };

  "org.openjdk.jmh_jmh-core-1.37" = fetchMaven {
    name = "org.openjdk.jmh_jmh-core-1.37";
    urls = [
      "https://repo1.maven.org/maven2/org/openjdk/jmh/jmh-core/1.37/jmh-core-1.37.jar"
      "https://repo1.maven.org/maven2/org/openjdk/jmh/jmh-core/1.37/jmh-core-1.37.pom"
    ];
    hash = "sha256-XfjmLTPtwJteUowBApjmp45P8wlykncXi6hBD1lupeY=";
    installPath = "https/repo1.maven.org/maven2/org/openjdk/jmh/jmh-core/1.37";
  };

  "org.openjdk.jmh_jmh-parent-1.37" = fetchMaven {
    name = "org.openjdk.jmh_jmh-parent-1.37";
    urls = [ "https://repo1.maven.org/maven2/org/openjdk/jmh/jmh-parent/1.37/jmh-parent-1.37.pom" ];
    hash = "sha256-ooKN68/Sh/Ub5/ABMHW3czGNvMgoHDIWG9a3Lkhq9yo=";
    installPath = "https/repo1.maven.org/maven2/org/openjdk/jmh/jmh-parent/1.37";
  };

  "org.ow2.asm_asm-9.8" = fetchMaven {
    name = "org.ow2.asm_asm-9.8";
    urls = [
      "https://repo1.maven.org/maven2/org/ow2/asm/asm/9.8/asm-9.8.jar"
      "https://repo1.maven.org/maven2/org/ow2/asm/asm/9.8/asm-9.8.pom"
    ];
    hash = "sha256-+veD/6/fvI/ohZYhYhoChm0qeS7TaclJO9qnsSkBUxY=";
    installPath = "https/repo1.maven.org/maven2/org/ow2/asm/asm/9.8";
  };

  "org.ow2.asm_asm-9.9" = fetchMaven {
    name = "org.ow2.asm_asm-9.9";
    urls = [
      "https://repo1.maven.org/maven2/org/ow2/asm/asm/9.9/asm-9.9.jar"
      "https://repo1.maven.org/maven2/org/ow2/asm/asm/9.9/asm-9.9.pom"
    ];
    hash = "sha256-ku4P+IVhyeSWtDWKQPfryHf92uD5lxX+B0l7nikZJDk=";
    installPath = "https/repo1.maven.org/maven2/org/ow2/asm/asm/9.9";
  };

  "org.ow2.asm_asm-commons-9.8" = fetchMaven {
    name = "org.ow2.asm_asm-commons-9.8";
    urls = [
      "https://repo1.maven.org/maven2/org/ow2/asm/asm-commons/9.8/asm-commons-9.8.jar"
      "https://repo1.maven.org/maven2/org/ow2/asm/asm-commons/9.8/asm-commons-9.8.pom"
    ];
    hash = "sha256-wsQ21wHx134MlpbT+REdvnECHkoXEGLw26aybgUqk1c=";
    installPath = "https/repo1.maven.org/maven2/org/ow2/asm/asm-commons/9.8";
  };

  "org.ow2.asm_asm-tree-9.8" = fetchMaven {
    name = "org.ow2.asm_asm-tree-9.8";
    urls = [
      "https://repo1.maven.org/maven2/org/ow2/asm/asm-tree/9.8/asm-tree-9.8.jar"
      "https://repo1.maven.org/maven2/org/ow2/asm/asm-tree/9.8/asm-tree-9.8.pom"
    ];
    hash = "sha256-ZxdFTSgXy5f+gdS/FvxW+0oyf+5+RFUm3hv7G0akkQk=";
    installPath = "https/repo1.maven.org/maven2/org/ow2/asm/asm-tree/9.8";
  };

  "org.ow2.asm_asm-tree-9.9" = fetchMaven {
    name = "org.ow2.asm_asm-tree-9.9";
    urls = [
      "https://repo1.maven.org/maven2/org/ow2/asm/asm-tree/9.9/asm-tree-9.9.jar"
      "https://repo1.maven.org/maven2/org/ow2/asm/asm-tree/9.9/asm-tree-9.9.pom"
    ];
    hash = "sha256-6JLUHdOhdVzedEy9av5/G90Xjsn8DMsnaRENHCn4vfQ=";
    installPath = "https/repo1.maven.org/maven2/org/ow2/asm/asm-tree/9.9";
  };

  "org.scala-lang.modules_scala-asm-9.6.0-scala-1" = fetchMaven {
    name = "org.scala-lang.modules_scala-asm-9.6.0-scala-1";
    urls = [
      "https://repo1.maven.org/maven2/org/scala-lang/modules/scala-asm/9.6.0-scala-1/scala-asm-9.6.0-scala-1.jar"
      "https://repo1.maven.org/maven2/org/scala-lang/modules/scala-asm/9.6.0-scala-1/scala-asm-9.6.0-scala-1.pom"
    ];
    hash = "sha256-O85WTbOphRTQU4Q4jwUyuJ+umdkPoo9VCT+EmGlqxdc=";
    installPath = "https/repo1.maven.org/maven2/org/scala-lang/modules/scala-asm/9.6.0-scala-1";
  };

  "org.scala-lang.modules_scala-asm-9.9.0-scala-1" = fetchMaven {
    name = "org.scala-lang.modules_scala-asm-9.9.0-scala-1";
    urls = [
      "https://repo1.maven.org/maven2/org/scala-lang/modules/scala-asm/9.9.0-scala-1/scala-asm-9.9.0-scala-1.jar"
      "https://repo1.maven.org/maven2/org/scala-lang/modules/scala-asm/9.9.0-scala-1/scala-asm-9.9.0-scala-1.pom"
    ];
    hash = "sha256-0zHgDkd1xWwpw896w+ayT2x7L4YmtTgA3NcObdySv3c=";
    installPath = "https/repo1.maven.org/maven2/org/scala-lang/modules/scala-asm/9.9.0-scala-1";
  };

  "org.scala-lang.modules_scala-collection-compat_2.13-2.11.0" = fetchMaven {
    name = "org.scala-lang.modules_scala-collection-compat_2.13-2.11.0";
    urls = [
      "https://repo1.maven.org/maven2/org/scala-lang/modules/scala-collection-compat_2.13/2.11.0/scala-collection-compat_2.13-2.11.0.jar"
      "https://repo1.maven.org/maven2/org/scala-lang/modules/scala-collection-compat_2.13/2.11.0/scala-collection-compat_2.13-2.11.0.pom"
    ];
    hash = "sha256-++tF6j10SwWogS7WQJHMqj7uSzo7UVjub4dDQPdogPw=";
    installPath = "https/repo1.maven.org/maven2/org/scala-lang/modules/scala-collection-compat_2.13/2.11.0";
  };

  "org.scala-lang.modules_scala-collection-compat_2.13-2.13.0" = fetchMaven {
    name = "org.scala-lang.modules_scala-collection-compat_2.13-2.13.0";
    urls = [
      "https://repo1.maven.org/maven2/org/scala-lang/modules/scala-collection-compat_2.13/2.13.0/scala-collection-compat_2.13-2.13.0.jar"
      "https://repo1.maven.org/maven2/org/scala-lang/modules/scala-collection-compat_2.13/2.13.0/scala-collection-compat_2.13-2.13.0.pom"
    ];
    hash = "sha256-aQ+I3JuE8U5GIdb4SlHbZWdPu4E/qRIoZSGMMP3g5GE=";
    installPath = "https/repo1.maven.org/maven2/org/scala-lang/modules/scala-collection-compat_2.13/2.13.0";
  };

  "org.scala-lang.modules_scala-collection-compat_3-2.12.0" = fetchMaven {
    name = "org.scala-lang.modules_scala-collection-compat_3-2.12.0";
    urls = [
      "https://repo1.maven.org/maven2/org/scala-lang/modules/scala-collection-compat_3/2.12.0/scala-collection-compat_3-2.12.0.jar"
      "https://repo1.maven.org/maven2/org/scala-lang/modules/scala-collection-compat_3/2.12.0/scala-collection-compat_3-2.12.0.pom"
    ];
    hash = "sha256-ne2PoJ4ge4ygNIDFAkpo++XaJNsiGE7gqtT7HbG4gVs=";
    installPath = "https/repo1.maven.org/maven2/org/scala-lang/modules/scala-collection-compat_3/2.12.0";
  };

  "org.scala-lang.modules_scala-parallel-collections_2.13-0.2.0" = fetchMaven {
    name = "org.scala-lang.modules_scala-parallel-collections_2.13-0.2.0";
    urls = [
      "https://repo1.maven.org/maven2/org/scala-lang/modules/scala-parallel-collections_2.13/0.2.0/scala-parallel-collections_2.13-0.2.0.jar"
      "https://repo1.maven.org/maven2/org/scala-lang/modules/scala-parallel-collections_2.13/0.2.0/scala-parallel-collections_2.13-0.2.0.pom"
    ];
    hash = "sha256-chqRhtzyMJjeR4ohA5YhNjGV8kLHTy5yZjNCyYIO/wo=";
    installPath = "https/repo1.maven.org/maven2/org/scala-lang/modules/scala-parallel-collections_2.13/0.2.0";
  };

  "org.scala-lang.modules_scala-parallel-collections_3-1.2.0" = fetchMaven {
    name = "org.scala-lang.modules_scala-parallel-collections_3-1.2.0";
    urls = [
      "https://repo1.maven.org/maven2/org/scala-lang/modules/scala-parallel-collections_3/1.2.0/scala-parallel-collections_3-1.2.0.jar"
      "https://repo1.maven.org/maven2/org/scala-lang/modules/scala-parallel-collections_3/1.2.0/scala-parallel-collections_3-1.2.0.pom"
    ];
    hash = "sha256-v1k+cav2Bl/xAhvOy6AxlyMjbcLH1wI2/2Cd/M6uFyY=";
    installPath = "https/repo1.maven.org/maven2/org/scala-lang/modules/scala-parallel-collections_3/1.2.0";
  };

  "org.scala-lang.modules_scala-parser-combinators_2.13-1.1.2" = fetchMaven {
    name = "org.scala-lang.modules_scala-parser-combinators_2.13-1.1.2";
    urls = [
      "https://repo1.maven.org/maven2/org/scala-lang/modules/scala-parser-combinators_2.13/1.1.2/scala-parser-combinators_2.13-1.1.2.jar"
      "https://repo1.maven.org/maven2/org/scala-lang/modules/scala-parser-combinators_2.13/1.1.2/scala-parser-combinators_2.13-1.1.2.pom"
    ];
    hash = "sha256-sM5GWZ8/K1Jchj4V3FTvaWhfSJiHq0PKtQpd5W94Hps=";
    installPath = "https/repo1.maven.org/maven2/org/scala-lang/modules/scala-parser-combinators_2.13/1.1.2";
  };

  "org.scala-lang.modules_scala-xml_2.13-2.1.0" = fetchMaven {
    name = "org.scala-lang.modules_scala-xml_2.13-2.1.0";
    urls = [
      "https://repo1.maven.org/maven2/org/scala-lang/modules/scala-xml_2.13/2.1.0/scala-xml_2.13-2.1.0.jar"
      "https://repo1.maven.org/maven2/org/scala-lang/modules/scala-xml_2.13/2.1.0/scala-xml_2.13-2.1.0.pom"
    ];
    hash = "sha256-CYRcBgRmprVNrgpZ5OB8pJN00UwmQnc6vNftX4Z4EqE=";
    installPath = "https/repo1.maven.org/maven2/org/scala-lang/modules/scala-xml_2.13/2.1.0";
  };

  "org.scala-lang.modules_scala-xml_2.13-2.2.0" = fetchMaven {
    name = "org.scala-lang.modules_scala-xml_2.13-2.2.0";
    urls = [
      "https://repo1.maven.org/maven2/org/scala-lang/modules/scala-xml_2.13/2.2.0/scala-xml_2.13-2.2.0.jar"
      "https://repo1.maven.org/maven2/org/scala-lang/modules/scala-xml_2.13/2.2.0/scala-xml_2.13-2.2.0.pom"
    ];
    hash = "sha256-Vy0piitgB2wPXiORd+dcBEZVcMZSjcbKJz4lNKZgeec=";
    installPath = "https/repo1.maven.org/maven2/org/scala-lang/modules/scala-xml_2.13/2.2.0";
  };

  "org.scala-lang.modules_scala-xml_2.13-2.3.0" = fetchMaven {
    name = "org.scala-lang.modules_scala-xml_2.13-2.3.0";
    urls = [
      "https://repo1.maven.org/maven2/org/scala-lang/modules/scala-xml_2.13/2.3.0/scala-xml_2.13-2.3.0.pom"
    ];
    hash = "sha256-iNqwOkHXWBRjYrwxRybKJ4smqgmx8iNgjr2fPAMFSOI=";
    installPath = "https/repo1.maven.org/maven2/org/scala-lang/modules/scala-xml_2.13/2.3.0";
  };

  "org.scala-lang.modules_scala-xml_2.13-2.4.0" = fetchMaven {
    name = "org.scala-lang.modules_scala-xml_2.13-2.4.0";
    urls = [
      "https://repo1.maven.org/maven2/org/scala-lang/modules/scala-xml_2.13/2.4.0/scala-xml_2.13-2.4.0.jar"
      "https://repo1.maven.org/maven2/org/scala-lang/modules/scala-xml_2.13/2.4.0/scala-xml_2.13-2.4.0.pom"
    ];
    hash = "sha256-e5pQSejMXF2nSlmD8wBFRkxcRN+8nEHW/89qN0Je0dY=";
    installPath = "https/repo1.maven.org/maven2/org/scala-lang/modules/scala-xml_2.13/2.4.0";
  };

  "org.scala-lang.modules_scala-xml_3-2.1.0" = fetchMaven {
    name = "org.scala-lang.modules_scala-xml_3-2.1.0";
    urls = [
      "https://repo1.maven.org/maven2/org/scala-lang/modules/scala-xml_3/2.1.0/scala-xml_3-2.1.0.jar"
      "https://repo1.maven.org/maven2/org/scala-lang/modules/scala-xml_3/2.1.0/scala-xml_3-2.1.0.pom"
    ];
    hash = "sha256-0D7YYVRGQqauXGiT/3d1TAoDxTbccs7WqMGmXe1AeRo=";
    installPath = "https/repo1.maven.org/maven2/org/scala-lang/modules/scala-xml_3/2.1.0";
  };

  "org.scala-lang.modules_scala-xml_3-2.4.0" = fetchMaven {
    name = "org.scala-lang.modules_scala-xml_3-2.4.0";
    urls = [
      "https://repo1.maven.org/maven2/org/scala-lang/modules/scala-xml_3/2.4.0/scala-xml_3-2.4.0.jar"
      "https://repo1.maven.org/maven2/org/scala-lang/modules/scala-xml_3/2.4.0/scala-xml_3-2.4.0.pom"
    ];
    hash = "sha256-+7nNhpZLvDvMGTITT2eg3S4G87M2HHyqb/AvmNet/l0=";
    installPath = "https/repo1.maven.org/maven2/org/scala-lang/modules/scala-xml_3/2.4.0";
  };

  "org.scala-sbt.jline_jline-2.14.7-sbt-9a88bc413e2b34a4580c001c654d1a7f4f65bf18" = fetchMaven {
    name = "org.scala-sbt.jline_jline-2.14.7-sbt-9a88bc413e2b34a4580c001c654d1a7f4f65bf18";
    urls = [
      "https://repo1.maven.org/maven2/org/scala-sbt/jline/jline/2.14.7-sbt-9a88bc413e2b34a4580c001c654d1a7f4f65bf18/jline-2.14.7-sbt-9a88bc413e2b34a4580c001c654d1a7f4f65bf18.jar"
      "https://repo1.maven.org/maven2/org/scala-sbt/jline/jline/2.14.7-sbt-9a88bc413e2b34a4580c001c654d1a7f4f65bf18/jline-2.14.7-sbt-9a88bc413e2b34a4580c001c654d1a7f4f65bf18.pom"
    ];
    hash = "sha256-1Nq7/UMXSlaZ7iwR1WMryltAmS8/fRCK6u93cm+1uh4=";
    installPath = "https/repo1.maven.org/maven2/org/scala-sbt/jline/jline/2.14.7-sbt-9a88bc413e2b34a4580c001c654d1a7f4f65bf18";
  };

  "org.sonatype.oss_oss-parent-5" = fetchMaven {
    name = "org.sonatype.oss_oss-parent-5";
    urls = [ "https://repo1.maven.org/maven2/org/sonatype/oss/oss-parent/5/oss-parent-5.pom" ];
    hash = "sha256-nga0RHiAES0cK5iFNr5AStbaorGJjt2cRMQg2j58uUA=";
    installPath = "https/repo1.maven.org/maven2/org/sonatype/oss/oss-parent/5";
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

  "org.virtuslab.scala-cli_config_3-1.9.0" = fetchMaven {
    name = "org.virtuslab.scala-cli_config_3-1.9.0";
    urls = [
      "https://repo1.maven.org/maven2/org/virtuslab/scala-cli/config_3/1.9.0/config_3-1.9.0.jar"
      "https://repo1.maven.org/maven2/org/virtuslab/scala-cli/config_3/1.9.0/config_3-1.9.0.pom"
    ];
    hash = "sha256-ettGmeOnVRakSqmIp4J+yq0evwMqTp7NXgGFRoTLufg=";
    installPath = "https/repo1.maven.org/maven2/org/virtuslab/scala-cli/config_3/1.9.0";
  };

  "org.virtuslab.scala-cli_specification-level_3-1.9.0" = fetchMaven {
    name = "org.virtuslab.scala-cli_specification-level_3-1.9.0";
    urls = [
      "https://repo1.maven.org/maven2/org/virtuslab/scala-cli/specification-level_3/1.9.0/specification-level_3-1.9.0.jar"
      "https://repo1.maven.org/maven2/org/virtuslab/scala-cli/specification-level_3/1.9.0/specification-level_3-1.9.0.pom"
    ];
    hash = "sha256-xmO5C6kkIRaDp98SfegQn4VTSYv3ThsAMP0LBB9gElA=";
    installPath = "https/repo1.maven.org/maven2/org/virtuslab/scala-cli/specification-level_3/1.9.0";
  };

  "org.wildfly.client_wildfly-client-config-1.0.1.Final" = fetchMaven {
    name = "org.wildfly.client_wildfly-client-config-1.0.1.Final";
    urls = [
      "https://repo1.maven.org/maven2/org/wildfly/client/wildfly-client-config/1.0.1.Final/wildfly-client-config-1.0.1.Final.jar"
      "https://repo1.maven.org/maven2/org/wildfly/client/wildfly-client-config/1.0.1.Final/wildfly-client-config-1.0.1.Final.pom"
    ];
    hash = "sha256-FoAeD3KR3Mw+AzI3vhTDdAYRE8Svj8y2WsJNpdC7sSY=";
    installPath = "https/repo1.maven.org/maven2/org/wildfly/client/wildfly-client-config/1.0.1.Final";
  };

  "org.wildfly.common_wildfly-common-1.5.4.Final" = fetchMaven {
    name = "org.wildfly.common_wildfly-common-1.5.4.Final";
    urls = [
      "https://repo1.maven.org/maven2/org/wildfly/common/wildfly-common/1.5.4.Final/wildfly-common-1.5.4.Final.jar"
      "https://repo1.maven.org/maven2/org/wildfly/common/wildfly-common/1.5.4.Final/wildfly-common-1.5.4.Final.pom"
    ];
    hash = "sha256-K+wCKR+vIsp6Ju6SKc0+tdjmLd7Y8VmMFC6NELsy25w=";
    installPath = "https/repo1.maven.org/maven2/org/wildfly/common/wildfly-common/1.5.4.Final";
  };

  "software.amazon.awssdk_aws-sdk-java-pom-2.32.16" = fetchMaven {
    name = "software.amazon.awssdk_aws-sdk-java-pom-2.32.16";
    urls = [
      "https://repo1.maven.org/maven2/software/amazon/awssdk/aws-sdk-java-pom/2.32.16/aws-sdk-java-pom-2.32.16.pom"
    ];
    hash = "sha256-q+EHphRq6+A1gWGHul0vq4zI/o6ziAuO+uKB46V2iFM=";
    installPath = "https/repo1.maven.org/maven2/software/amazon/awssdk/aws-sdk-java-pom/2.32.16";
  };

  "software.amazon.awssdk_bom-2.32.16" = fetchMaven {
    name = "software.amazon.awssdk_bom-2.32.16";
    urls = [ "https://repo1.maven.org/maven2/software/amazon/awssdk/bom/2.32.16/bom-2.32.16.pom" ];
    hash = "sha256-fnTlp42Jn8cbuW7TAFNGxlxkBqtXJP5rtPCJM6q921g=";
    installPath = "https/repo1.maven.org/maven2/software/amazon/awssdk/bom/2.32.16";
  };

  "ua.co.k_strftime4j-1.0.5" = fetchMaven {
    name = "ua.co.k_strftime4j-1.0.5";
    urls = [
      "https://repo1.maven.org/maven2/ua/co/k/strftime4j/1.0.5/strftime4j-1.0.5.jar"
      "https://repo1.maven.org/maven2/ua/co/k/strftime4j/1.0.5/strftime4j-1.0.5.pom"
    ];
    hash = "sha256-Wrg3ftbV/dCtAhULZcti/FJ2XVbpqd9fM4Z6A/fOwAo=";
    installPath = "https/repo1.maven.org/maven2/ua/co/k/strftime4j/1.0.5";
  };

  "com.fasterxml.jackson.core_jackson-annotations-2.12.1" = fetchMaven {
    name = "com.fasterxml.jackson.core_jackson-annotations-2.12.1";
    urls = [
      "https://repo1.maven.org/maven2/com/fasterxml/jackson/core/jackson-annotations/2.12.1/jackson-annotations-2.12.1.pom"
    ];
    hash = "sha256-anUbI5JS/lVsxPul1sdmtNFsJbiyHvyz9au/cBV0L6w=";
    installPath = "https/repo1.maven.org/maven2/com/fasterxml/jackson/core/jackson-annotations/2.12.1";
  };

  "com.fasterxml.jackson.core_jackson-annotations-2.15.1" = fetchMaven {
    name = "com.fasterxml.jackson.core_jackson-annotations-2.15.1";
    urls = [
      "https://repo1.maven.org/maven2/com/fasterxml/jackson/core/jackson-annotations/2.15.1/jackson-annotations-2.15.1.jar"
      "https://repo1.maven.org/maven2/com/fasterxml/jackson/core/jackson-annotations/2.15.1/jackson-annotations-2.15.1.pom"
    ];
    hash = "sha256-hwI7CChHkZif7MNeHDjPf6OuNcncc9i7zIET6JUiSY8=";
    installPath = "https/repo1.maven.org/maven2/com/fasterxml/jackson/core/jackson-annotations/2.15.1";
  };

  "com.fasterxml.jackson.core_jackson-core-2.15.1" = fetchMaven {
    name = "com.fasterxml.jackson.core_jackson-core-2.15.1";
    urls = [
      "https://repo1.maven.org/maven2/com/fasterxml/jackson/core/jackson-core/2.15.1/jackson-core-2.15.1.jar"
      "https://repo1.maven.org/maven2/com/fasterxml/jackson/core/jackson-core/2.15.1/jackson-core-2.15.1.pom"
    ];
    hash = "sha256-07N9Rg8OKF7hTLa+0AoF1hImT3acHpQBIJhHBnLUSOs=";
    installPath = "https/repo1.maven.org/maven2/com/fasterxml/jackson/core/jackson-core/2.15.1";
  };

  "com.fasterxml.jackson.core_jackson-databind-2.15.1" = fetchMaven {
    name = "com.fasterxml.jackson.core_jackson-databind-2.15.1";
    urls = [
      "https://repo1.maven.org/maven2/com/fasterxml/jackson/core/jackson-databind/2.15.1/jackson-databind-2.15.1.jar"
      "https://repo1.maven.org/maven2/com/fasterxml/jackson/core/jackson-databind/2.15.1/jackson-databind-2.15.1.pom"
    ];
    hash = "sha256-t8Sge4HbKg8XsqNgW69/3G3RKgK09MSCsPH7XYtsrew=";
    installPath = "https/repo1.maven.org/maven2/com/fasterxml/jackson/core/jackson-databind/2.15.1";
  };

  "com.fasterxml.jackson.dataformat_jackson-dataformat-yaml-2.15.1" = fetchMaven {
    name = "com.fasterxml.jackson.dataformat_jackson-dataformat-yaml-2.15.1";
    urls = [
      "https://repo1.maven.org/maven2/com/fasterxml/jackson/dataformat/jackson-dataformat-yaml/2.15.1/jackson-dataformat-yaml-2.15.1.jar"
      "https://repo1.maven.org/maven2/com/fasterxml/jackson/dataformat/jackson-dataformat-yaml/2.15.1/jackson-dataformat-yaml-2.15.1.pom"
    ];
    hash = "sha256-gSpEZqpCXmFGg86xQeOlNRNdyBmiM/rN2kCTGhjhHt4=";
    installPath = "https/repo1.maven.org/maven2/com/fasterxml/jackson/dataformat/jackson-dataformat-yaml/2.15.1";
  };

  "com.fasterxml.jackson.dataformat_jackson-dataformats-text-2.15.1" = fetchMaven {
    name = "com.fasterxml.jackson.dataformat_jackson-dataformats-text-2.15.1";
    urls = [
      "https://repo1.maven.org/maven2/com/fasterxml/jackson/dataformat/jackson-dataformats-text/2.15.1/jackson-dataformats-text-2.15.1.pom"
    ];
    hash = "sha256-1RiIP6cIRZoOMBV2+vmJJOYXMarqg+4l7XQ8S7OvAvg=";
    installPath = "https/repo1.maven.org/maven2/com/fasterxml/jackson/dataformat/jackson-dataformats-text/2.15.1";
  };

  "com.fasterxml.jackson.datatype_jackson-datatype-jsr310-2.12.1" = fetchMaven {
    name = "com.fasterxml.jackson.datatype_jackson-datatype-jsr310-2.12.1";
    urls = [
      "https://repo1.maven.org/maven2/com/fasterxml/jackson/datatype/jackson-datatype-jsr310/2.12.1/jackson-datatype-jsr310-2.12.1.jar"
      "https://repo1.maven.org/maven2/com/fasterxml/jackson/datatype/jackson-datatype-jsr310/2.12.1/jackson-datatype-jsr310-2.12.1.pom"
    ];
    hash = "sha256-YH7YMZY1aeamRA6aVvF2JG3C1YLZhvaMpVCegAfdhFU=";
    installPath = "https/repo1.maven.org/maven2/com/fasterxml/jackson/datatype/jackson-datatype-jsr310/2.12.1";
  };

  "com.fasterxml.jackson.module_jackson-modules-java8-2.12.1" = fetchMaven {
    name = "com.fasterxml.jackson.module_jackson-modules-java8-2.12.1";
    urls = [
      "https://repo1.maven.org/maven2/com/fasterxml/jackson/module/jackson-modules-java8/2.12.1/jackson-modules-java8-2.12.1.pom"
    ];
    hash = "sha256-x5YmdPGcWOpCompDhApY6o5VZ+IUVHTbeday5HVW/NQ=";
    installPath = "https/repo1.maven.org/maven2/com/fasterxml/jackson/module/jackson-modules-java8/2.12.1";
  };

  "com.github.plokhotnyuk.jsoniter-scala_jsoniter-scala-core_2.13-2.13.5" = fetchMaven {
    name = "com.github.plokhotnyuk.jsoniter-scala_jsoniter-scala-core_2.13-2.13.5";
    urls = [
      "https://repo1.maven.org/maven2/com/github/plokhotnyuk/jsoniter-scala/jsoniter-scala-core_2.13/2.13.5/jsoniter-scala-core_2.13-2.13.5.jar"
      "https://repo1.maven.org/maven2/com/github/plokhotnyuk/jsoniter-scala/jsoniter-scala-core_2.13/2.13.5/jsoniter-scala-core_2.13-2.13.5.pom"
    ];
    hash = "sha256-uQ7ULWW7il8C1f07v2grRCOzgxDH31UlmtAuL9m/VE8=";
    installPath = "https/repo1.maven.org/maven2/com/github/plokhotnyuk/jsoniter-scala/jsoniter-scala-core_2.13/2.13.5";
  };

  "com.github.plokhotnyuk.jsoniter-scala_jsoniter-scala-core_2.13-2.36.6" = fetchMaven {
    name = "com.github.plokhotnyuk.jsoniter-scala_jsoniter-scala-core_2.13-2.36.6";
    urls = [
      "https://repo1.maven.org/maven2/com/github/plokhotnyuk/jsoniter-scala/jsoniter-scala-core_2.13/2.36.6/jsoniter-scala-core_2.13-2.36.6.jar"
      "https://repo1.maven.org/maven2/com/github/plokhotnyuk/jsoniter-scala/jsoniter-scala-core_2.13/2.36.6/jsoniter-scala-core_2.13-2.36.6.pom"
    ];
    hash = "sha256-tb4LG+x68ZFWFcY6iPPTqUUNDOcJqk2VFG21vna86R0=";
    installPath = "https/repo1.maven.org/maven2/com/github/plokhotnyuk/jsoniter-scala/jsoniter-scala-core_2.13/2.36.6";
  };

  "com.github.plokhotnyuk.jsoniter-scala_jsoniter-scala-macros_2.13-2.36.6" = fetchMaven {
    name = "com.github.plokhotnyuk.jsoniter-scala_jsoniter-scala-macros_2.13-2.36.6";
    urls = [
      "https://repo1.maven.org/maven2/com/github/plokhotnyuk/jsoniter-scala/jsoniter-scala-macros_2.13/2.36.6/jsoniter-scala-macros_2.13-2.36.6.jar"
      "https://repo1.maven.org/maven2/com/github/plokhotnyuk/jsoniter-scala/jsoniter-scala-macros_2.13/2.36.6/jsoniter-scala-macros_2.13-2.36.6.pom"
    ];
    hash = "sha256-VYvsS/2Xqv+tTZjQnZqfBbnYNG3F7Z1eSuYOHf5aD2E=";
    installPath = "https/repo1.maven.org/maven2/com/github/plokhotnyuk/jsoniter-scala/jsoniter-scala-macros_2.13/2.36.6";
  };

  "com.google.code.findbugs_jsr305-3.0.2" = fetchMaven {
    name = "com.google.code.findbugs_jsr305-3.0.2";
    urls = [
      "https://repo1.maven.org/maven2/com/google/code/findbugs/jsr305/3.0.2/jsr305-3.0.2.jar"
      "https://repo1.maven.org/maven2/com/google/code/findbugs/jsr305/3.0.2/jsr305-3.0.2.pom"
    ];
    hash = "sha256-eq7d9gzPBemWTgv/S9uUEKh7A2rqnKOhK0L4/e6N3/s=";
    installPath = "https/repo1.maven.org/maven2/com/google/code/findbugs/jsr305/3.0.2";
  };

  "com.google.code.gson_gson-2.13.1" = fetchMaven {
    name = "com.google.code.gson_gson-2.13.1";
    urls = [
      "https://repo1.maven.org/maven2/com/google/code/gson/gson/2.13.1/gson-2.13.1.jar"
      "https://repo1.maven.org/maven2/com/google/code/gson/gson/2.13.1/gson-2.13.1.pom"
    ];
    hash = "sha256-U+RuIuVvEdWd6sYtll/Qtr3vxdYxM2dcv5rmx59WsDE=";
    installPath = "https/repo1.maven.org/maven2/com/google/code/gson/gson/2.13.1";
  };

  "com.google.code.gson_gson-2.13.2" = fetchMaven {
    name = "com.google.code.gson_gson-2.13.2";
    urls = [
      "https://repo1.maven.org/maven2/com/google/code/gson/gson/2.13.2/gson-2.13.2.jar"
      "https://repo1.maven.org/maven2/com/google/code/gson/gson/2.13.2/gson-2.13.2.pom"
    ];
    hash = "sha256-+Bc1Lhq2uhj/qsS+7zvNH9rQph6F+FpYMci5O551Yqk=";
    installPath = "https/repo1.maven.org/maven2/com/google/code/gson/gson/2.13.2";
  };

  "com.google.code.gson_gson-parent-2.13.1" = fetchMaven {
    name = "com.google.code.gson_gson-parent-2.13.1";
    urls = [
      "https://repo1.maven.org/maven2/com/google/code/gson/gson-parent/2.13.1/gson-parent-2.13.1.pom"
    ];
    hash = "sha256-wvo+tZtwJtmmNXyChMF9SAvmD/6hxAEit5YRl/ZTqlA=";
    installPath = "https/repo1.maven.org/maven2/com/google/code/gson/gson-parent/2.13.1";
  };

  "com.google.code.gson_gson-parent-2.13.2" = fetchMaven {
    name = "com.google.code.gson_gson-parent-2.13.2";
    urls = [
      "https://repo1.maven.org/maven2/com/google/code/gson/gson-parent/2.13.2/gson-parent-2.13.2.pom"
    ];
    hash = "sha256-prNnb7pxMO5rzfYPJBbCZm0I8nanL4ZhAJita6s0ksM=";
    installPath = "https/repo1.maven.org/maven2/com/google/code/gson/gson-parent/2.13.2";
  };

  "io.get-coursier.jvm.indices_index-linux-amd64-0.0.4-125-77e06d" = fetchMaven {
    name = "io.get-coursier.jvm.indices_index-linux-amd64-0.0.4-125-77e06d";
    urls = [
      "https://repo1.maven.org/maven2/io/get-coursier/jvm/indices/index-linux-amd64/0.0.4-125-77e06d/index-linux-amd64-0.0.4-125-77e06d.jar"
      "https://repo1.maven.org/maven2/io/get-coursier/jvm/indices/index-linux-amd64/0.0.4-125-77e06d/index-linux-amd64-0.0.4-125-77e06d.pom"
    ];
    hash = "sha256-C4EJNuRO4o1LUqOuaXYdvrv4ndGRDmRipabBoqDm7WA=";
    installPath = "https/repo1.maven.org/maven2/io/get-coursier/jvm/indices/index-linux-amd64/0.0.4-125-77e06d";
  };

  "io.github.alexarchambault.native-terminal_native-terminal-no-ffm-0.0.9.1" = fetchMaven {
    name = "io.github.alexarchambault.native-terminal_native-terminal-no-ffm-0.0.9.1";
    urls = [
      "https://repo1.maven.org/maven2/io/github/alexarchambault/native-terminal/native-terminal-no-ffm/0.0.9.1/native-terminal-no-ffm-0.0.9.1.jar"
      "https://repo1.maven.org/maven2/io/github/alexarchambault/native-terminal/native-terminal-no-ffm/0.0.9.1/native-terminal-no-ffm-0.0.9.1.pom"
    ];
    hash = "sha256-fHtvFUaVlrgdz+S3mPlxXjA4mpSBWC+hjW3U7h5NFo0=";
    installPath = "https/repo1.maven.org/maven2/io/github/alexarchambault/native-terminal/native-terminal-no-ffm/0.0.9.1";
  };

  "io.github.alexarchambault.windows-ansi_windows-ansi-0.0.6" = fetchMaven {
    name = "io.github.alexarchambault.windows-ansi_windows-ansi-0.0.6";
    urls = [
      "https://repo1.maven.org/maven2/io/github/alexarchambault/windows-ansi/windows-ansi/0.0.6/windows-ansi-0.0.6.jar"
      "https://repo1.maven.org/maven2/io/github/alexarchambault/windows-ansi/windows-ansi/0.0.6/windows-ansi-0.0.6.pom"
    ];
    hash = "sha256-TGUrDCPYFiXV5b2If3u4KviH3JxZttMOKL1HUHqIWRo=";
    installPath = "https/repo1.maven.org/maven2/io/github/alexarchambault/windows-ansi/windows-ansi/0.0.6";
  };

  "net.java.dev.jna_jna-5.13.0" = fetchMaven {
    name = "net.java.dev.jna_jna-5.13.0";
    urls = [
      "https://repo1.maven.org/maven2/net/java/dev/jna/jna/5.13.0/jna-5.13.0.jar"
      "https://repo1.maven.org/maven2/net/java/dev/jna/jna/5.13.0/jna-5.13.0.pom"
    ];
    hash = "sha256-LP1W3fVxMEP6po1dlkAseu3pSeSnobemZJaxKivwqDs=";
    installPath = "https/repo1.maven.org/maven2/net/java/dev/jna/jna/5.13.0";
  };

  "net.java.dev.jna_jna-5.14.0" = fetchMaven {
    name = "net.java.dev.jna_jna-5.14.0";
    urls = [
      "https://repo1.maven.org/maven2/net/java/dev/jna/jna/5.14.0/jna-5.14.0.jar"
      "https://repo1.maven.org/maven2/net/java/dev/jna/jna/5.14.0/jna-5.14.0.pom"
    ];
    hash = "sha256-mvzJykzd4Cz473vRi15E0NReFk7YN7hPOtS5ZHUhCIg=";
    installPath = "https/repo1.maven.org/maven2/net/java/dev/jna/jna/5.14.0";
  };

  "net.java.dev.jna_jna-5.15.0" = fetchMaven {
    name = "net.java.dev.jna_jna-5.15.0";
    urls = [ "https://repo1.maven.org/maven2/net/java/dev/jna/jna/5.15.0/jna-5.15.0.pom" ];
    hash = "sha256-DSCkx29i2QxUeyOUpCbdGWiYeB2r7RLsgBNFolj2cUg=";
    installPath = "https/repo1.maven.org/maven2/net/java/dev/jna/jna/5.15.0";
  };

  "net.java.dev.jna_jna-5.16.0" = fetchMaven {
    name = "net.java.dev.jna_jna-5.16.0";
    urls = [
      "https://repo1.maven.org/maven2/net/java/dev/jna/jna/5.16.0/jna-5.16.0.jar"
      "https://repo1.maven.org/maven2/net/java/dev/jna/jna/5.16.0/jna-5.16.0.pom"
    ];
    hash = "sha256-p/Ivik3Fx1yaqylKj7YH0TN3J4iB3+C27YpUiOluBrw=";
    installPath = "https/repo1.maven.org/maven2/net/java/dev/jna/jna/5.16.0";
  };

  "net.java.dev.jna_jna-5.17.0" = fetchMaven {
    name = "net.java.dev.jna_jna-5.17.0";
    urls = [
      "https://repo1.maven.org/maven2/net/java/dev/jna/jna/5.17.0/jna-5.17.0.jar"
      "https://repo1.maven.org/maven2/net/java/dev/jna/jna/5.17.0/jna-5.17.0.pom"
    ];
    hash = "sha256-q4PFCy/O+i1lIiNaf627UILQWmnOgIZTGeMzu5N3M+Q=";
    installPath = "https/repo1.maven.org/maven2/net/java/dev/jna/jna/5.17.0";
  };

  "org.apache.geronimo.genesis_genesis-2.0" = fetchMaven {
    name = "org.apache.geronimo.genesis_genesis-2.0";
    urls = [ "https://repo1.maven.org/maven2/org/apache/geronimo/genesis/genesis/2.0/genesis-2.0.pom" ];
    hash = "sha256-lcX5R64+07kRLqpdfkay87hJI6ykVn/wUXs142Elips=";
    installPath = "https/repo1.maven.org/maven2/org/apache/geronimo/genesis/genesis/2.0";
  };

  "org.apache.geronimo.genesis_genesis-default-flava-2.0" = fetchMaven {
    name = "org.apache.geronimo.genesis_genesis-default-flava-2.0";
    urls = [
      "https://repo1.maven.org/maven2/org/apache/geronimo/genesis/genesis-default-flava/2.0/genesis-default-flava-2.0.pom"
    ];
    hash = "sha256-jkGo9ePZSnxqcIOQIuAz1ZTPNjjx2vc01oxtt6EJuUk=";
    installPath = "https/repo1.maven.org/maven2/org/apache/geronimo/genesis/genesis-default-flava/2.0";
  };

  "org.apache.geronimo.genesis_genesis-java5-flava-2.0" = fetchMaven {
    name = "org.apache.geronimo.genesis_genesis-java5-flava-2.0";
    urls = [
      "https://repo1.maven.org/maven2/org/apache/geronimo/genesis/genesis-java5-flava/2.0/genesis-java5-flava-2.0.pom"
    ];
    hash = "sha256-CTKaQ0fTVeVBnQrWm4TCcbTONXm/N6bPXPGXx0hToLQ=";
    installPath = "https/repo1.maven.org/maven2/org/apache/geronimo/genesis/genesis-java5-flava/2.0";
  };

  "org.apache.logging.log4j_log4j-2.25.1" = fetchMaven {
    name = "org.apache.logging.log4j_log4j-2.25.1";
    urls = [ "https://repo1.maven.org/maven2/org/apache/logging/log4j/log4j/2.25.1/log4j-2.25.1.pom" ];
    hash = "sha256-/p3Ev9rCHqqFhrWRclrKjQGmF5Y9tIXZr58Jppzi2tc=";
    installPath = "https/repo1.maven.org/maven2/org/apache/logging/log4j/log4j/2.25.1";
  };

  "org.apache.logging.log4j_log4j-api-2.25.1" = fetchMaven {
    name = "org.apache.logging.log4j_log4j-api-2.25.1";
    urls = [
      "https://repo1.maven.org/maven2/org/apache/logging/log4j/log4j-api/2.25.1/log4j-api-2.25.1.jar"
      "https://repo1.maven.org/maven2/org/apache/logging/log4j/log4j-api/2.25.1/log4j-api-2.25.1.pom"
    ];
    hash = "sha256-OQnbI65CBVg7XZjgtbIiaa+WgQFo2fmPhyElPFIBZic=";
    installPath = "https/repo1.maven.org/maven2/org/apache/logging/log4j/log4j-api/2.25.1";
  };

  "org.apache.logging.log4j_log4j-bom-2.25.1" = fetchMaven {
    name = "org.apache.logging.log4j_log4j-bom-2.25.1";
    urls = [
      "https://repo1.maven.org/maven2/org/apache/logging/log4j/log4j-bom/2.25.1/log4j-bom-2.25.1.pom"
    ];
    hash = "sha256-in1oVoyTFGRrT3aPzm0mZl4QiLyNVbTzi9cpiVyjZwo=";
    installPath = "https/repo1.maven.org/maven2/org/apache/logging/log4j/log4j-bom/2.25.1";
  };

  "org.apache.logging.log4j_log4j-core-2.25.1" = fetchMaven {
    name = "org.apache.logging.log4j_log4j-core-2.25.1";
    urls = [
      "https://repo1.maven.org/maven2/org/apache/logging/log4j/log4j-core/2.25.1/log4j-core-2.25.1.jar"
      "https://repo1.maven.org/maven2/org/apache/logging/log4j/log4j-core/2.25.1/log4j-core-2.25.1.pom"
    ];
    hash = "sha256-K8D+tVs4cZwLxfam8sO+ip6MBF3LtWoF73VmJfYSJZw=";
    installPath = "https/repo1.maven.org/maven2/org/apache/logging/log4j/log4j-core/2.25.1";
  };

  "org.apache.maven.resolver_maven-resolver-2.0.0-alpha-2" = fetchMaven {
    name = "org.apache.maven.resolver_maven-resolver-2.0.0-alpha-2";
    urls = [
      "https://repo1.maven.org/maven2/org/apache/maven/resolver/maven-resolver/2.0.0-alpha-2/maven-resolver-2.0.0-alpha-2.pom"
    ];
    hash = "sha256-zqdFevMSHI1m0Hzxkqod3JTfe3dHG0WH9XxXsEu/TBA=";
    installPath = "https/repo1.maven.org/maven2/org/apache/maven/resolver/maven-resolver/2.0.0-alpha-2";
  };

  "org.apache.maven.resolver_maven-resolver-2.0.0-alpha-8" = fetchMaven {
    name = "org.apache.maven.resolver_maven-resolver-2.0.0-alpha-8";
    urls = [
      "https://repo1.maven.org/maven2/org/apache/maven/resolver/maven-resolver/2.0.0-alpha-8/maven-resolver-2.0.0-alpha-8.pom"
    ];
    hash = "sha256-VAafZJgeYBxmToxUjgAyq394LsmEM/SQkLRHou7X+VA=";
    installPath = "https/repo1.maven.org/maven2/org/apache/maven/resolver/maven-resolver/2.0.0-alpha-8";
  };

  "org.apache.maven.resolver_maven-resolver-2.0.10" = fetchMaven {
    name = "org.apache.maven.resolver_maven-resolver-2.0.10";
    urls = [
      "https://repo1.maven.org/maven2/org/apache/maven/resolver/maven-resolver/2.0.10/maven-resolver-2.0.10.pom"
    ];
    hash = "sha256-gIStxtaSEYJaXfTXa9we+pAeI+blAg8edA6E10ccUGc=";
    installPath = "https/repo1.maven.org/maven2/org/apache/maven/resolver/maven-resolver/2.0.10";
  };

  "org.apache.maven.resolver_maven-resolver-api-2.0.10" = fetchMaven {
    name = "org.apache.maven.resolver_maven-resolver-api-2.0.10";
    urls = [
      "https://repo1.maven.org/maven2/org/apache/maven/resolver/maven-resolver-api/2.0.10/maven-resolver-api-2.0.10.jar"
      "https://repo1.maven.org/maven2/org/apache/maven/resolver/maven-resolver-api/2.0.10/maven-resolver-api-2.0.10.pom"
    ];
    hash = "sha256-QTq9EEWDDkn7tBFm/Ofbgmijtj6Sdj5FARwy4Os/cVQ=";
    installPath = "https/repo1.maven.org/maven2/org/apache/maven/resolver/maven-resolver-api/2.0.10";
  };

  "org.apache.maven.resolver_maven-resolver-connector-basic-2.0.10" = fetchMaven {
    name = "org.apache.maven.resolver_maven-resolver-connector-basic-2.0.10";
    urls = [
      "https://repo1.maven.org/maven2/org/apache/maven/resolver/maven-resolver-connector-basic/2.0.10/maven-resolver-connector-basic-2.0.10.jar"
      "https://repo1.maven.org/maven2/org/apache/maven/resolver/maven-resolver-connector-basic/2.0.10/maven-resolver-connector-basic-2.0.10.pom"
    ];
    hash = "sha256-j68H5iVp1Be4FBcgWC/ecXdoOIF6f26yrJ5AdzJVztk=";
    installPath = "https/repo1.maven.org/maven2/org/apache/maven/resolver/maven-resolver-connector-basic/2.0.10";
  };

  "org.apache.maven.resolver_maven-resolver-impl-2.0.0-alpha-8" = fetchMaven {
    name = "org.apache.maven.resolver_maven-resolver-impl-2.0.0-alpha-8";
    urls = [
      "https://repo1.maven.org/maven2/org/apache/maven/resolver/maven-resolver-impl/2.0.0-alpha-8/maven-resolver-impl-2.0.0-alpha-8.jar"
      "https://repo1.maven.org/maven2/org/apache/maven/resolver/maven-resolver-impl/2.0.0-alpha-8/maven-resolver-impl-2.0.0-alpha-8.pom"
    ];
    hash = "sha256-lEXAYbAX5vF1SWewioFVCwgAla71utx7e7IJ1+1cakI=";
    installPath = "https/repo1.maven.org/maven2/org/apache/maven/resolver/maven-resolver-impl/2.0.0-alpha-8";
  };

  "org.apache.maven.resolver_maven-resolver-named-locks-2.0.0-alpha-8" = fetchMaven {
    name = "org.apache.maven.resolver_maven-resolver-named-locks-2.0.0-alpha-8";
    urls = [
      "https://repo1.maven.org/maven2/org/apache/maven/resolver/maven-resolver-named-locks/2.0.0-alpha-8/maven-resolver-named-locks-2.0.0-alpha-8.jar"
      "https://repo1.maven.org/maven2/org/apache/maven/resolver/maven-resolver-named-locks/2.0.0-alpha-8/maven-resolver-named-locks-2.0.0-alpha-8.pom"
    ];
    hash = "sha256-c8Lnw3kaFuxc6To5wO2o9xWlO/WPUjxmcijcxZUWs+o=";
    installPath = "https/repo1.maven.org/maven2/org/apache/maven/resolver/maven-resolver-named-locks/2.0.0-alpha-8";
  };

  "org.apache.maven.resolver_maven-resolver-spi-2.0.10" = fetchMaven {
    name = "org.apache.maven.resolver_maven-resolver-spi-2.0.10";
    urls = [
      "https://repo1.maven.org/maven2/org/apache/maven/resolver/maven-resolver-spi/2.0.10/maven-resolver-spi-2.0.10.jar"
      "https://repo1.maven.org/maven2/org/apache/maven/resolver/maven-resolver-spi/2.0.10/maven-resolver-spi-2.0.10.pom"
    ];
    hash = "sha256-DiU1o0lcZnyjGoPzhDeNYO+e80U4dcaE7wK75buDo8g=";
    installPath = "https/repo1.maven.org/maven2/org/apache/maven/resolver/maven-resolver-spi/2.0.10";
  };

  "org.apache.maven.resolver_maven-resolver-supplier-2.0.0-alpha-8" = fetchMaven {
    name = "org.apache.maven.resolver_maven-resolver-supplier-2.0.0-alpha-8";
    urls = [
      "https://repo1.maven.org/maven2/org/apache/maven/resolver/maven-resolver-supplier/2.0.0-alpha-8/maven-resolver-supplier-2.0.0-alpha-8.jar"
      "https://repo1.maven.org/maven2/org/apache/maven/resolver/maven-resolver-supplier/2.0.0-alpha-8/maven-resolver-supplier-2.0.0-alpha-8.pom"
    ];
    hash = "sha256-0jO7Q3lBLyFVCZS/GSAzYkECSnMBK+ZehzmpAaiXc0k=";
    installPath = "https/repo1.maven.org/maven2/org/apache/maven/resolver/maven-resolver-supplier/2.0.0-alpha-8";
  };

  "org.apache.maven.resolver_maven-resolver-transport-apache-2.0.0-alpha-8" = fetchMaven {
    name = "org.apache.maven.resolver_maven-resolver-transport-apache-2.0.0-alpha-8";
    urls = [
      "https://repo1.maven.org/maven2/org/apache/maven/resolver/maven-resolver-transport-apache/2.0.0-alpha-8/maven-resolver-transport-apache-2.0.0-alpha-8.jar"
      "https://repo1.maven.org/maven2/org/apache/maven/resolver/maven-resolver-transport-apache/2.0.0-alpha-8/maven-resolver-transport-apache-2.0.0-alpha-8.pom"
    ];
    hash = "sha256-hpCeGN1n1q++25jfJMN8A4+l9TXimiLMFbkUSqrLaMo=";
    installPath = "https/repo1.maven.org/maven2/org/apache/maven/resolver/maven-resolver-transport-apache/2.0.0-alpha-8";
  };

  "org.apache.maven.resolver_maven-resolver-transport-file-2.0.0-alpha-8" = fetchMaven {
    name = "org.apache.maven.resolver_maven-resolver-transport-file-2.0.0-alpha-8";
    urls = [
      "https://repo1.maven.org/maven2/org/apache/maven/resolver/maven-resolver-transport-file/2.0.0-alpha-8/maven-resolver-transport-file-2.0.0-alpha-8.jar"
      "https://repo1.maven.org/maven2/org/apache/maven/resolver/maven-resolver-transport-file/2.0.0-alpha-8/maven-resolver-transport-file-2.0.0-alpha-8.pom"
    ];
    hash = "sha256-IzG1REcUbkdzv2jIuAg+3gNbR4DF2Flw1vFztsvfnLs=";
    installPath = "https/repo1.maven.org/maven2/org/apache/maven/resolver/maven-resolver-transport-file/2.0.0-alpha-8";
  };

  "org.apache.maven.resolver_maven-resolver-transport-http-2.0.0-alpha-2" = fetchMaven {
    name = "org.apache.maven.resolver_maven-resolver-transport-http-2.0.0-alpha-2";
    urls = [
      "https://repo1.maven.org/maven2/org/apache/maven/resolver/maven-resolver-transport-http/2.0.0-alpha-2/maven-resolver-transport-http-2.0.0-alpha-2.jar"
      "https://repo1.maven.org/maven2/org/apache/maven/resolver/maven-resolver-transport-http/2.0.0-alpha-2/maven-resolver-transport-http-2.0.0-alpha-2.pom"
    ];
    hash = "sha256-6wsb+xzSApNmaFWdITAZU4PfP24i43ddOPW5qbJv4Do=";
    installPath = "https/repo1.maven.org/maven2/org/apache/maven/resolver/maven-resolver-transport-http/2.0.0-alpha-2";
  };

  "org.apache.maven.resolver_maven-resolver-util-2.0.10" = fetchMaven {
    name = "org.apache.maven.resolver_maven-resolver-util-2.0.10";
    urls = [
      "https://repo1.maven.org/maven2/org/apache/maven/resolver/maven-resolver-util/2.0.10/maven-resolver-util-2.0.10.jar"
      "https://repo1.maven.org/maven2/org/apache/maven/resolver/maven-resolver-util/2.0.10/maven-resolver-util-2.0.10.pom"
    ];
    hash = "sha256-a1yw1lxiGTnb+l1diE1/zaDTAts8m88Nb6xrwLG/9fQ=";
    installPath = "https/repo1.maven.org/maven2/org/apache/maven/resolver/maven-resolver-util/2.0.10";
  };

}
