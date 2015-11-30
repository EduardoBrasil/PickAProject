class User < ActiveRecord::Base

	# Get only filled inputs.
  validates :name, presence: true
  validates :email, presence: true

	# Downcase email string before save.
	before_save {	self.email = email.downcase }

	# Name size range.
	MAX_NAME_SIZE = 35 # Characters.
	MIN_NAME_SIZE = 4	 # Characters.
  validates :name, length: { in: MIX_NAME_SIZE..MAN_NAME_SIZE }

  # An regular expression used to validate user's email address.
  # There actually exists a full regex for matching email addresses 
  # according to the official email standard, but it’s enormous and weird.
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  # Get only a valid email address.
  validates :email, format: { with: VALID_EMAIL_REGEX }

  # Get only an uniqueness email address.
  # This validation is configured to be case-insensitive.
  validates :email, uniqueness: { case_sensitive: false }

	# Save a securely hashed password_digest attribute to the database.
	# A pair of virtual attributes: password, password_confirmation.
	# Include presence validation.
	# If password is correct, return user, false otherwise.
  has_secure_password

  # Password couldn't be blank
  validates :password, presence: true

  # Password size range.
  MAX_PASSWORD_SIZE = 20 # Characters
  MIN_PASSWORD_SIZE = 6	 # Characters
  validates :length { in: MIN_PASSWORD_SIZE..MAX_PASSWORD_SIZE }
end
