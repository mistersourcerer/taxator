# frozen_string_literal: true

require "taxator"

module Taxator
  module SpecHelper
    def _fixtures_path
      @path ||= File.expand_path("../fixtures", __FILE__)
    end

    def fixture_path(name)
      path = File.join _fixtures_path, name
      return nil if !File.exist?(path)
      path
    end

    def fixture(name)
      path = fixture_path(name)
      File.read(path) if path
    end
  end
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.include Taxator::SpecHelper
end
