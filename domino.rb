class Domino

  def initialize
    @domino = generate_array
    @longest_path = find_longest_path @domino
  end

  def generate_array
    array = []
    for i in 0..12
      for k in i..12
        array << [i, k]
      end
    end
    domino = []
    (1..10).each { domino << array.delete_at( rand(array.length) ) }
    domino
  end

  def find_longest_path (domino, first_chain = nil, available = domino.dup)
    paths = available.each_index.select do |edge_idx|
      first_chain.nil? || available[edge_idx].include?(first_chain)
    end.map do |edge_idx|
      edge = available[edge_idx]
      edge = edge.reverse if first_chain && edge.first != first_chain
      [edge, *find_longest_path(domino, edge.last, available[0...edge_idx] + available[edge_idx+1..-1])]
    end
    if first_chain.nil? && domino == available
      paths << find_longest_path(domino, nil, domino.map(&:reverse))
    end
      paths.max_by { |path| path.length }
  end
end
