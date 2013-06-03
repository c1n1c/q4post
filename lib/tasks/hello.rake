#!/usr/bin/env rake

require 'rake/clean'

directory "tmp"
CLEAN.include('tmp')

file "tmp/hello.txt" => "tmp" do |t|
  sh "touch #{t.name}"
end

namespace :hello do
  task :default => :hello

  desc "Creates tmp directory"
  task :install => "tmp"

  desc "Creates hello.txt in tmp directory"
  task :create => "tmp/hello.txt"

  desc "Writes Hello to hello.txt"
  task :hello => "tmp/hello.txt" do |t|
    sh "echo 'Hello' > '#{t.prerequisites[0]}'"
  end
end
