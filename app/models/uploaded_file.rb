class UploadedFile < ApplicationRecord
  belongs_to :user
  has_one_attached :file
  
  validates :title, presence: true
  validates :description, presence: true
  validates :file, presence: true, 
                  size: { less_than: 1.gigabytes, message: 'must be less than 1GB' }
  
  before_save :detect_file_type
  
  def generate_share_token
    return if share_token.present?
    loop do
      token = SecureRandom.alphanumeric(6)
      unless UploadedFile.exists?(share_token: token)
        update(share_token: token)
        break
      end
    end
    share_token
  end

  def revoke_share_token
    update(share_token: nil)
  end
  
  private
  
  def detect_file_type
    self.content_type = file.blob.content_type if file.attached?
  end
end