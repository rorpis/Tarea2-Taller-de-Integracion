class Submission < ApplicationRecord
  acts_as_votable
  #belongs_to :user
  has_many :comments

  validates :title, presence: true
  validates_length_of :title, :maximum => 200
  validates_length_of :lead, :maximum => 200
  validates :body, presence: true

  def short_body(len = 500)
    	self.body.truncate(len)
  end

  def as_json(options={})
    super(:only => [:title,:lead, :id, :created_at],
    :methods => [:short_body]
    ).tap { |hash|
      hash["subtitle"] = hash.delete "lead"
      hash["body"] = hash.delete "short_body" if hash["short_body"]
    }
  end

end
