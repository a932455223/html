require 'formula'

class BdwGc < Formula
  homepage 'http://www.hpl.hp.com/personal/Hans_Boehm/gc/'
  url 'http://www.hpl.hp.com/personal/Hans_Boehm/gc/gc_source/gc-7.2d.tar.gz'
  sha1 'b43573800e27361da78f05a2e98394521cfa04fc'

  option :universal

  def install
    ENV.universal_binary if build.universal?
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--enable-cplusplus"
    system "make"
    system "make check"
    system "make install"
  end
end
