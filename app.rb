require 'sinatra'
require 'pg'
require 'json'
require 'haml'
require 'time'

get '/' do
  db = PG::Connection.open(dbname: 'bandnames')
  names = []
  db.exec 'select * from submissions' do |result|
    result.each_row { |row| ( names << parse_row(row) ) unless row[1].empty? }
  end
  haml :home, format: :html5, locals: { names: JSON.generate(names) }
end

def parse_row(row)
  {id: row[0],
   name: row[1],
   sender: row[2],
   time: Time.parse(row[3]).strftime('%l:%M %P %A, %B %-d, %Y') }
end
