struct GN
    edge_units
    node_units
    global_units
    Wₑ
    bₑ
    Wᵥ
    bᵥ
    Wᵤ
    bᵤ
end
# Create the variables for the Graph Network block
GN(edge_units, node_units, global_units) = GN(
    edge_units, node_units, global_units,
    param(randn(edge_units, edge_units+2*node_units+global_units)), 
    param(zeros(edge_units)), 
    param(randn(node_units, edge_units+node_units+global_units)), 
    param(zeros(node_units)),
    param(randn(global_units, edge_units+node_units+global_units)), 
    param(zeros(global_units)))
"""
graph network block
E is an array of triples=(i, j, e) indicates the 
    indicates for the sender, receiver nodes for
    an edge, and the edge attributes
V is an array [[values]] where each element i
    of the array representes the attributes for
    node i.
u is an array of attributes.
"""
function (g::GN)(x)
    E, V, u = x
    # compute edge updates
    E′ = [(i, j, ϕᵉ(g, eₖ, V[i], V[j], u)) for (i, j, eₖ) in E]
    # aggregate per-node edge attributes
    ēᵛ = ρᵛ(E′, V)
    # compute node updates
    V′ = vcat([ϕᵛ(g, V[i], ēᵛ[i], u) for i in 1:size(V)[1]])
    # aggregate edge attributes
    ē = ρᵉ(E′)
    # aggregate node attributes
    v̄ = ρᵘ(V′)
    # compute updated global attribute
    u′ = ϕᵘ(g, ē, v̄, u)
    return (E′, V′, u′)
end
Flux.treelike(GN)