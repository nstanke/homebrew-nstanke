class ZimWiki < Formula
  desc "Graphical text editor used to maintain a collection of wiki pages"
  homepage "https://zim-wiki.org/"
  version "0.72.1"
  url "https://github.com/jaap-karssenberg/zim-desktop-wiki/archive/0.72.1.tar.gz"
  sha256 "ba02e418b4fb1d7847f96b49ada8c917c881a28bb5fb55dcdca54be7b3fd196a"
  head "https://github.com/jaap-karssenberg/zim-desktop-wiki.git"
  

  depends_on "pkg-config" => :build
  depends_on "adwaita-icon-theme"
  depends_on "graphviz"
  depends_on "gtk+3"
  depends_on "gtksourceview3"
  depends_on "pygobject3"
  depends_on "python@3.8"

  resource "pyxdg" do
    url "https://files.pythonhosted.org/packages/47/6e/311d5f22e2b76381719b5d0c6e9dc39cd33999adae67db71d7279a6d70f4/pyxdg-0.26.tar.gz"
    sha256 "fe2928d3f532ed32b39c32a482b54136fe766d19936afc96c8f00645f9da1a06"
  end

  def install
    ENV.prepend_create_path "PYTHONPATH", libexec/"lib/python3.8/site-packages"
    resource("pyxdg").stage do
      system "python", *Language::Python.setup_install_args(libexec/"vendor")
    end
    ENV["XDG_DATA_DIRS"] = libexec/"share"
    ENV.prepend_create_path "PYTHONPATH", libexec/"lib/python3.8/site-packages"
    system "python3.8", "./setup.py", "install", "--prefix=#{libexec}"
    bin.install Dir[libexec/"bin/*"]
    bin.env_script_all_files libexec/"bin", :PYTHONPATH => ENV["PYTHONPATH"], :XDG_DATA_DIRS => ["#{HOMEBREW_PREFIX}/share", libexec/"share"].join(":")
    pkgshare.install "zim"
  end

end
