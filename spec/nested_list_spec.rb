require 'cucumber/website/nested_list'

module Cucumber::Website
  describe NestedList do
    it "builds a flat list" do
      l = NestedList.new
      l.add(0, :a)
      l.add(0, :b)
      l.add(0, :c)
      expect(l.nested).to eq [:a, :b, :c]
    end

    it "nests one at deeper level" do
      l = NestedList.new
      l.add(0, :a)
      l.add(1, :b)
      expect(l.nested).to eq [:a, [:b]]
    end

    it "nests down and up" do
      l = NestedList.new
      l.add(0, :a)
      l.add(1, :b)
      l.add(0, :c)
      expect(l.nested).to eq [:a, [:b], :c]
    end

    it "nests two at deeper level" do
      l = NestedList.new
      l.add(0, :a)
      l.add(1, :b)
      l.add(1, :c)
      expect(l.nested).to eq [:a, [:b, :c]]
    end

    it "nests two levels down" do
      l = NestedList.new
      l.add(0, :a)
      l.add(1, :b)
      l.add(2, :c)
      expect(l.nested).to eq [:a, [:b, [:c]]]
    end

    it "nests two levels down and all the way up" do
      l = NestedList.new
      l.add(0, :a)
      l.add(1, :b)
      l.add(2, :c)
      l.add(0, :d)
      expect(l.nested).to eq [:a, [:b, [:c]], :d]
    end

    it "works with a complex tree" do
      l = NestedList.new
      l.add(0, :a)
      l.add(1, :b)
      l.add(2, :c)
      l.add(1, :d)
      l.add(0, :e)
      expect(l.nested).to eq [:a, [:b, [:c], :d], :e]
    end
  end
end
