class RelevantPromptsController < ApplicationController
  def index
  end

  def search_prompts
    puts "searching for prompts"
    render json: { "prompts": ["prompt1", "prompt2", "prompt3"] }
  end
end
