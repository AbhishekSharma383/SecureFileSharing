class CompressFileJob < ApplicationJob
  queue_as :default
  require 'mini_magick'

  rescue_from(StandardError) do |exception|
    Rails.logger.error "File compression failed: #{exception.message}"
  end

  def perform(uploaded_file)
    return unless uploaded_file.file.attached?

    case uploaded_file.content_type
    when 'image/jpeg', 'image/png'
      compress_image(uploaded_file)
    when 'application/pdf'
      compress_pdf(uploaded_file)
    end
  end

  private

  def compress_image(uploaded_file)
    temp_file = downloaded_tempfile(uploaded_file)
    
    image = MiniMagick::Image.new(temp_file.path)
    image.strip # Remove EXIF data
    image.quality('80') # Reduce quality to 80%
    
    uploaded_file.file.attach(
      io: File.open(temp_file.path),
      filename: uploaded_file.file.filename,
      content_type: uploaded_file.content_type
    )
  ensure
    temp_file&.close
    temp_file&.unlink
  end

  def compress_pdf(uploaded_file)
    temp_file = downloaded_tempfile(uploaded_file)
    
    output_path = temp_file.path + '_compressed.pdf'
    system("gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/ebook -dNOPAUSE -dQUIET -dBATCH -sOutputFile=#{output_path} #{temp_file.path}")
    
    if File.exist?(output_path)
      uploaded_file.file.attach(
        io: File.open(output_path),
        filename: uploaded_file.file.filename,
        content_type: 'application/pdf'
      )
    end
  ensure
    temp_file&.close
    temp_file&.unlink
    File.delete(output_path) if File.exist?(output_path)
  end

  def downloaded_tempfile(uploaded_file)
    temp_file = Tempfile.new(['compressed', File.extname(uploaded_file.file.filename.to_s)])
    temp_file.binmode
    temp_file.write(uploaded_file.file.download)
    temp_file.rewind
    temp_file
  end
end