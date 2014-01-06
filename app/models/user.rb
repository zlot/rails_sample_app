class User < ActiveRecord::Base
  
  # before_save { self.email = email.downcase } # a callback method.
                                               # where does self.email come from?
                                               # see migrate file create_users. 
  # alternate way of writing before_save:
  before_save { email.downcase! }    
  
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
end