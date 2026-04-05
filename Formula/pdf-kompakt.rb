class PdfKompakt < Formula
  desc "Interactive PDF compression tool"
  homepage "https://github.com/xronocode/kompakt"
  url "https://github.com/xronocode/kompakt/archive/v0.1.0.tar.gz"
  sha256 "15358c6074d1acc67fdf080cbc80112c70515f2c9a8f38c69135727cd57ac735"
  license "MIT"

  depends_on "python@3.12"
  depends_on "ghostscript" => :recommended

  resource "pypdf" do
    url "https://files.pythonhosted.org/packages/source/p/pypdf/pypdf-5.4.0.tar.gz"
    sha256 "9af476a9dc30fcb137659b0dec747ea94aa954933c52cf02ee33e39a16fe9175"
  end

  def install
    venv = virtualenv_create(libexec, "python3.12")
    venv.pip_install resources
    bin.install "pdf_compress.py" => "pdf-kompakt"
    # Fix shebang to use the virtualenv python
    inreplace bin/"pdf-kompakt", "#!/usr/bin/env python3", "#!#{libexec}/bin/python3"
  end

  test do
    assert_match "pdf_compress", shell_output("#{bin}/pdf-kompakt --help")
  end
end
