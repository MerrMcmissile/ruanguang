param(
    [ValidateRange(1, 65535)]
    [int]$Port = 8000
)

$pythonLauncher = Get-Command py -ErrorAction SilentlyContinue
if ($null -eq $pythonLauncher) {
    throw "Python Launcher (py) tidak ditemukan. Instal Python 3, lalu jalankan skrip ini kembali."
}

$addresses = Get-NetIPAddress -AddressFamily IPv4 -ErrorAction Stop |
    Where-Object {
        $_.IPAddress -ne "127.0.0.1" -and
        $_.IPAddress -notlike "169.254.*" -and
        $_.AddressState -eq "Preferred"
    } |
    Select-Object -ExpandProperty IPAddress -Unique

Write-Host ""
Write-Host "RuangUang berjalan di komputer ini:"
Write-Host "  http://localhost:$Port/"
if ($addresses.Count -gt 0) {
    Write-Host ""
    Write-Host "Alamat untuk perangkat lain di Wi-Fi/LAN yang sama:"
    foreach ($address in $addresses) {
        Write-Host "  http://${address}:$Port/"
    }
} else {
    Write-Warning "Tidak ditemukan alamat IPv4 jaringan lokal. Periksa koneksi Wi-Fi/LAN."
}
Write-Host ""
Write-Host "Hentikan server dengan menekan Ctrl+C."

& $pythonLauncher.Source -3 -m http.server $Port --bind 0.0.0.0 --directory $PSScriptRoot
if ($LASTEXITCODE -ne 0) {
    throw "Server web berhenti dengan kode keluar $LASTEXITCODE."
}
