PDFKit.configure do |config|
  # config.wkhtmltopdf = "C:\wkhtmltopdf\bin\wkhtmltopdf.exe"
  config.default_options = {
    quiet: true,
    print_media_type: true,
    # disable_smart_shrinking: true,
    margin_bottom: '10mm',
    margin_top: '10mm',
    margin_left: '10mm',
    margin_right: '10mm'
  }
  # config.root_url = "http://localhost" # Use only if your external hostname is unavailable on the server.
end

