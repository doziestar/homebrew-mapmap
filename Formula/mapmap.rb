class Mapmap < Formula
  desc "MapMap - Write your thoughts, ideas, and plans in a hierarchical tree diagram"
  homepage "https://github.com/ProPro-Productions/MapMap"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.intel?
      url "https://github.com/doziestar/homebrew-mapmap/raw/main/download/MapMap_x64.dmg"
      sha256 "f6f0f002f7faad17cc85c76b9e7cd35b8e646cdb450fdd24bc10af08e2779691"
    elsif Hardware::CPU.arm?
      url "https://github.com/doziestar/homebrew-mapmap/raw/main/download/MapMap_aarch64.dmg"
      sha256 "b1721443fd36934f347bde089f7230369a58aa37ef0ed1cac7e8409b89124d6d"
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
