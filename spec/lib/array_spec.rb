describe Array do
  let(:empty_array) { Array.new }

  describe '#to_s' do
    it { should respond_to :to_s }

    context 'if empty' do
      subject { Array.new.to_s }

      it { should eq '[]' }
    end

    context 'if 1 element' do
      subject { Array.new(1, 1).to_s }

      it { should eq '[1]' }
    end

    context 'if many elements' do
      subject { Array.new(5, "5").to_s }

      it { should eq '["5", "5", "5", "5", "5"]' }
    end
  end
end

