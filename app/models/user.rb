class User < ActiveRecord::Base
  
  # connecting the HAS MANY relationship to microposts.
  has_many :microposts, dependent: :destroy # arrage for dependent microposts
                                            # to be destroyed when the user is.
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  
  # we are using the nicer followed_users instead of user.followeds, which is the array
  # which Rails will auto-create. We use :source to define that the source of :followed_users
  # is actually :followed. See Listing 11.10, http://ruby.railstutorial.org/chapters/following-users#sec-the_relationship_model
  has_many :followed_users, through: :relationships, source: :followed
  
  
  ### Note the symmetry between these two has_many relationship couples!!

  # see Listing 11.16 http://ruby.railstutorial.org/chapters/following-users#sec-the_relationship_model  
  has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name: "Relationship",
                                   dependent: :destroy
  has_many :followers, through: :reverse_relationships, source: :follower
  
  
  
  
  
  # before_save { self.email = email.downcase } # a callback method.
                                                # where does self.email come from?
                                                # see migrate file create_users. 
  # alternate way of writing before_save:
  before_save { email.downcase! }    
  
  # create a remember_token for sessions.
  before_create :create_remember_token  # this is a method reference. Rails will
                                        # look for a method called create_remember_token.
  
  
  validates :name, presence: true, length: { maximum: 50 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  
  validates(  :email, 
              :presence => true,                      # aka presence: true
              format:     { with: VALID_EMAIL_REGEX }, 
              uniqueness: { case_sensitive: false })  # :uniqueness accepts 
                                                      #    option :case_sensitive
  # These are ALL equivalent!:
  # validates :email, presence: true
  # validates(:email, presence: true)
  # validates(:email, { presence: true })
  # validates(:email, { :presence => true })
   
   
  has_secure_password     # magic!!
  # has_secure_password adds password and password confirmation attributes, 
  # requires the presence of the password, require that they match, and add an 
  # authenticate method to compare an encrpyted password to the password_digest
  # to authenticate users. has_secure_password does all this, as long as there
  # is a password_digest column in the database.
  
  validates :password, length: { minimum: 6 }
  
  
  def feed
    Micropost.from_users_followed_by(self)
  end
  
  
  def following?(other_user)
    self.relationships.find_by(followed_id: other_user.id)
  end
  
  def follow!(other_user)
    self.relationships.create!(followed_id: other_user.id)
  end
  
  def unfollow!(other_user)
    self.relationships.find_by(followed_id: other_user.id).destroy!
  end
  
  
  
  ## SESSION METHODS ##
  
  def User.new_remember_token      # notice the syntax to make this a class method.
    SecureRandom.urlsafe_base64
  end
  
  def User.encrypt(token)          # also a class method.
    Digest::SHA1.hexdigest(token.to_s)
  end
  
  
  private
  
    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end
  
  
end