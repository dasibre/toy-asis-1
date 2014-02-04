class AuthorizationService
  attr_reader :manuscript, :author_name

  class << self
    def accept?(manuscript, author_name)
      new(manuscript, author_name).accept?
    end
  end

  def initialize(manuscript, author_name)
    @manuscript, @author_name = manuscript, normalize(author_name)
  end

  def accept?
    return false if manuscript.nil? || author_name.length < 2
    author_names.first(3).any? { |name| author_name == name || author_name.length >= 3 && name.starts_with?(author_name) }
  end

  private

  def author_names
    manuscript.authors.map { |a| normalize(a.last_name) }
  end

  def normalize(s)
    s.to_s.strip.downcase
  end
end
