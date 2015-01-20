Dir['apps/*'].each do |path|
  require_relative path + '/app'
end

use LegacyCukesInfo::App
use CucumberProPortedStuff::App
use Docs::App

run proc { [404, {'Content-Type' => 'text/html'}, ['Not Found']]}
