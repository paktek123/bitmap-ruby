require 'spec_helper'

describe BitmapEditor do

  subject { described_class.new }

  describe 'GridOperations:: ' do
    context 'Generate Image:: ' do
      it 'generate an image attribute which is a 4 by 5 nested array or matrix' do
        expectation = Array.new(4){ Array.new(5){"O"} }
        expect(subject.generate_image(4,5)).to eq(expectation)
      end

      it 'should clear the image to a blank state' do
        original = subject.generate_image(4,5)
        cleared = subject.clear_image
        expect(original).to eq(cleared)
      end

      it 'should colour the selected pixel' do
        subject.generate_image(4,5)
        subject.colour_pixel(1,1,"A")
        expect(subject.image[0][0]).to eq("A")
      end

      it 'should draw a vertical line' do
        subject.generate_image(4,5)
        subject.colour_vertical(1,1,4,"W")
        expect(subject.image[0][0]).to eq("W")
        expect(subject.image[1][0]).to eq("W")
        expect(subject.image[2][0]).to eq("W")
        expect(subject.image[3][0]).to eq("W")
      end

      it 'should draw a horizontal line' do
        subject.generate_image(4,5)
        subject.colour_horizontal(1,4,1,"W")
        expect(subject.image[0][0]).to eq("W")
        expect(subject.image[0][1]).to eq("W")
        expect(subject.image[0][2]).to eq("W")
        expect(subject.image[0][3]).to eq("W")
      end
    end
  end
end
