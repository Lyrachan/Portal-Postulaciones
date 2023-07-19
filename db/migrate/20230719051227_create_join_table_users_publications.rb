class CreateJoinTableUsersPublications < ActiveRecord::Migration[7.0]
  def change
    create_join_table :users, :publications do |t|
      # t.index [:user_id, :publication_id]
      # t.index [:publication_id, :user_id]
    end
  end
end
