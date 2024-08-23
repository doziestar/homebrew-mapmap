class Mapmap < Formula
  desc "MapMap - Write your thoughts, ideas, and plans in a hierarchical tree diagram"
  homepage "https://github.com/ProPro-Productions/MapMap"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.intel?
      url "https://github.com/doziestar/homebrew-mapmap/raw/main/download/MapMap_x64.dmg"
      sha256 "ccd8e3c4776783e52b7000b19937b5f5995331ec8284d0bbd6282ea3988e990e"
    elsif Hardware::CPU.arm?
      url "https://github.com/doziestar/homebrew-mapmap/raw/main/download/MapMap_aarch64.dmg"
      sha256 "5356c9f68acfe1a7a09969f5ebef69ce9c2ad0521daf809ec77f30314213d632"
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
