ENV["JULIA_EDITOR"] = "mvim"

function typetree(T, level=0)
    println("\t" ^ level, T)
    for t in subtypes(T)
        typetree(t, level+1)
    end
end

function supertypes(T)
    println(T)
    if T != Any
        supertypes(supertype(T))
    end
end
