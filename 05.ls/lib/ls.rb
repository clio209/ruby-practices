#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative './filename'
require_relative './command'
require_relative './output'

output_data = Output.new
output_data.output
