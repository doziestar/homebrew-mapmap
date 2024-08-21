class Mapmap < Formula
  desc "MapMap - Write your thoughts, ideas, and plans in a hierarchical tree diagram"
  homepage "https://github.com/ProPro-Productions/MapMap"
  version ""
  license "MIT"

  if OS.mac?
    if Hardware::CPU.intel?
      url "https://github.com/doziestar/homebrew-mapmap/raw/main/download/mapmap__x64.dmg"
      sha256 "e3e866883ae7edb8d0f7d5152ec4e974734ae27a1fc73714f014429006dc067e"
    elsif Hardware::CPU.arm?
      url "https://github.com/doziestar/homebrew-mapmap/raw/main/download/mapmap__aarch64.dmg"
      sha256 "26234fda624cdcb13f165b8e4f5fbd2cc7a8c595b355563cbcc618823aa8800c"
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
