# frozen_string_literal: true

require 'guard/compat/plugin'
require 'pry'

module Guard
  class Treetop < Plugin
    attr_reader :output_filename

    def initialize(options)
      super
      @output_filename = options.fetch(
        :output_filename,
        proc { |input| input.gsub(/\.(treetop|tt)/, '_grammar.rb') }
      )
    end

    def start
      run_all if options[:all_on_start]
    end

    def run_all
      compile(Guard::Watcher.match_files(self, Dir.glob('**/*')))
    end

    def run_on_additions(paths)
      compile(paths)
    end

    def run_on_modifications(paths)
      compile(paths)
    end

    private

    def compile(paths)
      paths.each do |path|
        out = output_filename.call(path)
        puts "Converting #{path} to #{out} using Treetop"
        `bundle exec tt #{path} -o #{out}`
      end
    end
  end
end
