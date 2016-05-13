require 'spec_helper'
require 'extreme_startup/question_factory'
require 'extreme_startup/player'

module ExtremeStartup
  describe SubtractionQuestion do
    let(:question) { SubtractionQuestion.new(Player.new) }
    
    it "converts to a string" do
      expect(question.as_text).to match(/what is \d+ minus \d+/i)
    end
    
    context "when the numbers are known" do
      let(:question) { SubtractionQuestion.new(Player.new, 2,3) }
        
      it "converts to the right string" do
        expect(question.as_text).to match(/what is 2 minus 3/i)
      end
      
      it "identifies a correct answer" do
        expect(question.answered_correctly?("-1")).to be_truthy
      end

      it "identifies an incorrect answer" do
        expect(question.answered_correctly?("77")).to be_falsey
      end
    end
    
  end
end
