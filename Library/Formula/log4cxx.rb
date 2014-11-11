require 'formula'

class Log4cxx < Formula
  homepage 'http://logging.apache.org/log4cxx/index.html'
  url 'http://www.apache.org/dyn/closer.cgi?path=logging/log4cxx/0.10.0/apache-log4cxx-0.10.0.tar.gz'
  sha1 'd79c053e8ac90f66c5e873b712bb359fd42b648d'

  depends_on :automake
  depends_on :libtool

  option :universal

  fails_with :llvm do
    build 2334
    cause "Fails with 'collect2: ld terminated with signal 11 [Segmentation fault]'"
  end

  def install
    ENV.universal_binary if build.universal?
    ENV.O2 # Using -Os causes build failures on Snow Leopard.

    # Fixes build error with clang, old libtool scripts. cf. #12127
    # Reported upstream here: https://issues.apache.org/jira/browse/LOGCXX-396
    # Remove at: unknown, waiting for developer comments.
    system './autogen.sh'
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          # Docs won't install on OS X
                          "--disable-doxygen"
    system "make install"
  end
end
