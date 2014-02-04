class Manuscript
  include Mongoid::Document

  embeds_many :authors

  field :code, type: String
  field :title, type: String
  field :status, type: String
  field :status_date, type: Date

  index({ code: 1 }, unique: true)

  class << self
    def find_by_code(code)
      where(code: code).first
    end
  end
end
