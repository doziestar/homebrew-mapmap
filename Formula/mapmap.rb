class Mapmap < Formula
  desc "MapMap - Hierarchical mind mapping and note-taking application"
  homepage "https://github.com/ProPro-Productions/MapMap"
  license "MIT"

  version "0.9.12"

  if Hardware::CPU.intel?
    url ""
    sha256 ""
  elsif Hardware::CPU.arm?
    url "https://mapmap-prod.s3.us-east-1.amazonaws.com/releases/v0.9.12/darwin-aarch64/MapMap_0.9.12_darwin-aarch64.app.tar.gz"
    sha256 ""
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
