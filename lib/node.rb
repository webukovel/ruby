class Node
  attr_reader :id, :outputs
  attr_accessor :processed, :checkpoints, :time

  def initialize(id)
    @id = id
    @outputs = []
    @time = 0
    @processed == false
    @checkpoints = [id]
  end
end
