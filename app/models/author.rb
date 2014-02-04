class Author
  include Mongoid::Document

  embedded_in :manuscript

  field :last_name, type: String
end
