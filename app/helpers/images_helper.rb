module ImagesHelper
  def type_specific_tag(file_path)
    # binding.pry
    if %w[.mp3].include?(File.extname(file_path))
      audio_tag(file_path, controls: true)
    elsif %w[.jpg .jpeg .png .gif].include?(File.extname(file_path))
      image_tag(file_path)
    end
  end
end
