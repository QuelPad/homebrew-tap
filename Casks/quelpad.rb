cask "quelpad" do
  version "0.9.12"
  sha256 "8c69fe69c20c4843051cfd02170c317f3f97c7ef83d912fce1311c345ad17195"

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
