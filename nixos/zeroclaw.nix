{
  lib,
  rustPlatform,
  fetchFromGitHub,
  pkg-config,
  protobuf,
  sqlite,
  zstd,
}:
rustPlatform.buildRustPackage (finalAttrs: {
  pname = "zeroclaw";
  version = "0.5.0";

  src = fetchFromGitHub {
    owner = "zeroclaw-labs";
    repo = "zeroclaw";
    tag = "v${finalAttrs.version}";
    hash = "sha256-RlliRnf9RLIbzWh3WRIvicie8mOPN0uimiiFbFD6+tQ=";
  };

  cargoHash = "sha256-tvT2+hPZpBBkYS1cnkNSzJiV2S2Z6RnhLZDkEYvOvgc=";

  doCheck = false;
  nativeBuildInputs = [
    pkg-config
    protobuf
  ];

  buildInputs = [
    sqlite
    zstd
  ];

  env = {
    ZSTD_SYS_USE_PKG_CONFIG = true;
  };

  meta = {
    description = "Fast, small, and fully autonomous AI assistant infrastructure — deploy anywhere, swap anything";
    homepage = "https://github.com/zeroclaw-labs/zeroclaw";
    changelog = "https://github.com/zeroclaw-labs/zeroclaw/blob/${finalAttrs.src.rev}/CHANGELOG.md";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [];
    mainProgram = "zeroclaw";
  };
})
