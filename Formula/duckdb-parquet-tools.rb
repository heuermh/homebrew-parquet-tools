class DuckDbParquetTools < Formula
  desc "Apache Parquet format tools for DuckDB"
  homepage "https://github.com/heuermh/duckdb-parquet-tools"
  url "https://search.maven.org/remotecontent?filepath=com/github/heuermh/duckdb/duckdb-parquet-tools/1.0.7/duckdb-parquet-tools-1.0.7-bin.tar.gz"
  sha256 "29b40b271e06b0633f3e138e8d5ea4a5938a372643323e4293ad5a977a5161cb"
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
    assert_match "usage", shell_output("#{bin}/duckdb-parquet-tools --help")
  end
end
