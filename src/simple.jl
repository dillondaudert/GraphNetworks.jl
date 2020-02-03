# a simple GraphNetwork implementation
# a set of nodes and vectors, each having a single probability
#   vector as attributes. the aggregate functions compute the
#   mean of the incoming probabilities for nodes and globally

mutable struct SimpleGN{V, E, A} <: GraphNetwork{V}
    _probabilities::A
    _agg_edges::E
    _agg_nodes::V
end

mutable struct Simple
