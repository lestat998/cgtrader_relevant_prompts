# frozen_string_literal: true

require 'open-uri'
require 'json'

namespace :hugging_face do
  desc 'Import prompts from Hugging Face dataset'
  task import: :environment do
    # Constants
    BASE_URL = 'https://datasets-server.huggingface.co/rows'
    DATASET = 'Gustavosta%2FStable-Diffusion-Prompts'
    CONFIG = 'default'
    SPLIT = 'train'
    TOTAL_ROWS = 81_910
    ROWS_PER_PAGE = 100
    MAX_RETRIES = 3

    # Create index
    RelevantPrompt.reindex

    # Fetch and import data in batches
    import_prompts_in_batches

    # Import to Elasticsearch
    RelevantPrompt.import
    puts 'All prompts imported to Elasticsearch.'
  end

  private

  def import_prompts_in_batches
    (0...TOTAL_ROWS).step(ROWS_PER_PAGE).each do |offset|
      import_batch(offset)
    end
  end

  def import_batch(offset)
    retries = 0
    begin
      url = construct_url(offset)
      response = URI.open(url)
      process_data(response)
      puts "Imported #{offset + ROWS_PER_PAGE} prompts..."
    rescue OpenURI::HTTPError => e
      handle_error(e, retries)
      retries += 1
      retry if retries < MAX_RETRIES
    end
  end

  def construct_url(offset)
    "#{BASE_URL}?dataset=#{DATASET}&config=#{CONFIG}&split=#{SPLIT}&offset=#{offset}&length=#{ROWS_PER_PAGE}"
  end

  def process_data(response)
    data = JSON.parse(response.read)
    data['rows'].each do |row|
      RelevantPrompt.create(value: row['row']['Prompt'])
    end
  end

  def handle_error(error, retries)
    puts "HTTP Error: #{error.message}. Attempt #{retries + 1} of #{MAX_RETRIES}. Retrying..."
  end
end
