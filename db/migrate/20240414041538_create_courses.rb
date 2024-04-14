class CreateCourses < ActiveRecord::Migration[7.1]
  def change
    create_table :courses do |t|
      t.string :name
      t.string :description
      t.string :image
      t.decimal :price

      t.timestamps
    end
  end
end
