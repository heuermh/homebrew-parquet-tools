class SeaEagle < Formula
  desc "Command line tools for AWS Athena"
  homepage "https://github.com/heuermh/sea-eagle"
  url "https://search.maven.org/remotecontent?filepath=com/github/heuermh/seaeagle/sea-eagle/0.10/sea-eagle-0.10-bin.tar.gz"
  sha256 "861fca10d7ae9967b150aff596cf6a305468ab0bf593af26807ee3dab1a1fdc0"
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
    assert_match "usage", shell_output("#{bin}/se --help")
  end
end
