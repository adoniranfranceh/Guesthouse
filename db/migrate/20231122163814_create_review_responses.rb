class CreateReviewResponses < ActiveRecord::Migration[7.1]
  def change
    create_table :review_responses do |t|
      t.string :comment
      t.references :rating, null: false, foreign_key: true

      t.timestamps
    end
  end
end
