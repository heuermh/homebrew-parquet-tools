class Cooper < Formula
  desc "Command line tools for AWS s3"
  homepage "https://github.com/heuermh/cooper"
  url "https://search.maven.org/remotecontent?filepath=com/github/heuermh/cooper/cooper/0.7/cooper-0.7-bin.tar.gz"
  sha256 "1b07485d3de20c077dd46d6546c1f0d05b68b1ee28c6f48702995d194d6644f7"
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
