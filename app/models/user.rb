class User < ApplicationRecord

  has_secure_password

  validates :first_name, :last_name, :password_digest, :username, :email,  presence: true
  validates :username, uniqueness: true
  validates :email, uniqueness: true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }


  has_many :user_tokens, dependent: :destroy
  has_one :password_token, dependent:  :destroy

  has_and_belongs_to_many :teams

  def self.find_by_user_token(token)
    user_token = UserToken.find_by_token(token)
    if user_token
      return user_token.user
    else
      return nil
    end
  end

  def projects
    if admin
      return Project.all.order(:name)
    else
      projects = []
      self.teams.each do |t|
        projects.append(t.projects).flatten
      end
      return projects.uniq.flatten
    end
  end

  def user_teams
    if admin
      return Team.all
    else
      return teams
    end
  end

end
