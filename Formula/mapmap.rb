class Mapmap < Formula
  desc "MapMap - Write your thoughts, ideas, and plans in a hierarchical tree diagram"
  homepage "https://github.com/ProPro-Productions/MapMap"
  version "1.0.8"
  license "MIT"

  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/ProPro-Productions/MapMap/releases/download/v/mapmap__x64.dmg"
    sha256 "0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://github.com/ProPro-Productions/MapMap/releases/download/v/mapmap__aarch64.dmg"
    sha256 "0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"
  else
    odie "Unsupported architecture"
  end

  app "MapMap.app"

  def caveats
    <<~EOS
      MapMap has been installed at:
        #{opt_prefix}

      To start MapMap, you can:
      1. Double click on MapMap.app in your Applications folder
      2. Run `mapmap` in your terminal
    EOS
  end

  test do
    assert_predicate "#{appdir}/MapMap.app/Contents/MacOS/mapmap", :exist?
  end
end
