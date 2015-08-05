class Post < ActiveRecord::Base
  acts_as_votable
  validates :title, presence: true,
                    length: { minimum: 2 }

  has_many :comments , dependent: :destroy
  belongs_to :user 
    
  has_attached_file :image, :styles => { :medium => "300x300>" }
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

end
