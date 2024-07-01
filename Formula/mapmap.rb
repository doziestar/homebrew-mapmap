class Mapmap < Formula
  desc "MapMap - Write your thoughts, ideas, and plans in a hierarchical tree diagram"
  homepage "https://mapmap.app"
  url "https://api.github.com/repos/ProPro-Productions/MapMap/tarball/1.0.7"
  version "1.0.7"
  sha256 "025d36570c6b7eb99090fa40f99505da82b95dd6c5bb0292298627feda829690"
  depends_on "rust" => :build
  depends_on "node" => :build
  depends_on "yarn" => :build
  def install
    ENV["NODE_OPTIONS"] = "--max_old_space_size=4096"
    system "yarn", "install"
    cd "packages/client" do
      system "yarn", "install"
      system "yarn", "build"
      system "cargo", "install", "tauri-cli"
      system "cargo", "tauri", "build"
    end
    prefix.install Dir["packages/client/src-tauri/target/release/bundle/macos/MapMap.app"]
    bin.write_exec_script prefix/"MapMap.app/Contents/MacOS/mapmap"
  end
  test do
    assert_predicate prefix/"MapMap.app/Contents/MacOS/mapmap", :exist?
  end
end
