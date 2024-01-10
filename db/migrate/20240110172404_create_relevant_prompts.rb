class CreateRelevantPrompts < ActiveRecord::Migration[7.0]
  def change
    create_table :relevant_prompts do |t|
      t.string :value
      t.timestamps
    end
  end
end
