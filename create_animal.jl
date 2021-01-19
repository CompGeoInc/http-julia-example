using JSON2, HTTP, UUIDs

# Create an animal
mutable struct Animal
    id::Int
    userId::Base.UUID
    type::String
    name::String
end

dog = Animal(1, uuid1(), "Dog", "Spot")

# Add the animal to the server's list of animals by writing out the dog
# struct to json and then sending the JSON to the server as an HTTP POST
# request. The request function will return an HTTP response object, which
# should indicate whether or not our request was successful.
# The third argument of the request function is for the header.
# The HTTP message header contains metadata associated with the request
# In this case we don't have any metadata to add so we leave the field blank

response = HTTP.request("POST", "http://localhost:8080/api/zoo/v1/animals", [], JSON2.write(dog))

# Should print 200. That's the code indicating that the request
# was successful
println(response.status) 

# Gives you back the json for the animal you create. It will be the
# same as the json you sent except for the id, which may or may be
# different than what you sent.
println(String(response.body))

# Now fetch the animal using an HTTP "GET" request. In this case this will just
# return the same response you got from the create animal request.
# The 0 in the url is the id of the animal.
response = HTTP.request("GET", "http://localhost:8080/api/zoo/v1/animals/0")
println(response.status)
println(String(response.body))