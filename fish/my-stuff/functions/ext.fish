function ext -d "Extract compressed archive"
  for file in $argv
    if test -f $file
      set lfile (echo $file | tr '[:upper:]' '[:lower:]')
      switch $lfile
        case '*.tar*' '*.tgz' '*.tbz'
          tar -xvf $file
        case '*.zip'
          7z x $file
        case '*.7z'
          7z x $file
        case '*'
          echo "'$file' is not a recognized archive"
      end
    end
  end
end
