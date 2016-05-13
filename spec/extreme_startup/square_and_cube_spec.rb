require 'spec_helper'
require 'extreme_startup/question_factory'
require 'extreme_startup/player'

module ExtremeStartup
  describe SquareCubeQuestion do
    let(:question) { SquareCubeQuestion.new(Player.new) }
    
    it "converts to a string" do
      expect(question.as_text).to match(/which of the following numbers is both a square and a cube: (\d+, )+(\d+)/i)
    end
    
    context "when the numbers are known" do
      let(:question) { SquareCubeQuestion.new(Player.new, 62, 63, 64) }
        
      it "converts to the right string" do
        expect(question.as_text).to match(/which of the following numbers is both a square and a cube: 62, 63, 64/i)
      end
            
      it "identifies a correct answer" do
        expect(question.answered_correctly?("64")).to be_truthy
      end
           
      it "identifies an incorrect answer" do
        expect(question.answered_correctly?("63")).to be_falsey
      end
    end
    
    context "if one of the numbers is zero" do
      let(:question) { SquareCubeQuestion.new(Player.new, 0, 5) }
       
      it "doesn't crash with divide by zero" do
        expect(question.answered_correctly?("0")).to be_truthy
        expect(question.answered_correctly?("5")).to be_falsey
      end
    end
    
    context "when there are multiple numbers in the answer" do
      let(:question) { SquareCubeQuestion.new(Player.new, 64, 65, 729) }

      it "identifies a correct answer" do
        expect(question.answered_correctly?("64, 729")).to be_truthy
      end

      it "identifies an incorrect answer" do
        expect(question.answered_correctly?("64")).to be_falsey
      end
    end
      
  end
end
