require 'sinatra'
require 'pg'

get '/' do
  db = PG::Connection.open(dbname: 'bandnames')
  names = []
  db.exec 'select * from submissions' do |result|
    result.each_row do |row|
      names << parse_row(row)
    end
  end
  haml :home, locals: { names: names.to_json }
end

def parse_row(row)
  {id: row[0],
   name: row[1],
   sender: row[2],
   time: row[3] }
end
