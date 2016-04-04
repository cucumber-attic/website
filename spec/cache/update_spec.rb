require 'cucumber/website/cache'

module Cucumber::Website::Cache

  class FakeApi
    def a_method
      :a_value
    end

    def another_method
      :another_value
    end
  end

  describe Update do
    describe "#start" do
      it "immediately populates the store with every method on the API" do
        store = FileSystemStore.new(Path.new("periodic_update_spec", "test"), {})
        logger = double.as_null_object
        Update.new(FakeApi.new, store, logger).call
        expect(store.a_method).to eq :a_value
        expect(store.another_method).to eq :another_value
      end
    end
  end
end
