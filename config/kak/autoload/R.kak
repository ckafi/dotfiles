# http://www.r-project.org
# ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾

# Detection
# ‾‾‾‾‾‾‾‾‾

hook global BufCreate .*\.(r|R) %{
    set-option buffer filetype R
}

# Highlighters
# ‾‾‾‾‾‾‾‾‾‾‾‾

add-highlighter shared/r regions
add-highlighter shared/r/code default-region group
add-highlighter shared/r/string  region '"' (?<!\\)(\\\\)*"         fill string
add-highlighter shared/r/comment region '#' '$'                     fill comment

add-highlighter shared/r/code/ regex \b(TRUE|T|FALSE|F|Inf|NaN) 0:value
add-highlighter shared/r/code/ regex \b(-?\d*\.?\d+(e-?\d+)?)\b 0:value
add-highlighter shared/r/code/ regex \b(if|else|repeat|while|function|for|in|next|break)\b 0:keyword
add-highlighter shared/r/code/ regex \b(library|require|load|save|source)\( 1:meta
add-highlighter shared/r/code/ regex \b(\S+)\h*<- 1:variable
add-highlighter shared/r/code/ regex \b(\S+)\h*<-\h*function\( 1:function
add-highlighter shared/r/code/ regex (\s|\w|\d|\))([+*-/~?!^<>$@]|\*\*|%%|[<>=!:]?=|<?<-|->>?|:{1,3}|&?&|\|?\|)(\s|\w|\d|\)) 2:operator

# Initialization
# ‾‾‾‾‾‾‾‾‾‾‾‾‾‾

hook -group r-highlight global WinSetOption filetype=R %{
    add-highlighter window/r ref r
    hook -once -always window WinSetOption filetype=.* %{ remove-highlighter window/r }
}
