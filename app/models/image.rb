module Comparison
  refine Numeric do
    def gt?(n)
      self > n
    end

    def gteq?(n)
      self >= n
    end

    def lt?(n)
      self < n
    end

    def lteq?(n)
      self <= n
    end
  end
end

class Image < ApplicationRecord
  using Comparison
  before_save :save_to_file
  before_destroy :destroy_saved_file

  # moving a file to uploaded files directory from temp directory
  def save_to_file
    return if already_moved_to_strage?

    filename = File.basename(path, '*.*')
    save_path = Rails.root.join('public', 'uploads/') + filename
    IO.binwrite(save_path, IO.binread(path))
    self.path = filename
  end

  def destroy_saved_file
    File.delete("#{Rails.root.join('public', 'uploads')}/#{path}")
  end

  private

  def already_moved_to_strage?
    # Temp uploaded file location : /tmp/RackMultipartyyymmdd-nnnnn-xxxxxxx.png
    # Managed file location : RackMultipartyyymmdd-nnnnn-xxxxxxx.png
    path.split(File::SEPARATOR).size.lteq?(2)
  end
end
