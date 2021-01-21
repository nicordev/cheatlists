# Ruby

- [Regex](https://www.rubyguides.com/2015/06/ruby-regex/)
- [Loops](https://www.rubyguides.com/ruby-tutorial/loops/)

Commentaires :

```ruby
=begin
Every body mentioned this way
to have multiline comments.

The =begin and =end must be at the beginning of the line or
it will be a syntax error.
=end

# Single line comment
```

Déclarer une fonction :

```ruby
# Extract access token from a keycloak token
def extractAccessToken(keycloakToken)
    regex = /.+\"access_token\":\"([^\"]+)\".+/m
    matches = []

    keycloakToken.scan(regex) do |match|
        matches.push(match.to_s)
    end

    return matches[0].tr('[', '').tr(']', '') # Here we remove the characters '[' and ']'
end

puts extractAccessToken(token) # Here we print the returned value of the function
```

Affichage, Regex, array :

```ruby
regex = /.+\"access_token\":\"([^\"]+)\".+/m
token = '{"access_token":"zogzog","expires_in":300,"refresh_expires_in":2400}'

matches = []

# Apply the regex
token.scan(regex) do |match|
    matches.push(match.to_s)
end

puts matches.length # Print the matches array length
matches.each { |match| puts match } # Loop on matches elements
puts matches[0] # Print the first element of matches array
```