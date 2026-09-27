cask "quelpad" do
  version "0.9.9"
  sha256 "3821dc7229c823a0e572d4a484511181189cf38e8406ff611453b03d69320c54"

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
