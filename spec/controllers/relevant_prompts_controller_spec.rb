require 'rails_helper'

RSpec.describe RelevantPromptsController, type: :controller do
  describe "GET #index" do
    it "responds successfully" do
      get :index
      expect(response).to be_successful
    end
  end

  describe "POST #search_prompts" do
    let(:valid_params) { { words: 'example' } }
    let(:expected_prompts) { [instance_double(RelevantPrompt)] }

    before do
      allow(RelevantPrompt).to receive(:search).with('example').and_return(expected_prompts)
    end

    it "performs a search with the given parameters" do
      post :search_prompts, params: valid_params
      expect(RelevantPrompt).to have_received(:search).with('example')
    end

    it "renders the search results as JSON" do
      post :search_prompts, params: valid_params
      expect(response.body).to eq(expected_prompts.to_json)
    end
  end
end
