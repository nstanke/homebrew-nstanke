cask 'zim-app' do
  version :latest
  sha256 :no_check

  url 'https://github.com/jaap-karssenberg/zim-desktop-wiki/files/1568387/Zim.zip'
  name 'Zim'
  homepage 'http://zim-wiki.org'

  app 'Zim.app'
end

