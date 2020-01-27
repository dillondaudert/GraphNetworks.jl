##################################################
# GraphNetwork types
##################################################
"""
A GraphNetwork is a directed multi-graph where every node, edge, and the graph
itself can have attributes. Attributes are properties that can be encoded as
vectors, sets, or other GraphNetworks.

Since GraphNetworks are multi-graphs, multiple edges are allowed which have the
same source and destination nodes.
"""
abstract type GraphNetwork{V} <: AbstractGraph{V} end

#################################################
# GraphNetwork functions
#################################################
"""
    step!(g::GraphNetwork)

Perform a single, complete update step on a given graph network. This performs
edge, node, and global attribute updates.
"""
function step!(g::GraphNetwork)
    for edge in edges(g)
        update_edge!(g, edge)
    end
    for node in vertices(g)
        update_node!(g, node)
    end
    update_graph!(g)
    return g
end

"""
    update_edge!(g::GraphNetwork, edge::GNEdge)

Update the attribute(s) of a single edge in the graph network.
"""
function update_edge!(g::GraphNetwork, edge::GNEdge) end

"""
    update_node!(g::GraphNetwork, node::GNNode)

Update the attribute(s) of a single node in the graph network. This calls
aggregate_node!(g, node).
"""
function update_node!(g::GraphNetwork, node::GNNode) end

"""
    update_global!(g::GraphNetwork)

Update the global graph attribute(s). This calls aggregate_edges!(g) and
aggregate_nodes!(g).
"""
function update_global!(g::GraphNetwork) end

"""
    aggregate_node!(g::GraphNetwork, node::GNNode)

Aggregate across all the incoming edges of `node`. This returns an instance
of `g`'s edge type.
"""
function aggregate_node!(g::GraphNetwork, node::GNNode) end

"""
    aggregate_edges!(g::GraphNetwork)

Aggregate across **all** edges in the graph `g`. This returns an instance of `g`'s
edge type.
"""
function aggregate_edges!(g::GraphNetwork) end

"""
    aggregate_nodes!(g::GraphNetwork)

Aggregate across **all** nodes in the graph `g`. This returns an instance of `g`'s
node type.
"""
function aggregate_nodes!(g::GraphNetwork) end

##################################################
# GraphNetwork node types
##################################################
"""
Abstract supertype of GraphNetwork nodes.
"""
abstract type GNNode <: AbstractNode end

##################################################
# GraphNetwork edge types
##################################################

"""
Abstract supertype of GraphNetwork edges.
"""
abstract type GNEdge <: AbstractEdge end
