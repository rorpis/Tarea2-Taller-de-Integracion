class Submission < ApplicationRecord
  acts_as_votable
  belongs_to :user
  has_many :comments

  def short_body(len = 500)
    	self.body.truncate(len)
  end

end
