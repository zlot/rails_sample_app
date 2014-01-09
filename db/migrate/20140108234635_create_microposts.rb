class CreateMicroposts < ActiveRecord::Migration
  def change
    create_table :microposts do |t|
      t.string :content
      t.integer :user_id

      t.timestamps
    end

    # create index as we expect to retrieve all the microposts associated with 
    #  a given user id in reverse order of creation.
    # note that we're creating a multiple key index, using both :user_id & :created_at
    # as primary key.
    add_index :microposts, [:user_id, :created_at]
  end
end
