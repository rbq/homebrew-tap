class Bon < Formula
  desc "Receipt-printer CLI for PDFs, images, Typst, and LaTeX"
  homepage "https://github.com/rbq/bon"
  url "https://github.com/rbq/bon/archive/refs/tags/v0.1.11.tar.gz"
  sha256 "a77efeacdcf825a726e8d238b7c93fc1f852329634c1e24bf3952b791264fc3f"
  license "MIT"

  head "https://github.com/rbq/bon.git", branch: "main"

  bottle do
    root_url "https://github.com/rbq/bon/releases/download/v0.1.11"
    rebuild 1
    sha256 cellar: :any, arm64_sequoia: "3e4547dccdec4b56e55527dd36179466556e48d6a7c76cd46a9e5c73d823dff6"
    sha256 cellar: :any, sequoia:       "25db019453162ba2f9b67a106f049f6f338d596a6d36b9c58bc5393bd17c15e4"
    sha256 cellar: :any, x86_64_linux:  "6697b046f28255798be5cd4c75a7edf8a795b36346c1b7913e229dd0b5031066"
  end

  depends_on "crystal" => :build
  depends_on "ghostscript"

  def install
    bin.mkpath
    system "shards", "install", "--production"
    system "crystal", "build", "src/bon.cr", "--release", "--no-debug", "-o", bin/"bon"
  end

  def caveats
    <<~EOS
      Typst output support requires Typst. Install it with:
        brew install typst

      LaTeX output support requires an external LaTeX engine such as latexmk, tectonic, or pdflatex.
    EOS
  end

  test do
    assert_match "bon #{version}", shell_output("#{bin}/bon --version")
  end
end
