class Achievement < ApplicationRecord
  enum privacy: [:public_access, :private_access, :friend_access]
end
