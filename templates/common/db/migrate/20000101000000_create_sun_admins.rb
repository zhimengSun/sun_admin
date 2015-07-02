class CreateSunAdmins < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password

      t.timestamps null: false
    end

    create_table :roles do |t|
      t.string :name
      t.string :name_en
      t.string :desc

      t.timestamps null: false
    end

    create_table :resources do |t|
      t.string :name
      t.string :url
      t.string :desc

      t.timestamps null: false
    end

    create_table :resources_roles do |t|
      t.string :resource_id
      t.string :role_id
      t.timestamps null: false
    end

    create_table :roles_users do |t|
      t.string :user_id
      t.string :role_id
      t.timestamps null: false
    end
  end
end

