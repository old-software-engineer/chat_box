class AddLastSeenAtTo<%= model_name.classify %> < ActiveRecord::Migration<%= migration_version %>
  def change
    add_column :<%= model_name.classify.safe_constantize.table_name %>, :is_online, :boolean, default: false
  end
end