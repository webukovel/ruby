require 'spec_helper'

describe '#route_from' do
  it 'should build shortest route from point 1' do
    expect(route_from(1)[:time]).to eq 3
    expect(route_from(1)[:checkpoints]).to eq [1,2,6]
  end

  it 'should build shortest route from point 15' do
    expect(route_from(15)[:time]).to eq 12
    expect(route_from(15)[:checkpoints]).to eq [15,12,11,2,6]
  end

  it 'should build shortest route from point 17' do
    expect(route_from(17)[:time]).to eq 23
    expect(route_from(17)[:checkpoints]).to eq [17,16,13,11,2,6]
  end

  it 'should build shortest route from point 0' do
    expect(route_from(0)[:time]).to eq 7
    expect(route_from(0)[:checkpoints]).to eq [0,1,2,6]
  end

  it 'should build shortest route from point 10' do
    expect(route_from(10)[:time]).to eq 20
    expect(route_from(10)[:checkpoints]).to eq [10,9,4,3,6]
  end

  it 'should build shortest route from point 7' do
    expect(route_from(7)[:time]).to eq 11
    expect(route_from(7)[:checkpoints]).to eq [7,12,11,2,6]
  end
end
