require_relative('../db/sql_runner')

class Customer
    
    attr_reader :id
    attr_accessor :name, :funds

    def initialize(options)
        @id = options['id'].to_i if options ['id']
        @name = options['name']
        @funds = options['funds']

    end

    def save()
        sql = "INSERT INTO customers (name, funds)
        VALUES ($1, $2)
        RETURNING id"
        values = [@name, @funds]
        customer = SqlRunner.run(sql, values).first
        @id = customer['id'].to_i
    end

    def update()
        sql = "UPDATE customers SET (name, funds) = ($1, $2)
        WHERE id = $3"
        values = [@name, @funds]
        SqlRunner.run(sql, values)
    end

    # I wasnt sure if we were supposed to create a delete by ID or delete everything function, so i did both
    
    def delete()
        sql = "DELETE FROM customers WHERE id = $1"
        values = [@id]
        SqlRunner.run(sql, values)
    end

    def self.delete_all()
        sql = "DELETE FROM customers"
        SqlRunner.run(sql)
    end

    def self.map_items(data)
        result = data.map{|customer| Customer.new(customer)}
        return result
    end

    # trying to see which customers are coming to see one film.
    def films()
        sql = "SELECT films.* FROM films INNER JOIN tickets ON films.id
        = tickets.film_id WHERE customer_id = $1"
        values =[@id]
        film_data = SqlRunner.run(sql, values)
        return Customer.map_items(customer_data)
    end
    
    def self.map_items(data)
        result = data.map{|customer| Customer.new(customer)}
        return result
      end


    
















end

