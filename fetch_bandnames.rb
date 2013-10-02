require 'httparty'
require 'sqlite3'
require 'json'

URL='https://script.google.com/macros/s/AKfycbxbAlc8gGgIPyW4wz6xuGZ-asl8sFCtNEzD77kqGoZRsidiERou/exec'

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

class Connection
  include HTTParty
  default_timeout 300
end

thread = 3

#while resp != false
  res = Connection.get(URL+"?start=#{thread}&end=#{thread}")
  payload = JSON.parse res.body
  payload.each do |email|
    bandnames = email['body'].gsub("\r", '').split("\n").map {|name| name unless name.empty?}
    bandnames.each do |name|
      puts "inserting #{name} by #{parse_sender(email['sender'])}"
      db.execute "insert into bandnames (name, submitter, date) values (?,?,?)", [name,parse_sender(email['sender']),email['date']]
    end
  end
#end

