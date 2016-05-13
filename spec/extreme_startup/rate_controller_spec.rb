require 'spec_helper'
require 'extreme_startup/quiz_master'

module ExtremeStartup
  describe RateController do
    let(:controller) { RateController.new }
        
    it "reduces delays after successive correct answers" do
      expect(controller.delay_before_next_request(FakeAnswer.new(:correct))).to eq(4.9)
      expect(controller.delay_before_next_request(FakeAnswer.new(:correct))).to eq(4.8)
      expect(controller.delay_before_next_request(FakeAnswer.new(:correct))).to eq(4.7)
    end
    
    it "enforces minimum delay between successive correct answers is one second" do
      1000.times { controller.delay_before_next_request(FakeAnswer.new(:correct)) }
      expect(controller.delay_before_next_request(FakeAnswer.new(:correct))).to eq(1)
    end
        
    it "increases delays after successive wrong answers" do
      expect(controller.delay_before_next_request(FakeAnswer.new(:wrong))).to eq(5.1)
      expect(controller.delay_before_next_request(FakeAnswer.new(:wrong))).to eq(5.2)
      expect(controller.delay_before_next_request(FakeAnswer.new(:correct))).to eq(5.1)
      expect(controller.delay_before_next_request(FakeAnswer.new(:wrong))).to eq(5.2)
      expect(controller.delay_before_next_request(FakeAnswer.new(:wrong))).to eq(5.3)
    end
    
    it "enforces maximum delay between successive wrong answers is 20 seconds" do
      1000.times { controller.delay_before_next_request(FakeAnswer.new(:wrong)) }
      expect(controller.delay_before_next_request(FakeAnswer.new(:wrong))).to eq(20)
    end
    
    it "delays 20 seconds after error responses" do
      expect(controller.delay_before_next_request(FakeAnswer.new(:error))).to eq(20)
    end
    
    it "occasionally switches a SlashdotRateController if score is above 2000" do
      class ExtremeStartup::RateController
        def slashdot_probability_percent 
          100 
        end
      end
      expect(controller.update_algorithm_based_on_score(100)).to eq(controller)
      expect(controller.update_algorithm_based_on_score(2001)).to be_instance_of SlashdotRateController
      
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
