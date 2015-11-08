require 'cucumber/website/cache'

module Cucumber::Website::Cache
  describe PeriodicCall do
    let(:log) { double.as_null_object }
    let(:interval) { 0.01 }

    it "calls the given proc every refresh interval" do
      count = 0
      run = Proc.new { count +=1 } 
      periodic_call = PeriodicCall.new(run, interval, log).start
      sleep interval * 10
      expect(count).to be_within(2).of(10)
    end

    it "logs exceptions from the proc" do
      run = Proc.new { raise "send help!" }
      periodic_call = PeriodicCall.new(run, interval, log).start
      expect(log).to receive(:error)
      sleep interval * 2
    end

    it "can be stopped" do
      count = 0
      run = Proc.new { count +=1 } 
      periodic_call = PeriodicCall.new(run, interval, log).start
      sleep interval * 10
      periodic_call.stop
      count_at_stop = count
      sleep interval * 10
      expect(count).to eq count_at_stop
    end
  end
end
