module Hmc
  class Decider
    attr_reader :options, :decisions

    def initialize
      @options = []
      @decisions = []
    end

    def add_option(option)
      raise "#{option.inspect} is not an Option" unless option.is_a?(Hmc::Option)

      options << option
    end

    def print_current_options
      puts "\nCurrent options:\n"
      options.each do |option|
        puts option.description
      end
      puts ""
    end

    # returns 1 or more options as a decision
    def decide(how_many)
      options.sample(how_many).each do |option|
        decisions << option
      end

      decisions
    end

    def print_decision
      puts "\nFinal decision(s): \n"
      decisions.each { |options| puts "- #{options.description}" }
    end
  end
end
