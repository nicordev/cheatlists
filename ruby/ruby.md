# Ruby

affichage, Regex, array :

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