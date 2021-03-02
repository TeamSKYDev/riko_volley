class Omake < ApplicationRecord
  def self.creator_response(word)
    Omake.find_by(["key_word LIKE ?", "%#{word}%"]).response
  end
end
