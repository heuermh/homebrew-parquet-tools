class Cooper < Formula
  desc "Command line tools for AWS s3"
  homepage "https://github.com/heuermh/cooper"
  url "https://search.maven.org/remotecontent?filepath=com/github/heuermh/cooper/cooper/0.6/cooper-0.6-bin.tar.gz"
  sha256 "de1005c7c77ed1ab8f3d495b769e5ac9f402d14be795b6bd5059f793ab014e22"
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
