require 'spec_helper'
require 'extreme_startup/question_factory'
require 'extreme_startup/player'

module ExtremeStartup
  describe PrimesQuestion do
    let(:question) { PrimesQuestion.new(Player.new) }
    
    it "converts to a string" do
      expect(question.as_text).to match(/which of the following numbers are primes: (\d+, )+(\d+)/i)
    end
    
    context "when the numbers are known" do
      let(:question) { PrimesQuestion.new(Player.new, 3, 4, 6) }
            
      it "converts to the right string" do
        expect(question.as_text).to match(/which of the following numbers are primes: 3, 4, 6/i)
      end
                
      it "identifies a correct answer" do
        expect(question.answered_correctly?("3")).to be_truthy
      end
               
      it "identifies an incorrect answer" do
        expect(question.answered_correctly?("4")).to be_falsey
      end
    end
        
    context "when there are multiple numbers in the answer" do
      let(:question) { PrimesQuestion.new(Player.new, 3, 4, 5) }
       
      it "identifies a correct answer" do
        expect(question.answered_correctly?("3, 5")).to be_truthy
      end
       
      it "identifies an incorrect answer" do
        expect(question.answered_correctly?("3, 4")).to be_falsey
      end
    end
  end
end
