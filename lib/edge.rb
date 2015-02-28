class Edge
  attr_reader :start_node_id, :end_node_id, :time

  def initialize(start_node_id, end_node_id, time)
    @start_node_id = start_node_id
    @end_node_id = end_node_id
    @time = time
  end
end
