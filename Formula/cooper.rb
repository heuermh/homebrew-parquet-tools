class Cooper < Formula
  desc "Command line tools for AWS s3"
  homepage "https://github.com/heuermh/cooper"
  url "https://search.maven.org/remotecontent?filepath=com/github/heuermh/cooper/cooper/0.8/cooper-0.8-bin.tar.gz"
  sha256 "8957f5b6f7e7534487b1c184e50fc6a41c1f1369ca5a1758ce1efa3da904829c"
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
    assert_match "usage", shell_output("#{bin}/coop --help")
  end
end
