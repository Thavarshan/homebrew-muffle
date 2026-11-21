class Muffle < Formula
  desc "Suppress successful command output and show failure details"
  homepage "https://github.com/Thavarshan/muffle"
  url "https://github.com/Thavarshan/muffle/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "1a4ac1b0acce5252e47494d7e0101707d53dbcb3b0f79d69532d6eb9bc6fbd77"
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
    assert_match "muffle 0.1.0", shell_output("#{bin}/muffle --version")
    output = shell_output(
      "#{bin}/muffle -- sh -c 'echo expected-failure; exit 42' 2>&1", 42
    )
    assert_match "expected-failure", output
    assert_match "Log: ", output
  end
end
