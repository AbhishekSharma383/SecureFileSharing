class CreateUploadedFiles < ActiveRecord::Migration[7.0]
  def change
    create_table :uploaded_files do |t|
      t.string :title
      t.text :description
      t.string :content_type
      t.string :share_token
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    
    add_index :uploaded_files, :share_token, unique: true
  end
end