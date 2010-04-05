# nearly every translation should be put into the en-GB.yml file
# this is just for en-US overrides.

require 'yaml'
{:'en-US' => YAML.load_file(File.join(File.dirname(__FILE__), 'en-GB.yml'))['en-GB'].merge(
  'kms' => 'kilometers'
)}
