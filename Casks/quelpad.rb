cask "quelpad" do
  version "0.10.1"
  sha256 "0c06f6ce7ee799da0c8b67c4613fd41b7c7085ed8148203908a94c74b74c42f7"

  url "https://updates.quelpad.dev/download/QuelPad_#{version}_aarch64.dmg"
  name "QuelPad"
  desc "TypeScript scratchpad for querying, transforming and charting databases"
  homepage "https://quelpad.com/"

  # Same manifest the in-app updater polls, so brew and the app never disagree
  # about what "latest" is.
  livecheck do
    url "https://updates.quelpad.dev/stable/latest.json"
    strategy :json do |json|
      json["version"]
    end
  end

  auto_updates true
  depends_on arch: :arm64
  depends_on :macos

  app "QuelPad.app"
  # The GUI binary doubles as the CLI (`quelpad run` / `schema` / `check` ...).
  binary "#{appdir}/QuelPad.app/Contents/MacOS/quelpad"

  # ~/QuelPad (the workspace) is user data and deliberately not listed.
  zap trash: [
    "~/Library/Application Support/com.quelpad.app",
    "~/Library/Caches/com.quelpad.app",
    "~/Library/Logs/com.quelpad.app",
    "~/Library/Preferences/com.quelpad.app.plist",
    "~/Library/Saved Application State/com.quelpad.app.savedState",
    "~/Library/WebKit/com.quelpad.app",
  ]
end
