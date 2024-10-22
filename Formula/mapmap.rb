class Mapmap < Formula
  desc "MapMap - Write your thoughts, ideas, and plans in a hierarchical tree diagram"
  homepage "https://github.com/ProPro-Productions/MapMap"
  license "MIT"

  ARM_DMG_URL="https://github.com/doziestar/homebrew-mapmap/raw/main/download/MapMap_0.1.4_arm64.dmg"
  INTER_DMG_URL="https://github.com/doziestar/homebrew-mapmap/raw/main/download/MapMap_0.1.1_x86.dmg"

  if OS.mac?
    if Hardware::CPU.intel?
      url ARM_DMG_URL
      sha256 "df92fce80efc4ceb8a8e3c7e8d0b17c7378e7ce5bdd8113062d2a04fd5f1d8b7"
    elsif Hardware::CPU.arm?
      url INTER_DMG_URL
      sha256 "df92fce80efc4ceb8a8e3c7e8d0b17c7378e7ce5bdd8113062d2a04fd5f1d8b7"
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
