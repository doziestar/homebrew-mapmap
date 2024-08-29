class Mapmap < Formula
  desc "MapMap - Write your thoughts, ideas, and plans in a hierarchical tree diagram"
  homepage "https://github.com/ProPro-Productions/MapMap"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.intel?
      url "https://github.com/doziestar/homebrew-mapmap/raw/main/download/MapMap_x64.dmg"
      sha256 "41f74b414cfb216595dd9eebcd310d31bb7d49d65012d008939d35b146a328ce"
    elsif Hardware::CPU.arm?
      url "https://github.com/doziestar/homebrew-mapmap/raw/main/download/MapMap_aarch64.dmg"
      sha256 "bee9daa5c87230140fac8de83addfe8131bbe85ea673ae01c6f94deaf45197ac"
    end
  else
    odie "Unsupported operating system"
  end

  def install
    prefix.install Dir["MapMap.app"]
    bin.write_exec_script "#{prefix}/MapMap.app/Contents/MacOS/mapmap"
  end

  def caveats
    <<~EOS
      MapMap has been installed at:
        #{prefix}

      To start MapMap, you can:
      1. Double click on MapMap.app in your Applications folder
      2. Run `mapmap` in your terminal
    EOS
  end

  test do
    assert_predicate "#{prefix}/MapMap.app/Contents/MacOS/mapmap", :exist?
  end
end
