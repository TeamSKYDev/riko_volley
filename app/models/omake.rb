class Omake < ApplicationRecord
  def self.creator_response(word)
    omake = Omake.find_by(["key_word LIKE ?", "%#{word}%"])
    if omake.present?
      response = omake.response
    end
    return response
  end
end
