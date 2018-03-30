class Comment < ApplicationRecord
  #belongs_to :user
  belongs_to :submission

  validates :title, presence:true
  validates :body, presence: true

  def as_json(options={})
    super(:only => [:body, :created_at, :title, :id]
    ).tap { |hash|
            hash["author"] = hash.delete "title"
            hash["comment"] = hash.delete "body"
    }
  end

end
