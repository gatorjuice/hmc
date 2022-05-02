# frozen_string_literal: true

require_relative "hmc/version"
require_relative "hmc/option"
require_relative "hmc/decider"
require "tty-prompt"

module Hmc
  prompt = TTY::Prompt.new
  decider = Hmc::Decider.new

  puts "Hello! Welcome to Help Me Choose! :D"

  prefs = prompt.no?("Are you already leaning towards any of the options?")
  opt_num = prompt.ask("How many options do you want it narrowed down to?", default: "1").to_i

  puts "\nPlease enter the options you're considering: "

  loop.with_index do |_, index|
    if prefs
      decider.add_option(Hmc::Option.new(prompt.ask("Please enter option #{index + 1}:")))
    else
      option_description = prompt.ask("Please enter option #{index + 1}:")

      decider.add_option(
        Hmc::Option.new(
          option_description,
          weight: prompt.ask("How strongly are you leaning towards #{option_description}? (1-10):").to_i do |q|
            q.in "1-10"
          end
        )
      )
    end

    decider.print_current_options

    break unless prompt.yes?("Do you have more options to add?")
  end

  decider.decide(opt_num)
  decider.print_decision
end
