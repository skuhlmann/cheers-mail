class DropWikiParsersTable < ActiveRecord::Migration
  def change
    drop_table :wiki_parsers
  end
end
