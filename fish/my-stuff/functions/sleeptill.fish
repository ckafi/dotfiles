function sleeptill -d "Sleep until the provided time"
  set -l difference (math (date -d $argv +%s) - (date +%s))
  if [ $difference -le 0 ]
    set difference (math $difference + 86400)
  end
  echo "Sleeping for $difference seconds..."
  sleep $difference
end
