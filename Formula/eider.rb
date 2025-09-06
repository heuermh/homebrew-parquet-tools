class Eider < Formula
  desc "Command line tools for DuckDB"
  homepage "https://github.com/heuermh/eider"
  url "https://search.maven.org/remotecontent?filepath=com/github/heuermh/eider/eider/0.2/eider-0.2-bin.tar.gz"
  sha256 "d22f7a65375cbcf15efd27dcfcdaa1959f61d14e25396d4864d326d0d2297ef3"
  license "Apache-2.0"

  depends_on "openjdk"

  def install
    rm Dir["bin/*.bat"] # Remove all windows files
    libexec.install Dir["*"]
    Dir["#{libexec}/bin/*"].each do |exe|
      name = File.basename(exe)
      (bin/name).write <<~EOS
        #!/bin/bash
        export JAVA_HOME="${JAVA_HOME:-#{Formula["openjdk"].opt_prefix}}"
        exec "#{exe}" "$@"
      EOS
    end
  end

  test do
    assert_match "usage", shell_output("#{bin}/eider --help")
  end
end
