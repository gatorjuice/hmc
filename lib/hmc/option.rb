# frozen_string_literal: true

module Hmc
  # Represents a potential choice in a decision.
  # Can be weighted to inform selection.
  class Option
    attr_reader :description, :weight

    DESC_ERROR = "Must provide a description"
    WEIGHT_ERROR = "Weight must be an integer between 1 and 10"

    def initialize(description, weight: 1)
      raise DESC_ERROR if description.empty?
      raise WEIGHT_ERROR unless weight.is_a?(Integer) && (1..10).include?(weight)

      @description = description
      @weight = weight
    end
  end
end
