class Album < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  validates :title, :user_id, presence: true
  validates_length_of :title, maximum: 30, allow_blank: true

  validate :validate_image?

  private

  def validate_image?
    errors.add(:base, '画像ファイルを入力してください') unless image.attached?
  end
end
