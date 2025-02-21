# Verificar si se ejecuta como administrador
do {
    $adminCheck = [System.Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object System.Security.Principal.WindowsPrincipal($adminCheck)
    $adminRole = [System.Security.Principal.WindowsBuiltInRole]::Administrator

    if (-not $principal.IsInRole($adminRole)) {
        Write-Host "Reiniciando el script con permisos de Administrador..." -ForegroundColor Yellow
        Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
        Exit
    }
} while (-not $principal.IsInRole($adminRole))

Write-Host "El script se está ejecutando con permisos de Administrador." -ForegroundColor Green

# Obtener la lista de paquetes instalados sin crear un archivo
$installedPackages = Get-AppPackage

# Buscar WebMediaExtensions en la lista de paquetes
$packageName = $installedPackages | Where-Object { $_.Name -eq "WebMediaExtensions" } | Select-Object -ExpandProperty PackageFullName

if ($packageName) {
    Write-Host "Se encontró el paquete: $packageName" -ForegroundColor Green
    Write-Host "Eliminando paquete..."
    Remove-AppxPackage -Package $packageName
    Write-Host "Paquete eliminado exitosamente." -ForegroundColor Green
} else {
    Write-Host "No se encontró WebMediaExtensions instalado." -ForegroundColor Yellow
}

# Abrir el enlace de la Microsoft Store para reinstalar
Start-Process "https://apps.microsoft.com/detail/9N5TDP8VCMHS?hl=es-mx&gl=US&ocid=pdpshare"
Write-Host "Se abrió la página de la Microsoft Store. Proceda con la instalación manual." -ForegroundColor Cyan
