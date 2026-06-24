class Bon < Formula
  desc "Receipt-printer CLI for PDFs, images, Typst, and LaTeX"
  homepage "https://github.com/rbq/bon"
  url "https://github.com/rbq/bon/archive/refs/tags/v0.1.11.tar.gz"
  sha256 "a77efeacdcf825a726e8d238b7c93fc1f852329634c1e24bf3952b791264fc3f"
  license "MIT"

  head "https://github.com/rbq/bon.git", branch: "main"

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
