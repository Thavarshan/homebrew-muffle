class Muffle < Formula
  desc "Suppress successful command output and show failure details"
  homepage "https://github.com/Thavarshan/muffle"
  url "https://github.com/Thavarshan/muffle/archive/refs/tags/v0.1.2.tar.gz"
  sha256 "14da66c1f20f90dd5d4e3e5c02c15dbfe5f2bcdecb5202c01b793c602f969eee"
  license "MIT"

  depends_on "cmake" => :build

  def install
    system "cmake", "-S", ".", "-B", "build",
           "-DCMAKE_BUILD_TYPE=Release",
           "-DCMAKE_INSTALL_PREFIX=#{prefix}"
    system "cmake", "--build", "build", "--parallel", "2"
    system "cmake", "--install", "build"
  end

  test do
    assert_match "muffle 0.1.2", shell_output("#{bin}/muffle --version")
    output = shell_output(
      "#{bin}/muffle -- sh -c 'echo expected-failure; exit 42' 2>&1", 42
    )
    assert_match "expected-failure", output
    assert_match "Log: ", output
  end
end
