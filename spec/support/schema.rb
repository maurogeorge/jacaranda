ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")
ActiveRecord::Base.configurations = true

ActiveRecord::Schema.verbose = false
ActiveRecord::Schema.define(:version => 1) do

  create_table :posts do |t|
    t.datetime :created_at
    t.datetime :updated_at
    t.string :title
    t.string :status
    t.string :kind
  end
end


