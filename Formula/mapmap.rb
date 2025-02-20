class Mapmap < Formula
  desc "MapMap - Write your thoughts, ideas, and plans in a hierarchical tree diagram"
  homepage "https://github.com/ProPro-Productions/MapMap"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.intel?
      url "https://github.com/doziestar/homebrew-mapmap/raw/main/download/MapMap_latest_x86.dmg"
      sha256 "d07562d9f5ce2ec0f242f03239fe365c5fc0ae7ba259e196afcf5a926fa4d87d"
    elsif Hardware::CPU.arm?
      url "https://github.com/doziestar/homebrew-mapmap/raw/main/download/MapMap_latest_arm64.dmg"
      sha256 "d07562d9f5ce2ec0f242f03239fe365c5fc0ae7ba259e196afcf5a926fa4d87d"
    end
  else
    odie "Unsupported operating system"
  end

  def install
    system "hdiutil", "attach", cached_download, "-nobrowse"

    app_path = "/Volumes/MapMap/MapMap.app"
    if File.exist?(app_path)
      prefix.install Dir["#{app_path}"]
    else
      odie "MapMap.app not found in the mounted DMG"
    end

    system "hdiutil", "detach", "/Volumes/MapMap"

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
