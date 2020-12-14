# frozen_string_literal: true

require 'date'
require 'byebug'
require 'awesome_print'

require './lib/enumerable'

Dir['lib/get_available_slot_service/**/*.rb'].each { |file| require File.join('./', file) }
