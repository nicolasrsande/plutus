# lib/generators/plutus/plutus_generator.rb
require 'rails/generators'
require 'rails/generators/migration'
require_relative 'base_generator'

module Plutus
  class ExtraAccountFieldsGenerator < BaseGenerator
    def create_migration_file
      migration_template 'extra_account_fields.rb', 'db/migrate/add_plutus_extra_account_fields.rb'
    end
  end
end
