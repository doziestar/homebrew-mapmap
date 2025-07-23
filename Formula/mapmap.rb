class Mapmap < Formula
  desc "MapMap - Hierarchical mind mapping and note-taking application"
  homepage "https://github.com/ProPro-Productions/MapMap"
  license "MIT"

  version "0.9.14"

  if Hardware::CPU.intel?
    url "https://mapmap-prod.s3.us-east-1.amazonaws.com/releases/v0.9.14/darwin-x86_64/MapMap_0.9.14_darwin-x86_64.app.tar.gz"
    sha256 "5d6dbefcc36a3c3d39244c23d591cd79d3a32d6ddcc7d976d7a90bab7cbefc99"
  elsif Hardware::CPU.arm?
    url "https://mapmap-prod.s3.us-east-1.amazonaws.com/releases/v0.9.14/darwin-aarch64/MapMap_0.9.14_darwin-aarch64.app.tar.gz"
    sha256 "094bcea325c06af42c9f6311af8007d0e2fd09cbcaa998b560fe78c246583511"
  else
    odie "Unsupported architecture. MapMap requires Intel or Apple Silicon."
  end

  def install
    system "tar", "-xzf", cached_download
    app_bundle = Dir["*.app"].first
    if app_bundle.nil?
      odie "MapMap.app not found in the downloaded archive"
    end
    prefix.install app_bundle
    bin.write_exec_script "#{prefix}/#{app_bundle}/Contents/MacOS/mapmap"
  end

  def caveats
    <<~EOS
      MapMap has been installed successfully!

      To start MapMap:
      • Use Spotlight search or find MapMap.app in Applications
      • Run `mapmap` in your terminal

      Note: The app may require authorization in System Preferences
      > Security & Privacy on first launch (Apple requirement).

      Automatic updates: MapMap will check for updates automatically
      and notify you when new versions are available.
    EOS
  end

  test do
    app_bundle = Dir["#{prefix}/*.app"].first
    assert_predicate Pathname.new(app_bundle), :exist?
    executable = "#{app_bundle}/Contents/MacOS/mapmap"
    assert_predicate Pathname.new(executable), :exist?
  end
end
