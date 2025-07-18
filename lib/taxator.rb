# frozen_string_literal: true

require_relative "taxator/version"

module Taxator
  LIB_ROOT = _lib_path = File.expand_path("../", __FILE__)

  class Error < StandardError; end
end

$LOAD_PATH.unshift(Taxator::LIB_ROOT) unless $LOAD_PATH.include?(Taxator::LIB_ROOT)
