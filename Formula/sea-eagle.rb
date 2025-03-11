class SeaEagle < Formula
  desc "Command line tools for AWS Athena"
  homepage "https://github.com/heuermh/sea-eagle"
  url "https://search.maven.org/remotecontent?filepath=com/github/heuermh/seaeagle/sea-eagle/0.8/sea-eagle-0.8-bin.tar.gz"
  sha256 "15cb8e17a19ee94148e2d3dc503d976e96ab39b52ca31f016f8df02b5b1e37dc"
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
    assert_match "usage", shell_output("#{bin}/sea-eagle --help")
  end
end
