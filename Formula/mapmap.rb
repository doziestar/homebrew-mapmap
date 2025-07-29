class Mapmap < Formula
  desc "MapMap - Hierarchical mind mapping and note-taking application"
  homepage "https://github.com/ProPro-Productions/MapMap"
  license "MIT"

  version "1.0.0"

  url "https://mapmap-prod.s3.us-east-1.amazonaws.com/releases/v1.0.0/darwin-aarch64/MapMap_1.0.0_darwin-aarch64.app.tar.gz"
  sha256 "7b62b860bc990d1c1323bf079ff81f294274d68e88c68d7f7e3036daeca598eb"

  # Note: This build is optimized for Apple Silicon but works on Intel Macs via Rosetta

  def install
    system "tar", "-xzf", cached_download
    app_bundle = Dir["*.app"].first
    if app_bundle.nil?
      odie "MapMap.app not found in the downloaded archive"
    end
    # Install to Applications folder
    applications_dir = "/Applications"
    # Check if we can write to /Applications, otherwise use ~/Applications
    unless File.writable?(applications_dir)
      applications_dir = File.expand_path("~/Applications")
      Dir.mkdir(applications_dir) unless Dir.exist?(applications_dir)
    end
    # Copy the app to Applications
    system "cp", "-R", app_bundle, applications_dir
    # Create a symlink in Homebrew prefix for the executable
    bin.install_symlink "#{applications_dir}/#{app_bundle}/Contents/MacOS/mapmap"
  end

  def caveats
    <<~EOS
      MapMap has been installed successfully!

      📱 App Location:
      • MapMap.app has been installed to your Applications folder
      • You can find it in Spotlight search or Applications folder

      🚀 How to start MapMap:
      • Double-click MapMap.app in Applications
      • Use Spotlight (Cmd+Space) and type "MapMap"
      • Run `mapmap` in your terminal

      🔒 First Launch:
      • The app may require authorization in System Preferences
      • Go to Security & Privacy > General and click "Allow"

      🔄 Automatic Updates:
      • MapMap will check for updates automatically
      • You will be notified when new versions are available
    EOS
  end

  test do
    # Check if app is installed in Applications
    applications_dir = "/Applications"
    unless File.writable?(applications_dir)
      applications_dir = File.expand_path("~/Applications")
    end
    app_bundle = "#{applications_dir}/MapMap.app"
    assert_predicate Pathname.new(app_bundle), :exist?
    executable = "#{app_bundle}/Contents/MacOS/mapmap"
    assert_predicate Pathname.new(executable), :exist?
  end
end
