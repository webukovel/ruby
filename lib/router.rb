BG = [
[0, 4,  8,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0],
[2, 0,  2,  0,  0,  3,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0],
[0, 4,  0,  0,  0,  0,  1,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,	0],
[0,	0,	0,	0,	6,	0,	4,	0,	0,	2,	0,	0,	0,	0,	0,	0,	0,	0],
[0,	0,	0,	3,	0,	0,	0,	0,	0,	4,	3,	0,	0,	0,	0,	0,	0,	0],
[0,	0,	0,	0,	0,	0,	0,	16,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0],
[0,	0,	1,	0,	0,	0,	0,	0,	1,	0,	0,  0,  0,  0,  0,	0,	0,	0],
[0,	0,	0,	0,	0,	8,	0,	0,	0,	0,	0,	0,	2,	0,	0,	0,	0,	0],
[0,	0,	0,	0,	0,	0,	1,	0,	0,	0,	0,	0,	0,	0,	8,	0,	0,	0],
[0,	0,	0,	0,	8,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0],
[0,	0,	0,	0,	0,	0,	0,	0,	0,	5,	0,	0,	0,	0,	4,	0,	0,	0],
[0,	0,	5,	0,	0,	0,  0,	0,	0,	0,	0,	0,	0,	3,	0,	0,	0,	0],
[0,	0,	0,	0,	0,	0,  0,	4,	0,	0,	0,	3,	0,	6,	0,	6,	0,	0],
[0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	6,	0,	0,	4,	0,	10,	0],
[0,	0,	0,	0,	0,	0,	0,	0,	16,	0,	2,	0,	0,	8,	0,	0,	0,	0],
[0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	3,	0,	0,	0,	3,	0],
[0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	5,	0,	0,	0,	3],
[0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	6,	0]]
END_POINT = 6

def to_points(way)
  BG[way.last].map.with_index do |w,i|
    i if w != 0 && (!way.include?(i) || i == END_POINT)
  end.compact
end

def recarculate_ways
  @ways = @ways.inject([]) do |new_ways, way|
    next new_ways << way.dup if way.last == END_POINT
    new_ways.concat(to_points(way).map{|tp| way.dup << tp})
  end
end

def calculate_times
  @times = @ways.inject([]) do |res, way|
    res << (0...way.count-1).inject(0) do |sum, i|
      sum += BG[way[i]][way[i+1]]
    end
  end
end

def route_from(strat_point)
  @ways = [[strat_point]]

  recarculate_ways until @ways.map(&:last).uniq == [END_POINT]
  calculate_times

  { time: @times.min,
    checkpoints: @ways[@times.rindex(@times.min)] }
end