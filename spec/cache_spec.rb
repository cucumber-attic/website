require 'cucumber/website/cache'

module Cucumber::Website

  describe Cache do
    before do
      Cache::Path.delete('test')
    end

    let(:logger) { double("Logger").as_null_object }

    it "wraps an API" do
      api = Class.new {
        def a_method
          return :another_value if @has_been_called_once
          @has_been_called_once = true
          :a_value
        end
      }.new
      config = {
        'env' => 'test',
        'cache_wraps_an_api' => {
          'cache_refresh_interval' => 0.1
        }
      }
      wrapped = Cache.wrap(api, 'cache_wraps_an_api', config, logger)
      expect(wrapped.a_method).to eq :a_value
      expect(wrapped.a_method).to eq :a_value
      expect(wrapped.a_method).to eq :a_value
    end
  end

end
