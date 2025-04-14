class CreateJokes < ActiveRecord::Migration[8.0]
  def up
    create_table :jokes do |t|
      t.text :content
      t.string :humour
      t.text :context

      t.timestamps
    end
  end

  def down
    drop_table :jokes
  end
end
