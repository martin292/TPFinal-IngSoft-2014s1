migration 2, :create_events do
  up do
    create_table :events do
      column :id, Integer, :serial => true
      column :name, String, :length => 255
      column :max, Integer
      column :date, Date
      column :members, String
      column :hay_notificaciones, Integer
      column :slug, String, :length => 255
      column :short_url, String, :length => 255
      column :account_id, Integer
      column :tag, String, :length => 10
    end
  end

  down do
    drop_table :events
  end
end
