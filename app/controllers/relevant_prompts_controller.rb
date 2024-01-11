# frozen_string_literal: true

class RelevantPromptsController < ApplicationController
  def index; end

  def search_prompts
    @prompts = search
    render json: @prompts
  rescue StandardError
    render json: { error: 'You have no relevant prompts' }
  end

  private

  def prompt_params
    params.permit(:words)
  end

  def search
    RelevantPrompt.search(prompt_params[:words])
  end
end
