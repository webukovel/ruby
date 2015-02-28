class Graph
  def initialize(matrix)
    @nodes = {}
    @edges = []
    init_from_matrix(matrix)
  end

  def min_path(from, to)
    @nodes[from].processed = true
    cross_outputs = @nodes[from].outputs
    (@nodes.count - 1).times do
      min_edge = current_min_edge(cross_outputs)
      start_node = @nodes[min_edge.start_node_id]
      end_node = @nodes[min_edge.end_node_id]
      end_node.checkpoints = start_node.checkpoints + [end_node.id]
      end_node.time = start_node.time + min_edge.time
      end_node.processed = true
      end_node.outputs.each do |edge|
        cross_outputs << edge
      end
      if end_node.id == to
        return {
          time: end_node.time,
          checkpoints: end_node.checkpoints
        }
      end
    end
    raise Exception.new("No routes from #{from} to #{to} found.")
  end

  private

  def init_from_matrix(matrix)
    matrix.each_with_index do |line, node_index|
      node = Node.new(node_index)
      add_node(node)
      line.each_with_index do |time, index|
        next if time == 0
        end_node = Node.new(index)
        add_node(end_node)
        add_edge Edge.new(node.id, end_node.id, time)
      end
    end
  end

  def add_node(node)
    @nodes[node.id] = node unless @nodes[node.id]
  end

  def add_edge(edge)
    @nodes[edge.start_node_id].outputs << edge
    @edges << edge
  end

  def unprocessed_edges(edges)
    edges.select { |edge| !@nodes[edge.end_node_id].processed }
  end

  def current_min_edge(edges)
    unprocessed_edges(edges).min_by do |edge|
      @nodes[edge.start_node_id].time + edge.time
    end
  end
end
