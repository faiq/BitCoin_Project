class User
    attr_accessor :name, :email #fields of the class we're making also sets
                                #getters and setters

    def initialize(attributes = {}) #when we declare a new user with the method User.new    
                                    #this gets invoked
        @name  = attributes[:name]
        @email = attributes[:email]
    end

    def formatted_email         #declared method to return name + email
        "#{@name} <#{@email}>"
    end
end
