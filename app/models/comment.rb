class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :submission
  #validates :title, presence:true
end
