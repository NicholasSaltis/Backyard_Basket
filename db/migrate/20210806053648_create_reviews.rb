class CreateReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :reviews do |t|
      t.string :title
      t.text :comment_text
      t.date :comment_date
      t.integer :rating
      t.references :reviewer_id, null: false, foreign_key: { to_table: :profiles }
      t.references :seller_id, null: false, foreign_key: { to_table: :profiles } 

      t.timestamps
    end
  end
end
