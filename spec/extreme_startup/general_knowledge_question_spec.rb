require 'spec_helper'
require 'extreme_startup/question_factory'

module ExtremeStartup
  describe GeneralKnowledgeQuestion do
    let(:question) { GeneralKnowledgeQuestion.new(Player.new) }

    it "converts to a string" do
      expect(question.as_text).to match(/wh.+/)
    end
  end
end
