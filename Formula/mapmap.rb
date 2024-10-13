class Mapmap < Formula
  desc "MapMap - Write your thoughts, ideas, and plans in a hierarchical tree diagram"
  homepage "https://github.com/ProPro-Productions/MapMap"
  license "MIT"

  ARM_DMG_URL="https://github.com/doziestar/homebrew-mapmap/raw/main/download/MapMap_0.1.3_arm64.dmg"
  INTER_DMG_URL="https://github.com/doziestar/homebrew-mapmap/raw/main/download/MapMap_0.1.3_arm64.dmg"

  if OS.mac?
    if Hardware::CPU.intel?
      url ARM_DMG_URL
      sha256 "1ad2f3f9306a07cedd31251f92c88da3bd2c46baff45a4d279d2742491b7b26e"
    elsif Hardware::CPU.arm?
      url INTER_DMG_URL
      sha256 "1ad2f3f9306a07cedd31251f92c88da3bd2c46baff45a4d279d2742491b7b26e"
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
