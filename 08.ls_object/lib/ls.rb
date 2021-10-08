#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative './basedata'
require_relative './command'
require_relative './output'

output_data = Output.new
output_data.output
