class CreateWikiParsers < ActiveRecord::Migration
  def change
    create_table :wiki_parsers do |t|

      t.timestamps
    end
  end
end
