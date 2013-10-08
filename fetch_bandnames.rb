require 'httparty'
require 'pg'
require 'json'
require 'time'

URL='https://script.google.com/macros/s/AKfycbxbAlc8gGgIPyW4wz6xuGZ-asl8sFCtNEzD77kqGoZRsidiERou/exec'

conn = PG::Connection.open(dbname: 'bandnames')
conn.exec <<-SQL
  CREATE TABLE IF NOT EXISTS submissions (
  id SERIAL PRIMARY KEY,
  name text NOT NULL,
  sender varchar(255) NOT NULL,
  time timestamp
  );
SQL

def parse_sender(text)
  text.split('<')[0].chop
end

class Connection
  include HTTParty
  default_timeout 300
end

thread = ARGV[0] || 0

res = Connection.get(URL+"?start=#{thread}&end=#{thread}")
payload = JSON.parse res.body
payload.each do |email|
  bandnames = email['body'].gsub("\r", '').split("\n")
  bandnames.each do |name|
    unless name.empty?
      puts "inserting #{name} by #{parse_sender(email['sender'])}"
      conn.exec_params("INSERT INTO submissions (name,sender,time) VALUES ($1, $2, $3)",
                       [{ value:name },{ value: parse_sender(email['sender']) },{ value: Time.parse(email['date']) }])
    end
  end
end

