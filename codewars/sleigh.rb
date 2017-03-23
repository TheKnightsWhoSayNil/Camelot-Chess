class Sleigh
  def authenticate(name, password)
     if name == "Santa Claus" && password == "Ho Ho Ho!"
      return true
     else return false
     end   
  end
end

# ---codewars solution
#class Sleigh
#  VALID_USERS = {"Santa Claus" => "Ho Ho Ho!"}

#  def authenticate(name, password)
#    VALID_USERS[name] == password
#  end
# end