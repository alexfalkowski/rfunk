describe RFunk::None do
  context 'None' do
    context 'nil is none' do
      When(:result) { RFunk.option(nil) }
      Then { result == RFunk.none }
    end

    context 'value' do
      context 'value is none' do
        When(:result) { RFunk.option(nil) }
        Then { result.value == RFunk.none }
      end

      context 'value({}) is none' do
        When(:result) { RFunk.option(nil) }
        Then { result.value({}) == RFunk.none }
      end

      context 'value(none) is none' do
        When(:result) { RFunk.option(nil) }
        Then { result.value(RFunk.none) == RFunk.none }
      end

      context 'value(3) is just' do
        When(:result) { RFunk.option(nil) }
        Then { result.value(3) == RFunk.some(3) }
      end
    end

    context 'Maybe(none) is none' do
      When(:result) { RFunk.option(RFunk.none) }
      Then { result == RFunk.none }
    end

    context 'nil always has none as a result' do
      context 'single value' do
        When(:result) { RFunk.option(nil).a }
        Then { result == RFunk.none }
      end

      context 'double value' do
        When(:result) { RFunk.option(nil).a.b }
        Then { result == RFunk.none }
      end

      context 'triple value' do
        When(:result) { RFunk.option(nil).a.b.c }
        Then { result == RFunk.none }
      end
    end

    context 'non-existent methods always has none as a result' do
      context 'single value' do
        When(:result) { RFunk.option({}).a }
        Then { result == RFunk.none }
      end

      context 'double value' do
        When(:result) { RFunk.option({}).a.b }
        Then { result == RFunk.none }
      end

      context 'triple value' do
        When(:result) { RFunk.option({}).a.b.c }
        Then { result == RFunk.none }
      end
    end

    context 'non-existent keys always has none as a result' do
      context 'single value' do
        When(:result) { RFunk.option({})[:a] }
        Then { result == RFunk.none }
      end

      context 'double value' do
        When(:result) { RFunk.option({})[:a][:b] }
        Then { result == RFunk.none }
      end

      context 'triple value' do
        When(:result) { RFunk.option({})[:a][:b][:c] }
        Then { result == RFunk.none }
      end
    end

    context 'none with or to return the other value' do
      context 'single value' do
        When(:result) { RFunk.option(nil).a.or('test') }
        Then { result == RFunk.some('test') }
      end

      context 'double value' do
        When(:result) { RFunk.option(nil).a.b.or('test') }
        Then { result == RFunk.some('test') }
      end

      context 'triple value' do
        When(:result) { RFunk.option(nil).a.b.c.or('test') }
        Then { result == RFunk.some('test') }
      end

      context 'nil value' do
        When(:result) { RFunk.option(nil).a.b.c.or(nil) }
        Then { result == RFunk.none }
      end
    end

    context 'already a None' do
      When(:result) { RFunk.option(RFunk.none) }
      Then { result == RFunk.none }
    end

    context 'pipeline' do
      When(:result) { RFunk.none.pipe { |h| h.merge(b: 1) }.pipe { |h| h.merge(c: 1) } }
      Then { result == RFunk.none }
    end
  end
end
