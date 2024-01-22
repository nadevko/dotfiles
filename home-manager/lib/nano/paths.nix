{
  backupdir = ''
    Make and keep not just one backup file, but make and keep a uniquely
    numbered one every time a file is saved -- when backups are enabled with set
    backup or --backup or -B. The uniquely numbered files are stored in the
    specified directory.
  '';
  operatingdir = ''
    Nano will only read and write files inside directory and its subdirectories.
    Also, the current directory is changed to here, so files are inserted from
    this directory. By default, the operating directory feature is turned off.
  '';
}
