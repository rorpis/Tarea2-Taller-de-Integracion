class Submission < ApplicationRecord
  acts_as_votable
  belongs_to :user
  has_many :comments

  def short_body(len = 500)
    	self.body.truncate(len)
  end

  def as_json(options={})
    super(:only => [:title,:lead],
    :methods => [:short_body]
    ).tap { |hash| hash["subtitle"] = hash.delete "lead" }
  end

end
