class Bon < Formula
  desc "Receipt-printer CLI for PDFs, images, Typst, and LaTeX"
  homepage "https://github.com/rbq/bon"
  url "https://github.com/rbq/bon/archive/refs/tags/v0.1.7.tar.gz"
  sha256 "c6a6e16fe1359b04a4d4786654a0aba7c7e8290b34bb3df38d8e44a02e658089"
  license "MIT"

  head "https://github.com/rbq/bon.git", branch: "main"

  depends_on "crystal" => :build
  depends_on "ghostscript"

  def install
    bin.mkpath
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
