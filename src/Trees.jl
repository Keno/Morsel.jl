# Tree data type used for a routing tree.
type Tree
    value::Any
    children::Array{Tree,1}
end
Tree(value::Any) = Tree(value, Tree[])

function ischild(element, tree::Tree)
    for child in tree.children
        if isequal(child.value, element)
            return true
        end
    end
    return false
end

function getchild(tree::Tree, element)
    for child in tree.children
        if isequal(child.value, element)
            return child
        end
    end
end

function insert!(tree::Tree, values::Array)
    if isempty(values)
        tree
    elseif ischild(values[1], tree)
        t = getchild(tree, values[1])
        insert!(t, values[2:end])
    else
        t = Tree(values[1])
        insert!(t, values[2:end])
        push!(tree.children, t)
    end
end

abstract SearchStrategy

type DFS <: SearchStrategy end

function search(tree::Tree, pred::Function)
    action = pred(tree.value)
    if action == true
        (tree.value,false)
    elseif action == :prune
        (nothing,false)
    elseif action == :defer
        (tree.value,true)
    elseif action == false
        defered = nothing
        for child in tree.children
            val,isdefered = search(child, pred)
            if val != nothing
                if !isdefered
                    return (val,false)
                elseif defered !== nothing
                    error("Multiple fallback routes")
                else
                    defered = val
                end
            end
        end
        if defered !== nothing
            return (defered,false)
        end
        (nothing,false)
    end
end
