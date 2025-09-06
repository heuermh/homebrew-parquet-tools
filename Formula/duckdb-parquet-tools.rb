class DuckdbParquetTools < Formula
  desc "Apache Parquet format tools for DuckDB"
  homepage "https://github.com/heuermh/duckdb-parquet-tools"
  url "https://search.maven.org/remotecontent?filepath=com/github/heuermh/duckdb/duckdb-parquet-tools/1.2.1/duckdb-parquet-tools-1.2.1-bin.tar.gz"
  sha256 "0d6861dbb08a8135e65338a40894d0b7e5b5c94d6dd6abd376beb238dbf64293"
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
