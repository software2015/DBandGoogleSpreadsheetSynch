require 'rails/generators'
require 'rails/generators/migration'

module Nifty
  module Attachments
    class MigrationGenerator < Rails::Generators::Base
      include Rails::Generators::Migration

      source_root File.expand_path("../", __FILE__)

      def self.next_migration_number(path)
        Time.now.utc.strftime("%Y%m%d%H%M%S")
      end

      def create_model_file
        migration_template 'migration.rb', "db/migrate/create_nifty_attachments_table.rb"
      end

    end
  end
end
