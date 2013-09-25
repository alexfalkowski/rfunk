require 'spec_helper'

describe RFunk::Maybe do
  context 'None' do
    context "can't create a new maybe" do
      When(:result) { RFunk::Maybe.new }
      Then { result == Failure(NoMethodError) }
    end

    context 'nil is nothing' do
      When(:result) { Some(nil) }
      Then { result == RFunk::Nothing }
    end

    context 'fetch' do
      context 'fetch is nothing' do
        When(:result) { Some(nil) }
        Then { result.fetch == RFunk::Nothing }
      end

      context 'fetch({}) is nothing' do
        When(:result) { Some(nil) }
        Then { result.fetch({}) == RFunk::Nothing }
      end

      context 'fetch(Nothing) is nothing' do
        When(:result) { Some(nil) }
        Then { result.fetch(Nothing) == RFunk::Nothing }
      end

      context 'fetch(3) is just' do
        When(:result) { Some(nil) }
        Then { result.fetch(3) == Some(3) }
      end
    end

    context 'Maybe(Nothing) is Nothing' do
      When(:result) { Some(RFunk::Nothing) }
      Then { result == RFunk::Nothing }
    end

    context 'nil always has nothing as a result' do
      context 'single value' do
        When(:result) { Some(nil).a }
        Then { result == RFunk::Nothing }
      end

      context 'double value' do
        When(:result) { Some(nil).a.b }
        Then { result == RFunk::Nothing }
      end

      context 'triple value' do
        When(:result) { Some(nil).a.b.c }
        Then { result == RFunk::Nothing }
      end
    end

    context 'non-existent methods always has nothing as a result' do
      context 'single value' do
        When(:result) { Some({}).a }
        Then { result == RFunk::Nothing }
      end

      context 'double value' do
        When(:result) { Some({}).a.b }
        Then { result == RFunk::Nothing }
      end

      context 'triple value' do
        When(:result) { Some({}).a.b.c }
        Then { result == RFunk::Nothing }
      end
    end

    context 'non-existent keys always has nothing as a result' do
      context 'single value' do
        When(:result) { Some({})[:a] }
        Then { result == RFunk::Nothing }
      end

      context 'double value' do
        When(:result) { Some({})[:a][:b] }
        Then { result == RFunk::Nothing }
      end

      context 'triple value' do
        When(:result) { Some({})[:a][:b][:c] }
        Then { result == RFunk::Nothing }
      end
    end
  end
end
