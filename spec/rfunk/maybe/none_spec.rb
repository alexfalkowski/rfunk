require 'spec_helper'

describe RFunk::None do
  context 'None' do
    context 'nil is none' do
      When(:result) { Option(nil) }
      Then { result == None() }
    end

    context 'value' do
      context 'value is none' do
        When(:result) { Option(nil) }
        Then { result.value == None() }
      end

      context 'value({}) is none' do
        When(:result) { Option(nil) }
        Then { result.value({}) == None() }
      end

      context 'value(none) is none' do
        When(:result) { Option(nil) }
        Then { result.value(None()) == None() }
      end

      context 'value(3) is just' do
        When(:result) { Option(nil) }
        Then { result.value(3) == Some(3) }
      end
    end

    context 'Maybe(none) is none' do
      When(:result) { Option(None()) }
      Then { result == None() }
    end

    context 'nil always has none as a result' do
      context 'single value' do
        When(:result) { Option(nil).a }
        Then { result == None() }
      end

      context 'double value' do
        When(:result) { Option(nil).a.b }
        Then { result == None() }
      end

      context 'triple value' do
        When(:result) { Option(nil).a.b.c }
        Then { result == None() }
      end
    end

    context 'non-existent methods always has none as a result' do
      context 'single value' do
        When(:result) { Option({}).a }
        Then { result == None() }
      end

      context 'double value' do
        When(:result) { Option({}).a.b }
        Then { result == None() }
      end

      context 'triple value' do
        When(:result) { Option({}).a.b.c }
        Then { result == None() }
      end
    end

    context 'non-existent keys always has none as a result' do
      context 'single value' do
        When(:result) { Option({})[:a] }
        Then { result == None() }
      end

      context 'double value' do
        When(:result) { Option({})[:a][:b] }
        Then { result == None() }
      end

      context 'triple value' do
        When(:result) { Option({})[:a][:b][:c] }
        Then { result == None() }
      end
    end

    context 'none with or to return the other value' do
      context 'single value' do
        When(:result) { Option(nil).a.or('test') }
        Then { result == Some('test') }
      end

      context 'double value' do
        When(:result) { Option(nil).a.b.or('test') }
        Then { result == Some('test') }
      end

      context 'triple value' do
        When(:result) { Option(nil).a.b.c.or('test') }
        Then { result == Some('test') }
      end

      context 'nil value' do
        When(:result) { Option(nil).a.b.c.or(nil) }
        Then { result == None() }
      end
    end

    context 'already a None' do
      When(:result) { Option(None()) }
      Then { expect(result).to eq(None()) }
    end
  end
end
