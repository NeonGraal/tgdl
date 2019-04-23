Get-ChildItem .\samples -Filter *.tgdl | ForEach-Object {
    $input = Resolve-Path $_.FullName -Relative
    $output = $input -replace ".tgdl",".pdf"

    Write-Host "Rendering $input => $output"
    &stack run -- -o $output $input
}
