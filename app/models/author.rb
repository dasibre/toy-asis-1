class Author
  include Mongoid::Document

  embedded_in :manuscript

  field :publish_name, type: String
end
