{ stdenv, patchelf, makeWrapper

# Linked dynamic libraries.
, glib, fontconfig, freetype, pango, cairo, libX11, libXi, atk, gconf, nss, nspr
, libXcursor, libXext, libXfixes, libXrender, libXScrnSaver, libXcomposite, libxkbfile, libxcb
, alsaLib, libXdamage, libXtst, libXrandr, expat, cups
, dbus, gtk2, gtk3, gdk_pixbuf, gcc-unwrapped, at-spi2-atk
, kerberos

# command line arguments which are always set e.g "--disable-gpu"
, commandLineArgs ? ""

# Will crash without.
, systemd

# Loaded at runtime.
, libexif

# Additional dependencies according to other distros.
## Ubuntu
, liberation_ttf, curl, utillinux, xdg_utils, wget
## Arch Linux.
, flac, harfbuzz, icu, libpng, libopus, snappy, speechd
## Gentoo
, bzip2, libcap

# Which distribution channel to use.
, channel ? "unstable"

# Necessary for USB audio devices.
, pulseSupport ? true, libpulseaudio ? null

, gsettings-desktop-schemas
, gnome2, gnome3
}:

let

  mirror = https://repo.yandex.ru/yandex-browser/deb/pool/main/y/yandex-browser-beta;
  version = "19.1.0.2494-1";

deps = [
    glib fontconfig freetype pango cairo libX11 libXi atk gconf nss nspr
    libXcursor libXext libXfixes libXrender libXScrnSaver libXcomposite libxkbfile libxcb
    alsaLib libXdamage libXtst libXrandr expat cups
    dbus gdk_pixbuf gcc-unwrapped.lib
    systemd
    libexif
    liberation_ttf curl utillinux xdg_utils wget
    flac harfbuzz icu libpng opusWithCustomModes snappy speechd
    bzip2 libcap at-spi2-atk
    kerberos
  ] ++ optional pulseSupport libpulseaudio
    ++ [ gtk ];

  suffix = if channel != "unstable" then "-" + channel else "";

in stdenv.mkDerivation {

  name = "yandex-browser-${version}";

  src = fetchurl {
    url = "${mirror}/yandex-browser-beta_${version}_amd64.deb";
    sha256 = "8306A0347F92332DC96380065BE399C763DD5BA775AE53D76767478FD75C3415";
  };

  unpackCmd = "${dpkg}/bin/dpkg-deb -x $curSrc .";

  installPhase = ''
    mkdir --parent $out
    mv * $out/
    mv $out/opt/*/browser-beta/lib/*.so $out/lib/
  '';

  postFixup = ''
    find $out -executable -type f \
    | while read f
      do
        patchelf \
          --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" \
          --set-rpath "$out/lib:${rpath}" \
          "$f"
      done
  '';

  meta = {
    homepage = http://www.yandex.ru;
    description = "Web browser";
    platforms = [ "x86_64-linux" ];
    license = stdenv.lib.licenses.unfree;
  };
}
