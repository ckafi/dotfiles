fn pacman_pkg_internal [arg]{
  pacman -Qqs $arg
}

fn pacman_pkg_external [arg]{
  pacman -Sqs $arg
}

fn pacman_is_mode [mode args]{
  or (peach [arg]{ str:has-prefix $arg $mode } $args)
}

fn pacman_main_opt [@args]{
  opt-specs = [
  [&short=D &long=database &desc="Operate on the package database"]
  [&short=Q &long=query &desc="Query the package database"]
  [&short=R &long=remove &desc="Remove package(s) from the system"]
  [&short=S &long=sync &desc="Synchronize packages"]
  [&short=T &long=deptest &desc="Check dependencies"]
  [&short=U &long=upgrade &desc="Upgrade or add package(s)"]
  [&short=F &long=files &desc="Query the files database"]
  ]
  edit:complete-getopt $args $opt-specs []
}

fn pacman_gen_opt [@args]{
  opt-specs = [
  [&short=b &long=dbpath &desc="Specify an alternative database location"]
  [&short=r &long=root &desc="Specify an alternative installation root"]
  [&long=arch &desc="Specify an alternate architecture"]
  [&long=cachedir &desc="Specify an alternative package cache location"]
  [&long=color &desc="Specify when to enable coloring"]
  [&long=config &desc="Specify an alternate configuration file"]
  [&long=debug &desc="Display debug messages"]
  [&long=gpgdir &desc="Specify a directory of files used by GnuPG"]
  [&long=hookdir &desc="Specify a alternative directory containing hook files"]
  [&long=logfile &desc="Specify an alternate log file."]
  [&long=noconfirm &desc="Bypass any and all “Are you sure?” messages"]
  [&long=confirm &desc="Cancels the effects of a previous --noconfirm"]
  [&long=disable-download-timeout &desc="Disable defaults for low speed limit and timeout on downloads"]
  [&long=sysroot &desc="Specify an alternative system root"]
  ]
  edit:complete-getopt $args $opt-specs []
}

fn pacman_transact_opt [@args]{
  opt-specs = [
  [&short=d &long=nodeps &desc="Skips dependency version checks"]
  [&long=assume-installed &desc="Add a virtual package"]
  [&long=dbonly &desc="Adds/removes the database entry only"]
  [&long=noprogressbar &desc="Do not show a progress bar when downloading files"]
  [&long=noscriptlet &desc="If an install scriptlet exists, do not execute it"]
  [&short=p &long=print &desc="Only print the targets instead of performing the actual operation"]
  [&long=print-format &desc="Specify a printf-like format"]
  ]
  edit:complete-getopt $args $opt-specs []
}

fn pacman_upgrade_opt [@args]{
  opt-specs = [
  [&long=asdeps &desc="Install packages non-explicitly"]
  [&long=asexplicit &desc="Install packages explicitly"]
  [&long=ignore &desc="Directs pacman to ignore upgrades of package"]
  [&long=ignoregroup &desc="Directs pacman to ignore upgrades of all packages in group"]
  [&long=needed &desc="Do not reinstall the targets that are already up-to-date"]
  [&long=overwrite &desc="Bypass file conflict checks and overwrite conflicting files"]
  ]
  edit:complete-getopt $args $opt-specs []
}

fn pacman_query_opt [@args]{
  opt-specs = [
  [&short=c &long=changelog &desc="View the ChangeLog of a package"]
  [&short=d &long=deps &desc="Restrict or filter output to packages installed as dependencies"]
  [&short=e &long=explicit &desc="Restrict or filter output to explicitly installed packages"]
  [&short=g &long=groups &desc="Display all packages that are members of a named group"]
  [&short=i &long=info &desc="Display information on a given package"]
  [&short=k &long=check &desc="Check that all files owned by the given package(s) are present on the system"]
  [&short=l &long=list &desc="List all files owned by a given package"]
  [&short=m &long=foreign &desc="Restrict or filter output to packages that were not found in the sync database(s)"]
  [&short=n &long=native &desc="Restrict or filter output to packages that are found in the sync database(s)"]
  [&short=o &long=owns &desc="Search for packages that own the specified file(s)"]
  [&short=p &long=file &desc="Signifies that the package supplied on the command line is a file"]
  [&short=q &long=quiet &desc="Show less information for certain query operations"]
  [&short=s &long=search &desc="Search each locally-installed package for names or descriptions"]
  [&short=t &long=unrequired &desc="Restrict or filter output to print only packages not (optionally) required"]
  [&short=u &long=upgrades &desc="Restrict or filter output to packages that are out-of-date"]
  ]
  edit:complete-getopt $args $opt-specs [$pacman_pkg_internal~ ...]
}

fn pacman_remove_opt [@args]{
  opt-specs = [
  [&short=c &long=cascade &desc="Remove all target packages, as well as all packages that depend"]
  [&short=n &long=nosave &desc="Instructs pacman to ignore file backup designations"]
  [&short=s &long=recursive &desc="Remove each target specified including all of their dependencies"]
  [&short=u &long=unneeded &desc="Removes targets that are not required by any other packages"]
  ]
  edit:complete-getopt $args $opt-specs [$pacman_pkg_internal~ ...]
}

fn pacman_sync_opt [@args]{
  opt-specs = [
  [&short=c &long=clean &desc="Remove packages that are no longer installed"]
  [&short=g &long=groups &desc="Display all the members for each package group specified"]
  [&short=i &long=info &desc="Display information on a given sync database package"]
  [&short=l &long=list &desc="List all packages in the specified repositories"]
  [&short=q &long=quiet &desc="Show less information for certain sync operations"]
  [&short=s &long=search &desc="This will search each package in the sync databases"]
  [&short=u &long=sysupgrade &desc="Upgrades all packages that are out-of-date"]
  [&short=w &long=downloadonly &desc="Retrieve all packages from the server, but do not install/upgrade anything"]
  [&short=y &long=refresh &desc="Download a fresh copy of the master package database from the server(s)"]
  ]
  edit:complete-getopt $args $opt-specs [$pacman_pkg_external~ ...]
}

fn pacman_database_opt [@args]{
  opt-specs = [
  [&long=asdeps &desc="Mark a package as non-explicitly installed"]
  [&long=asexplicit &desc="Mark a package as explicitly installed"]
  [&short=k &long=check &desc="Check the local package database is internally consistent"]
  [&short=q &long=quiet &desc="Suppress messages on successful completion of database operations"]
  ]
  edit:complete-getopt $args $opt-specs [$pacman_pkg_internal~ ...]
}

fn pacman_file_opt [@args]{
  opt-specs = [
  [&short=y &long=refresh &desc="Download fresh package databases from the server."]
  [&short=l &long=list &desc="List the files owned by the queried package"]
  [&short=x &long=regex &desc="Interpret each query as a regular expression"]
  [&short=q &long=quiet &desc="Show less information for certain file operations."]
  [&long=machinereadable &desc="Print each match in a machine readable output format."]
  ]
  edit:complete-getopt $args $opt-specs [$pacman_pkg_external~ ...]
}

edit:completion:arg-completer[pacman] = [@args]{
  if (== (count $args) 2) {
    pacman_main_opt $@args
  } elif (pacman_is_mode "-D" $args) {
    pacman_database_opt $@args
  } elif (pacman_is_mode "-Q" $args) {
    pacman_query_opt $@args
  } elif (pacman_is_mode "-R" $args) {
    pacman_transact_opt $@args
    pacman_remove_opt $@args
  } elif (pacman_is_mode "-S" $args) {
    pacman_transact_opt $@args
    pacman_upgrade_opt $@args
    pacman_sync_opt $@args
  } elif (pacman_is_mode "-T" $args) {
  } elif (pacman_is_mode "-U" $args) {
    pacman_transact_opt $@args
    pacman_upgrade_opt $@args
    edit:complete-filename $@args
  } elif (pacman_is_mode "-F" $args) {
    pacman_file_opt $@args
  }
  pacman_gen_opt $@args
}
