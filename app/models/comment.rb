class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :submission
  #validates :title, presence:true

  def as_json(options={})
    super(:only => [:body, :created_at, :title]
    ).tap { |hash| hash["author"] = hash.delete "title" }
  end

end
