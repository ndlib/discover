## MIGRATION FIX. Uncomment below when setting up on a new machine before running rake db:migrate
## https://stackoverflow.com/questions/21075515/creating-tables-and-problems-with-primary-key-in-rails

# class ActiveRecord::ConnectionAdapters::Mysql2Adapter
#   NATIVE_DATABASE_TYPES[:primary_key] = "int(11) auto_increment PRIMARY KEY"
# end
