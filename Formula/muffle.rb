class Muffle < Formula
  desc "Suppress successful command output and show failure details"
  homepage "https://github.com/Thavarshan/muffle"
  url "https://github.com/Thavarshan/muffle/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "ab908cd4f939ef5b12edd38f97af8400711bb52d267bee334c82ccc34decae2b"
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
    assert_match "muffle 0.1.1", shell_output("#{bin}/muffle --version")
    output = shell_output(
      "#{bin}/muffle -- sh -c 'echo expected-failure; exit 42' 2>&1", 42
    )
    assert_match "expected-failure", output
    assert_match "Log: ", output
  end
end
