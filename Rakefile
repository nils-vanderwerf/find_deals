# frozen_string_literal: true
require "bundler/gem_tasks"
require "rubocop/rake_task"
require_relative "./config/environment"
require "sinatra/activerecord/rake" 

RuboCop::RakeTask.new

task default: :rubocop

task :console do
    require 'irb'
    ARGV.clear ##basically a variable that contains the arguments passed to a program through the command line.
    IRB.start
  end