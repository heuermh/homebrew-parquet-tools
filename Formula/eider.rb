class Eider < Formula
  desc "Command line tools for DuckDB"
  homepage "https://github.com/heuermh/eider"
  url "https://search.maven.org/remotecontent?filepath=com/github/heuermh/eider/eider/0.3/eider-0.3-bin.tar.gz"
  sha256 "8e6e21fbe60719ff67eb7f7c8826b324291f20ddab6c97f66dfa1a19acb6e0e8"
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
