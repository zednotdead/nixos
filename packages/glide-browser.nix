{ pkgs, ... }:
pkgs.stdenv.mkDerivation (finalAttrs: {
  pname = "glide-browser";
  version = "0.1.55a";

  src = pkgs.fetchurl {
    url = "https://github.com/glide-browser/glide/releases/download/${finalAttrs.version}/glide.linux-x86_64.tar.xz";
    hash = "sha256-mjk8KmB/T5ZpB9AMQw1mtb9VbMXVX2VV4N+hWpWkSYI=";
  };

  nativeBuildInputs = with pkgs; [
    # keep-sorted start
    autoPatchelfHook
    copyDesktopItems
    makeBinaryWrapper
    patchelfUnstable
    wrapGAppsHook3
    # keep-sorted end
  ];

  buildInputs = with pkgs; [
    # keep-sorted start
    adwaita-icon-theme
    alsa-lib
    dbus-glib
    gtk3
    hicolor-icon-theme
    # keep-sorted end
  ];

  runtimeDependencies = with pkgs; [
    # keep-sorted start
    curl
    libva.out
    pciutils
    # keep-sorted end
  ];

  appendRunpaths = [ "${pkgs.pipewire}/lib" ];

  # Firefox uses "relrhack" to manually process relocations from a fixed offset
  patchelfFlags = [ "--no-clobber-old-sections" ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin $out/share/icons/hicolor/ $out/lib/glide-browser-bin-${finalAttrs.version}
    cp -t $out/lib/glide-browser-bin-${finalAttrs.version} -r *
    chmod +x $out/lib/glide-browser-bin-${finalAttrs.version}/glide
    iconDir=$out/share/icons/hicolor
    browserIcons=$out/lib/glide-browser-bin-${finalAttrs.version}/browser/chrome/icons/default

    for i in 16 32 48 64 128; do
      iconSizeDir="$iconDir/''${i}x$i/apps"
      mkdir -p $iconSizeDir
      cp $browserIcons/default$i.png $iconSizeDir/glide-browser.png
    done


    ln -s $out/lib/glide-browser-bin-${finalAttrs.version}/glide $out/bin/glide
    ln -s $out/bin/glide $out/bin/glide-browser

    runHook postInstall
  '';

  desktopItems = [
    (pkgs.makeDesktopItem {
      name = "glide-browser-bin";
      exec = "glide-browser --name glide-browser %U";
      icon = "glide-browser";
      desktopName = "Glide Browser";
      genericName = "Web Browser";
      terminal = false;
      startupNotify = true;
      startupWMClass = "glide-browser";
      categories = [
        "Network"
        "WebBrowser"
      ];
      mimeTypes = [
        "text/html"
        "text/xml"
        "application/xhtml+xml"
        "application/vnd.mozilla.xul+xml"
        "x-scheme-handler/http"
        "x-scheme-handler/https"
      ];
      actions = {
        new-window = {
          name = "New Window";
          exec = "glide-browser --new-window %U";
        };
        new-private-window = {
          name = "New Private Window";
          exec = "glide-browser --private-window %U";
        };
        profile-manager-window = {
          name = "Profile Manager";
          exec = "glide-browser --ProfileManager";
        };
      };
    })
  ];

  passthru.updateScript = pkgs.nix-update-script {
    extraArgs = [
      "--url"
      "https://github.com/glide-browser/glide"
    ];
  };

  meta = {
    changelog = "https://glide-browser.app/changelog#${finalAttrs.version}";
    description = "Extensible and keyboard-focused web browser, based on Firefox (binary package)";
    homepage = "https://glide-browser.app/";
    platforms = [ "x86_64-linux" ];
    mainProgram = "glide-browser";
  };
})
