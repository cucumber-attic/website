require_relative 'apps/legacy-cukes-info/app'
require_relative 'apps/cucumber-pro-ported-stuff/app'

use LegacyCukesInfo::App
use CucumberProPortedStuff::App

run proc { [404, {'Content-Type' => 'text/html'}, ['Not Found']]}
