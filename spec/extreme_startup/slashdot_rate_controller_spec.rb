require 'spec_helper'
require 'extreme_startup/quiz_master'

module ExtremeStartup
  describe SlashdotRateController do
    let(:controller) { SlashdotRateController.new }
        
    it "makes the inter-request delay very small" do
      expect(controller.delay_before_next_request(FakeAnswer.new(:correct))).to eq(0.02)
    end
    
    it "increases the delay slightly with each request, up to 5 seconds" do
      old_delay = 0
      200.times do 
        delay = controller.delay_before_next_request(FakeAnswer.new(:correct))
        expect(delay).to be < 4
        expect(delay).to be > old_delay
        old_delay = delay 
      end
    end
    
    it "reverts to standard RateController once spike subsides" do
      500.times do 
        delay = controller.delay_before_next_request(FakeAnswer.new(:correct))
      end
      expect(controller.update_algorithm_based_on_score(1)).to be_instance_of RateController
    end
  end
  
  class FakeAnswer
    def initialize(result)
      @result = result
    end
    def was_answered_correctly
      @result == :correct
    end
    def was_answered_wrongly
      @result == :wrong
    end
  end
  
end
