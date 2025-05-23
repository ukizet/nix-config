{ pkgs, ... }:
let
  winePkg = pkgs.wineWowPackages.stable;
  wine = "${winePkg}/bin/wine64";
  so = "${pkgs.wineasio}/lib/wine/x86_64-unix/wineasio64.dll.so";
  dest = "$WINEPREFIX/drive_c/windows/system32/wineasio64.dll";
in {
  home.packages = [
    (pkgs.writeShellScriptBin "register-wineasio" ''
      cp -v ${so} ${dest}
      chmod +w ${dest}
      ${wine} regsvr32 ${so}
    '')
  ];
}
