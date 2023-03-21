# frozen_string_literal: true

require 'guard/compat/test/helper'
require 'guard/treetop'

RSpec.describe Guard::Treetop, exclude_stubs: [Guard::Plugin] do
  let(:options) { {} }
  subject { described_class.new(options) }

  before do
    allow(Dir).to receive(:glob).and_return(['file1.treetop', 'nested/file2.treetop', 'other/file3.rb'])
  end

  describe '#start' do
    context 'with run_on_start option' do
      let(:options) { { all_on_start: true } }

      it 'runs all on start' do
        expect(subject).to receive(:run_all)
        subject.start
      end
    end

    context 'without run_on_start option' do
      it 'does nothing' do
        expect(subject).not_to receive(:run_all)
        subject.start
      end
    end
  end

  describe '#run_on_modifications' do
    it 'runs the treetop compiler on the modified files' do
      expect(subject).to receive(:`).with('bundle exec tt file1.treetop -o file1_grammar.rb').and_return(nil)
      subject.run_on_modifications(['file1.treetop'])
    end
  end

  describe '#run_on_additions' do
    it 'runs the treetop compiler on the added files' do
      expect(subject).to receive(:`).with(
        'bundle exec tt nested/file2.treetop -o nested/file2_grammar.rb'
      ).and_return(nil)
      subject.run_on_additions(['nested/file2.treetop'])
    end
  end

  context 'with a custom proc overriding the output filename' do
    let(:options) { { output_filename: ->(filename) { filename.gsub(/\.tt$/, '_treetop_grammar.rb') } } }

    it 'uses the custom proc to determine the output filename' do
      expect(subject).to receive(:`).with(
        'bundle exec tt nested/file.tt -o nested/file_treetop_grammar.rb'
      ).and_return(nil)
      subject.run_on_additions(['nested/file.tt'])
    end
  end
end
