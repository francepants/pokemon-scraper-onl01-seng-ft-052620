class Pokemon
    #is initialized with keyword arguments of id, name, type, db
    attr_accessor :name, :type, :db
    attr_reader :id
    def initialize(id: nil, name:, type:, db:)
        @id = id
        @name = name
        @type = type
        @db = db
    end

    def self.save(name, type, db)
            sql = <<-SQL
                INSERT INTO pokemon (name, type)
                VALUES (?, ?)
            SQL
            db.execute(sql, name, type)
            # @id = db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
    end

    def self.new_from_db(row, db)
        self.new(id:row[0],name:row[1],type:row[2],db:db)
    end

    def self.find(id, db)
        #Pokemon .find finds a pokemon from the database by their id number and returns a new Pokemon object
        sql = <<-SQL
            SELECT * from pokemon 
            WHERE id = ?
        SQL
        db.execute(sql, id).map do |row|
            self.new_from_db(row, db)
        end.first
    end
end

# DB[:conn].execute(sql, name).map do |row|
#     self.new_from_db(row)
#   end.first