Manuscript.create(code: 'AA1001', title: 'My awesome paper', status: 'WITH_AUTHOR', :status_date => Date.parse('01Jan2014')) do |m|
  m.authors << Author.new(last_name: 'Smith')
  m.authors << Author.new(last_name: 'Li')
  m.authors << Author.new(last_name: 'Jones')
end
