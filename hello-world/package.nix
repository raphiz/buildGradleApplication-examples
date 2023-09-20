{
  lib,
  version,
  buildGradleApplication,
}:
buildGradleApplication {
  pname = "hello-world";
  version = version;
  src = ./.;
  meta = with lib; {
    description = "Hello World Application";
    longDescription = ''
      Not much to say here...
    '';
    sourceProvenance = with sourceTypes; [
      fromSource
      binaryBytecode
    ];
    platforms = platforms.unix;
  };
}
