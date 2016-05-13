require 'spec_helper'
require 'extreme_startup/question_factory'
require 'extreme_startup/player'

module ExtremeStartup
  describe ScrabbleQuestion do
    let(:question) { ScrabbleQuestion.new(Player.new) }

    it "converts to a string" do
      expect(question.as_text).to match(/what is the english scrabble score of \w+/i)
    end

    context "when the words are known" do
      let(:question) { ScrabbleQuestion.new(Player.new, "spaceman") }

      it "converts to the right string" do
        expect(question.as_text).to match(/what is the english scrabble score of spaceman/i)
      end

      it "identifies a correct answer" do
        expect(question.answered_correctly?("14")).to be_truthy
      end

      it "identifies an incorrect answer" do
        expect(question.answered_correctly?("23")).to be_falsey
      end
    end

  end
end
