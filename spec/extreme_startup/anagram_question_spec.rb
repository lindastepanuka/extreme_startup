require 'spec_helper'
require 'extreme_startup/question_factory'
require 'extreme_startup/player'

module ExtremeStartup
  describe AnagramQuestion do
    let(:question) { AnagramQuestion.new(Player.new) }

    it "converts to a string" do
      expect(question.as_text).to match(/which of the following is an anagram of "\w+":/i)
    end

    context "when the words are known" do
      let(:question) { AnagramQuestion.new(Player.new, "listen", "inlets", "enlists", "google", "banana") }

      it "converts to the right string" do
        expect(question.as_text).to match(/which of the following is an anagram of "listen": /i)
      end

      it "identifies a correct answer" do
        expect(question.answered_correctly?("inlets")).to be_truthy
      end

      it "identifies an incorrect answer" do
        expect(question.answered_correctly?("enlists")).to be_falsey
      end
    end

  end
end
