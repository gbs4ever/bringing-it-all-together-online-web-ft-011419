class Dog
attr_accessor :name, :breed, :id
def initialize(name:,breed:,id:nil)
  @name=name
  @breed=breed
  @id=id
end

def self.create_table
  sql =  <<-SQL
    CREATE TABLE IF NOT EXISTS dogs (
      id INTEGER PRIMARY KEY,
      name TEXT,
      breed TEXT
      )
  SQL
  DB[:conn].execute(sql)
  end
def self.drop_table
  sql =  <<-SQL
  DROP TABLE dogs;
  SQL
  DB[:conn].execute(sql)
end

def save
 if self.id
   self.update
  else
  sql =  <<-SQL
  INSERT INTO dogs (name,breed)values (?,?)
  SQL
  DB[:conn].execute(sql,self.name,self.breed)
   @id = DB[:conn].execute("SELECT last_insert_rowid() FROM dogs")[0][0]
 end
end

def self.create(name:,breed:)
file=Dog.new(name,breed)
file.save
file
end

def self.new_from_db(row)
  data=row[0]
  binding.pry
  .id=data[0]
self.name=data[1]
self.breed=data[2]
data
end
def self.find_by_name(name)
  sql =  <<-SQL
SELECT *FROM dogs WHERE = name;
  SQL
  DB[:conn].execute(sql)

end















end
