require('pg')

class SpaceCowboy

  attr_accessor :name, :bounty_value, :last_known_location, :favourite_weapon
  attr_reader :id

  def initialize( options )
    @name = options['name']
    @bounty_value = options['bounty_value'].to_i
    @last_known_location = options['last_known_location']
    @favourite_weapon = options['favourite_weapon']
    @id = options['id'].to_i if options['id']
  end

  def save()
    # connect db
    db = PG.connect({ dbname: 'bounty', host: 'localhost'})
    # write sql string
    sql = " INSERT INTO space_cowboys
    (
      name,
      bounty_value,
      last_known_location,
      favourite_weapon
      )
      VALUES ($1, $2, $3, $4)
      RETURNING id
      "
    # create a value array
    values = [@name, @bounty_value, @last_known_location, @favourite_weapon]
    # prepared statement
    db.prepare("save", sql)
    # exec the prepared statement
    @id = db.exec_prepared("save", values)[0]['id'].to_i
    # close the db
    db.close()
  end


  def SpaceCowboy.all()
    # connect to db
    db = PG.connect({ dbname: 'bounty', host: 'localhost'})
    # write the sql string
    sql = "SELECT * FROM space_cowboys"
    # prepare the statement
    db.prepare("all", sql)
    # exec the prepared statement
    cowboys = db.exec_prepared("all")
    # close the db
    db.close()
    # return the list of cowboys created in map
    return cowboys.map { |cowboy| SpaceCowboy.new(cowboy)}
  end

  def SpaceCowboy.delete_all()
    # connect to db
    db = PG.connect({ dbname: 'bounty', host: 'localhost'})
    # write sql string
    sql = "DELETE FROM space_cowboys"
    # prepare the statement
    db.prepare("delete_all", sql)
    # exec the prepared statement
    db.exec_prepared("delete_all")
    # close the db
    db.close()
  end


  def delete()
    # commect to db
    db = PG.connect({ dbname: 'bounty', host: 'localhost'})
    # write the sql string
    sql = "DELETE FROM space_cowboys WHERE id = $1"
    # set up values
    values = [@id]
    # prepare sql statement
    db.prepare("delete_one", sql)
    # run prepared statement
    db.exec_prepared("delete_one", values)
    # close db
    db.close()
  end

  def update()
    # connect to db
    db = PG.connect({ dbname: 'bounty', host: 'localhost'})
    # write sql string
    sql = "UPDATE space_cowboys
    SET (
      name,
      bounty_value,
      last_known_location,
      favourite_weapon
    ) = (
      $1, $2, $3, $4
    )
    WHERE id = $5
    "
    # create value array for prepared statement
    values = [@name, @bounty_value, @last_known_location, @favourite_weapon, @id]
    # prepare statement
    db.prepare("update", sql)
    # run query with prep statement
    db.exec_prepared("update", values)
    # close db
    db.close()
  end

  def SpaceCowboy.find_by_name(name)
    db = PG.connect({ dbname: 'bounty', host: 'localhost'})
    sql = "SELECT * FROM space_cowboys WHERE name = $1"
    values = [name]
    db.prepare("find_by_name", sql)
    result = db.exec_prepared("find_by_name", values)
    if (result == [])
      return nil
    else
      return SpaceCowboy.new(result[0])
    end
    db.close
  end

  def SpaceCowboy.find_by_id(id)
    db = PG.connect({ dbname: 'bounty', host: 'localhost'})
    sql = "SELECT * FROM space_cowboys WHERE id = $1"
    values = [id]
    db.prepare("find_by_id", sql)
    result = db.exec_prepared("find_by_id", values)
    if (result == [])
      return nil
    else
      return SpaceCowboy.new(result[0])
    end
    db.close
  end


end
