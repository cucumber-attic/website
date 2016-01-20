require 'cucumber/website/cache'
require 'cucumber/website/core/contributor'

module Cucumber::Website
  module Cache
    describe FileSystemStore do
      let(:store) { FileSystemStore.new(path, {}) }
      let(:path) { Path.new("a_test", "test") }
      let(:test_data) { [Core::Contributor.new("http://avatar.com/matt.png", "mattwynne")] }

      before do
        Path.delete("test")
      end

      it "has default data that is used when the store does not exist yet" do
        store = FileSystemStore.new("cache that does not exist", { 'foo' => [] })
        expect(store.foo).to eq []
      end

      it "stores data that can be read by another instance" do
        store.set(:contributors, test_data)
        other_store = FileSystemStore.new(path, {})
        expect(other_store.contributors).to eq test_data
      end

      it "can be locked, which works accross instances and across processes" do
        store.lock
        expect(store).to be_locked
        expect(FileSystemStore.new(path, {})).to be_locked
        ruby = %{
          require 'cucumber/website/cache'
          puts Cucumber::Website::Cache::FileSystemStore.new('#{path}', {}).locked?
        }
        expect(`ruby -I #{Dir.pwd}/lib -e "#{ruby}"`.strip).to eq "true"
      end

      it "is automatically unlocked when the process dies" do
        ruby = %{
          require 'cucumber/website/cache'
          puts Cucumber::Website::Cache::FileSystemStore.new('#{path}', {}).lock
        }
        `ruby -I #{Dir.pwd}/lib -e "#{ruby}"`
        expect(FileSystemStore.new(path, {})).not_to be_locked
      end
    end
  end
end
