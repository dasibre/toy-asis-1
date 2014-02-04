toy-asis
========

Toy Author Status Inquiry System - A coding exercise for software developer candidates

### Requirements

* A MongoDB Server (http://www.mongodb.org) - Install if necessary.
* RVM (http://rvm.io)

### Setup Instructions

* Clone the repo
* Use RVM to switch to ruby 1.9.3
* Install the bundle (bundler)
* Seed the database ```rake db:setup``` - The database is populated with the following manuscript from ```db/seeds.rb```.
  <pre>
    Manuscript.create(code: 'AA1001', title: 'My awesome paper', status: 'WITH_AUTHOR', :status_date => Date.parse('01Jan2014')) do |m|
      m.authors << Author.new(publish_name: 'Smith,Joe')
      m.authors << Author.new(publish_name: 'Li,Wen')
      m.authors << Author.new(publish_name: 'Jones,Ben')
    end
  </pre>

### Specifications

We want to implement a simple author inquiry system for authors to view the status of their submitted manuscripts.
When a user arrives at the root of our application, they should see a form that allows them to input a code and an author
name. When submitted, if the code identifies a manuscript and the specified author name matches the last name on one of the the first 3 authors, they should be shown a page that displays the title, status, and authors of the manuscript. If the inputs are invalid, the form page should be re-rendered (inputs intact) with a "No match" message.

The project already includes ```Manuscript``` and ```Author``` models. Use ```Manuscript.find_by_code``` and
```Author#last_name``` to implement the above.
