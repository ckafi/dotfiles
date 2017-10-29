function fasd_fzf -d "Provides fuzzy wrapper around fasd"
  fasd -lR{$argv[2]} "$argv[1]" | fzf --no-sort -0 -1 | read -l param
  if [ -n $param ]
    echo "$param"
  else
    return 1
  end
end
