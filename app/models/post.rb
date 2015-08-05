class Post < ActiveRecord::Base
  acts_as_votable
  validates :title, presence: true,
                    length: { minimum: 2 }

  has_many :comments , dependent: :destroy
  belongs_to :user 
    
  has_attached_file :image, :styles => { :medium => "300x300>" },
                    :storage => :s3,
                    :s3_host_name => 's3.amazonaws.com', 
                    :url =>':s3_domain_url',
                    :path => '/:class/:attachment/:id_partition/:style/:filename',
                    :s3_credentials => {
                    :bucket => ENV['AWS_BUCKET'],
                    :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
                    :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
                                        }

  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

end
