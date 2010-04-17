# nearly every translation should be put into the en.yml file
# this is just for en-US overrides.

require 'yaml'

hash = {}
hash[:'en-US'] = YAML.load_file(File.join(File.dirname(__FILE__), 'en.yml'))['en']

hash[:'en-US']['date']['formats']['default'] = "%m/%d/%Y"
hash[:'en-US']['date']['formats']['short'] = "%a %b %d"
hash[:'en-US']['date']['formats']['long'] = "%A, %B %d %Y"
hash[:'en-US']['date']['order'] = [:month, :day, :year]
hash
