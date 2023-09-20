{
  lib,
  version,
  buildGradleApplication,
}:
buildGradleApplication {
  pname = "spring-boot";
  version = version;
  src = ./.;
  meta = with lib; {
    description = "Spring Boot Example Application";
    longDescription = ''
      Will start a server at Port 8080
    '';
    sourceProvenance = with sourceTypes; [
      fromSource
      binaryBytecode
    ];
    platforms = platforms.unix;
  };
}
