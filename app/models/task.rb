class Task < ApplicationRecord
    acts_as_paranoid
    belongs_to :user, :class_name => 'User' 
end
