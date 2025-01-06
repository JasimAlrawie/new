
param(
    [switch]$h,
    [switch]$cd,
    [switch]$code,
    [switch]$git,
    [switch]$overwrite
)

if($args.Count -lt 1){
    Write-Host ""
    Write-Host "commands:" -ForegroundColor Cyan
    Write-Host "  folder"
    Write-Host "  file"
    Write-Host "use example:" -ForegroundColor Cyan
    Write-Host "  *new folder foo"
    Write-Host "  *new file bar.py"
    Write-Host ""
    Write-Host "use -h flag with any commands to see more details"

    return;
}

$command = $args[0]

if($command -eq "folder"){
    $foldername = $args[1]
    $folderExists = Test-Path $foldername
    if($h -or -not $foldername){
        Write-Host ""
        Write-Host "Useage:" -ForegroundColor Cyan
        Write-Host "  new <folder-name> [options]"
        Write-Host "Options:" -ForegroundColor Cyan
        Write-Host "  -cd`t`tcreate and cd into the folder"
        Write-Host "  -code`t`topen the folder in vscode"
        Write-Host "  -git`t`tinitialize git Repository in the folder"
        Write-Host "  -overwrite`toverwrite the existing folder"
        Write-Host "  -h`t`tshow help message"
        Write-Host "Examples:" -ForegroundColor Cyan
        Write-Host "  *new folder foo"
        Write-Host "  *new folder foo -cd"
        return;
    }
    if($folderExists -and -not $overwrite){
        Write-Host "there is already a folder with this name" -ForegroundColor Green
        Write-Host "use -overwrite flag to force make new one" -ForegroundColor Green
        return
    }
    $overwrtten = $false
    if($overwrite -and $folderExists){
        Remove-Item $foldername -Recurse
        $overwrtten = $true
    }
    try {
        New-Item -ItemType Directory -Name $foldername -ErrorAction Stop | Out-Null
        if($LASTEXITCODE -eq 0){
            if($overwrtten){
                Write-Host $foldername "Overwritten" -ForegroundColor Yellow
            }else{
                Write-Host $foldername "has been created" -ForegroundColor Green
            }
        }
    }
    catch {
        Write-Host ""
        Write-Host "Error: $_" -ForegroundColor Red
        return;
    }
    if($cd){
        Set-Location $foldername
    }
    if($git){
        git init $foldername
    }
    if($code){
        try {
            code $foldername
            if($LASTEXITCODE -ne 0){
                throw "something went wrong :( `nError code: $LASTEXITCODE"
            }
        }
        catch {
            Write-Host ""
            Write-Host $_ -ForegroundColor Red
            Write-Host "maybe vscode not installed on your machine" -ForegroundColor Red
        }
    }

}
if($command -eq "file"){
    $filename = $args[1]
    $fileExists = Test-Path $filename
    if($h -or -not $filename){
        Write-Host "Usage:" -ForegroundColor Cyan
        Write-Host "  new <file-name> [options]"
        Write-Host "Options:" -ForegroundColor Cyan
        Write-Host "  -code`t`topen the file in vscode"
        Write-Host "  -overwrite`toverwrite the existing file"
        Write-Host "  -h`t`tshow help message"
        Write-Host "Examples:" -ForegroundColor Cyan
        Write-Host "  *new file bar.txt"
        Write-Host "  *new file bar.txt -code"
        return;
    }
    if($fileExists -and -not $overwrite){
        Write-Host "the file is already exists" -ForegroundColor Green
        Write-Host "use -overwrite flag to force make new one" -ForegroundColor Green
        return;
    }
    $overwrtten = $false
    if($overwrite -and $fileExists){
        Remove-Item $filename
        $overwrtten = $true
    }
    try {
        New-Item -ItemType File -Name $filename -ErrorAction Stop | Out-Null
        if($LASTEXITCODE -eq 0){
            if($overwrtten){
                Write-Host "$filename has been overwritten" -ForegroundColor Yellow
            }else{
                Write-Host "$filename has been created" -ForegroundColor Green
            }
        }
    }
    catch {
        Write-Host ""
        Write-Host "Error: $_" -ForegroundColor Red
    }
    if($code){
        try {
            code $filename -ErrorAction stop
        }
        catch {
            Write-Host ""
            Write-Host "something went wrong :(" -ForegroundColor Red
            Write-Host "maybe vscode not installed on your machine" -ForegroundColor Red
        }
    }
}
