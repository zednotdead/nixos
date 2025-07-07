{
  lib,
  fetchFromGitHub,
  hyprland,
  hyprlandPlugins,
  pkg-config,
}:
hyprlandPlugins.mkHyprlandPlugin hyprland {
  pluginName = "hyprNStack";
  version = "1959ecbc50071e5e182b6ce0edff92245870caf1";

  src = fetchFromGitHub {
    owner = "zakk4223";
    repo = "hyprNStack";
    rev = "1959ecbc50071e5e182b6ce0edff92245870caf1";
    hash = "sha256-LL1+gGBQcb+P0hiCGhHKDIhy7+UqwUBmU+kh0YQTYI0=";
  };

  # Native build tools required for the plugin
  nativeBuildInputs = [pkg-config]; # nie jestem tego pewnien czy to jest potrzebne

  # Set additional build inputs if required
  # Hyprland and its dependencies are included by default
  buildInputs = [];

  buildPhase = ''
    make all
  '';

  installPhase = ''
    runHook preInstall
    mkdir -p $out/lib
    cp nstackLayoutPlugin.so $out/lib/libhyprNStack.so
    runHook postInstall
  '';

  # Metadata about the plugin
  meta = {
    homepage = "https://github.com/zakk4223/hyprNStack";
    description = "Hyprland plugin for N-stack layout";
    license = lib.licenses.mit;
    platforms = lib.platforms.linux;
  };
}
