require 'faraday'
require 'sqlite3'
require 'json'

URL='https://script.google.com/macros/s/AKfycbxbAlc8gGgIPyW4wz6xuGZ-asl8sFCtNEzD77kqGoZRsidiERou/'

conn = Faraday.new url: URL

db = SQLite3::Database.new( "bandnames.db" )
db.execute <<-SQL
  CREATE TABLE IF NOT EXISTS bandnames (
    name text,
    submitter text,
    date text
    );
SQL

def parse_sender(text)
  text.split('<')[0].chop
end

thread = 3
#while resp != false
  res = conn.get do |req|
    req.url 'exec', start: thread
    req.params['end'] = thread
    req.options[:timeout] = 300
  end
  payload = JSON.parse res.body
  payload.each do |email|
    bandnames = email['body'].gsub("\r").split("\n").map {|name| name unless name.empty?}
    bandnames.each do |name|
      puts "inserting #{name} by #{parse_sender(email['sender'])}"
      db.execute "insert into bandnames (name, submitter, date) values (?,?,?)", [name,parsse_sender(email['sender']),email['date']]
    end
  end
#end

