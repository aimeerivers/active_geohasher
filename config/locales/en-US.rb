# nearly every translation should be put into the en.yml file
# this is just for en-US overrides.

require 'yaml'

hash = {}
hash[:'en-US'] = YAML.load_file(File.join(File.dirname(__FILE__), 'en.yml'))['en']

hash[:'en-US']['kms'] =
  'kilometers'

hash[:'en-US']['home']['features']['see_distance_from_home_location'] =
  'See distance from your home location in miles or kilometers'

hash[:'en-US']['graticules']['show']['anthill_visualisation_tool'] =
  'anthill visualization tool'

hash
