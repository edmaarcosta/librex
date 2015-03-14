defmodule Librex do

  def convert(file_to_convert, pdf_file) do
    file_name_only = Path.basename(file_to_convert, Path.extname(file_to_convert))
    out_dir = System.tmp_dir! <> SecureRandom.uuid <> "/"
    run(file_to_convert, out_dir)
    temp_file = out_dir <> file_name_only <> ".pdf"
    File.cp! temp_file, pdf_file
    File.rm! temp_file
    File.rmdir! out_dir
  end

  defp run(file_to_convert, out_dir) do
    opts = ["--headless", "--convert-to","pdf", "--outdir", out_dir, file_to_convert]
    System.cmd("soffice", opts, stderr_to_stdout: true)
  end
end