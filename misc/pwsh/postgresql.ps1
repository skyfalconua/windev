$PgRoot      = "C:\opt\Apps\pgsql"
$PgPort      = 5432
$PgSuperUser = "postgres"
$PgPassword  = "password"

$PgBin  = Join-Path $PgRoot  "bin"
$PgData = Join-Path $PgRoot "_data"   # database cluster

# ----------------------------------------------------------------------------
#
# ONE-TIME SETUP
#
#  "C:\opt\Apps\pgsql\bin\initdb.exe" -D C:\opt\Apps\pgsql\_data -U postgres -A scram-sha-256 -W -E UTF8
#
# ----------------------------------------------------------------------------

function _pginvoke($exe, $a = @()) {
    $path = Join-Path $PgBin "$exe.exe"
    if (-not (Test-Path $path)) { throw "Not found: $path. Check `$PgRoot and the setup notes." }
    if ($PgPassword) { $env:PGPASSWORD = $PgPassword }
    & $path @a
    if ($LASTEXITCODE -ne 0) { throw "$exe failed (exit code $LASTEXITCODE)" }
}

# Run the server in the foreground. Logs print to this window; Ctrl+C stops it.
function pgstart() {
    if (-not (Test-Path (Join-Path $PgData "PG_VERSION"))) {
        throw "Data directory not initialized: $PgData (see setup notes at the top of this file)"
    }
    _pginvoke "postgres" @("-D", $PgData, "-p", "$PgPort")
}

# Open psql, or run a command / file. Params mirror psql flags:
#   pgrun                      # interactive, db "postgres"
#   pgrun mydb                 # database is positional
#   pgrun mydb -c "select 1"   # run a command
#   pgrun mydb -f init.sql     # run a file
#   pgrun mydb -u appuser      # different user
#
function pgrun($d = "postgres", $c, $f) {
    $a = @("-h", "localhost", "-p", "$PgPort", "-U", $PgSuperUser, "-d", $d)
    if ($c) { $a += @("-c", $c) }
    if ($f) { $a += @("-f", $f) }
    _pginvoke psql $a
}
