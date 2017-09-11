function up -d "Go one or more directories up"
  if test (count $argv) -eq 0
    cd ..
    return
  end
  set -l ups ""
  for i in (seq $argv)
    set ups $ups"../"
  end
  cd $ups
end
