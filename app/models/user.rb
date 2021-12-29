class User < ApplicationRecord

    has_many :user_stocks
    has_many :stocks, through: :user_stocks
    
    has_many :friendships
    has_many :friends, through: :friendships

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
    
    def stock_already_tracked?(ticker_symbol)
      stock = Stock.check_db(ticker_symbol)
      return false unless stock
      stocks.where(id: stock.id).exists?
    end

    def under_stock_limit?
      stocks.count < 10
    end

    def can_track_stock?(ticker_symbol)
      under_stock_limit? && !stock_already_tracked?(ticker_symbol)
    end

    def full_name
      return "#{first_name} #{last_name}" if first_name || last_name
      "Anonymus"
    end

  #this method will search the user in database and return to_send_back var. in which all the users matched with given param is present
    def self.search(param)
      param.strip!
      to_send_back = (first_name_matches(param) + last_name_matches(param) + email_matches(param)).uniq
      return nil unless to_send_back
      to_send_back 
    end
    
    #these 3 methods will check the database in on the basis of email first name and last name 
    def self.first_name_matches(param)
      matches('first_name', param)
    end

    def self.last_name_matches(param)
      matches('last_name', param)
    end

    def self.email_matches(param)
      matches('email', param)
    end

    #This method is used to query the database by taking the matching parameter and the actual param.
    def self.matches(field_name, param)
      User.where("#{field_name} like ?", "%#{param}%")
    end

    def except_current_user(users)
      users.reject { |user| user.id == self.id }
    end
end
