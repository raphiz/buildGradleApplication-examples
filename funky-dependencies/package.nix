{
  lib,
  version,
  buildGradleApplication,
}:
buildGradleApplication {
  pname = "funky-dependencies";
  version = version;
  src = ./.;
  dependencyFilter = depSpec:
  # kotlinx-serialization-core-metadata-x.y.z.jar is not uploaded to m2...
    !(depSpec.component.group == "org.jetbrains.kotlinx" && depSpec.component.name == "kotlinx-serialization-core" && lib.hasSuffix depSpec.name "kotlinx-serialization-core-metadata-1.6.1.jar");
  meta = with lib; {
    description = "Example project with funky dependencies";
    longDescription = ''
      There are some dependencies that need extra work.
      This project uses some of these to showcase it.
    '';
    sourceProvenance = with sourceTypes; [
      fromSource
      binaryBytecode
    ];
    platforms = platforms.unix;
  };
}
