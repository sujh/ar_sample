require_relative '../model/author'
require_relative '../model/book'
require 'ffaker'

db_config = YAML::load(File.open('../config/database.yml'))["development"]
ActiveRecord::Base.establish_connection(db_config)

start = Time.now
threads = []
mutex = Mutex.new
id = 0

5.times do |t_num|
  threads << Thread.new do
    1000.times do |num|
      author_params = []
      book_params = []
      100.times do
        mutex.synchronize { id += 1 }
        author_params << { id: id, name: FFaker::Name.name, birth: FFaker::Time.between(Time.new(1920), Time.new(2000)).year,
                           gender: FFaker::Boolean.maybe, country: FFaker::Address.country, created_at: Time.now, updated_at: Time.now }
        book_params << {name: FFaker::Book.name, synopsis: FFaker::Lorem.characters(50), probation: FFaker::Book.description(30),
                        author_id: id, created_at: Time.now, updated_at: Time.now }
      end
      Author.insert_all!(author_params)
      Book.insert_all!(book_params)
    end
  end
end

threads.each(&:join)

collapsed = Time.now - start
p collapsed