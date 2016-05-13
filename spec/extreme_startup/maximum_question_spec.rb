require 'spec_helper'
require 'extreme_startup/question_factory'
require 'extreme_startup/player'

module ExtremeStartup
  describe MaximumQuestion do
    let(:question) { MaximumQuestion.new(Player.new) }
    
    it "converts to a string" do
      expect(question.as_text).to match(/which of the following numbers is the largest: (\d+, )+(\d+)/i)
    end
    
    context "when the numbers and known" do
      let(:question) { MaximumQuestion.new(Player.new, 2,4,3) }
        
      it "converts to the right string" do
        expect(question.as_text).to match(/which of the following numbers is the largest: 2, 4, 3/i)
      end
      
      it "identifies a correct answer" do
        expect(question.answered_correctly?("4")).to be_truthy
      end

      it "identifies an incorrect answer" do
        expect(question.answered_correctly?("3")).to be_falsey
      end
    end
    
  end
end
