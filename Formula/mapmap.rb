class Mapmap < Formula
  desc "MapMap - Write your thoughts, ideas, and plans in a hierarchical tree diagram"
  homepage "https://github.com/ProPro-Productions/MapMap"
  version "1.0.10"
  license "MIT"

  if OS.mac?
    if Hardware::CPU.intel?
      url "https://github.com/ProPro-Productions/MapMap/releases/download//mapmap_0.1.0_x64.dmg",
          headers: ["Authorization: token ${HOMEBREW_GITHUB_API_TOKEN}"]
      sha256 "0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"
    elsif Hardware::CPU.arm?
      url "https://github.com/ProPro-Productions/MapMap/releases/download//mapmap_0.1.0_aarch64.dmg",
          headers: ["Authorization: token ${HOMEBREW_GITHUB_API_TOKEN}"]
      sha256 "0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"
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

      Note: This formula requires a GitHub token with repo access to download the application.
      Please set the HOMEBREW_GITHUB_API_TOKEN environment variable before installing.
    EOS
  end

  test do
    assert_predicate "#{prefix}/MapMap.app/Contents/MacOS/mapmap", :exist?
  end
end
