class Cooper < Formula
  desc "Command line tools for AWS s3"
  homepage "https://github.com/heuermh/cooper"
  url "https://search.maven.org/remotecontent?filepath=com/github/heuermh/cooper/cooper/0.3/cooper-0.3-bin.tar.gz"
  sha256 "eea086eae54fbcf39cb344fd0ca8b89793f7e2f9d7cff1efabdff60c10af2fbc"
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
    assert_match "usage", shell_output("#{bin}/cooper --help")
  end
end
