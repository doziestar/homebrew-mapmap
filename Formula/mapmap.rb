class Mapmap < Formula
  desc "MapMap - Write your thoughts, ideas, and plans in a hierarchical tree diagram"
  homepage "https://github.com/ProPro-Productions/MapMap"
  license "MIT"

  version "0.9.2"

  if OS.mac?
    elsif Hardware::CPU.arm?
      url "https://github.com/doziestar/homebrew-mapmap/raw/main/download/darwin-aarch64/MapMap_#{version}_darwin-aarch64.app.tar.gz"
      sha256 "69ddd9516fb79e8f24be26d503ebb7b19150f52328eb9d1992c833f104d89cb7"
    end
  else
    odie "Unsupported operating system. MapMap is currently only available for macOS."
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
      MapMap has been installed at:
        #{prefix}

      To start MapMap, you can:
      1. Use Spotlight search or find MapMap.app in your Applications folder
      2. Run `mapmap` in your terminal

      The app may need to be authorized in System Preferences > Security & Privacy
      on first launch due to Apple requirements.
    EOS
  end

  test do
    app_bundle = Dir["#{prefix}/*.app"].first
    assert_predicate Pathname.new(app_bundle), :exist?, "MapMap.app should be installed"
    executable = "#{app_bundle}/Contents/MacOS/mapmap"
    assert_predicate Pathname.new(executable), :exist?, "Main executable should exist"
  end
end
