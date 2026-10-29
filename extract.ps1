Add-Type -AssemblyName System.Drawing

$img1 = (Get-ChildItem "images" | Where-Object { $_.Name -like "*163542*" } | Select-Object -First 1).FullName
$img2 = (Get-ChildItem "images" | Where-Object { $_.Name -like "*163811*" } | Select-Object -First 1).FullName
$img3 = (Get-ChildItem "images" | Where-Object { $_.Name -like "*163909*" } | Select-Object -First 1).FullName

if (-not (Test-Path "assets")) {
    New-Item -ItemType Directory -Path "assets" | Out-Null
}

function Crop($srcPath, $outName, $x, $y, $w, $h) {
    $bmp = [System.Drawing.Bitmap]::FromFile($srcPath)
    if ($x + $w -gt $bmp.Width) { $w = $bmp.Width - $x }
    if ($y + $h -gt $bmp.Height) { $h = $bmp.Height - $y }
    $rect = New-Object System.Drawing.Rectangle($x, $y, $w, $h)
    $cropped = $bmp.Clone($rect, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
    $cropped.Save("assets\$outName", [System.Drawing.Imaging.ImageFormat]::Png)
    $cropped.Dispose()
    $bmp.Dispose()
    Write-Host "Saved assets\$outName ($w x $h)"
}

# 1. Uzum Logo (exact)
Crop $img1 "uzum_logo.png" 134 58 275 50

# 2. Flag
Crop $img1 "flag_uz.png" 1550 7 24 24

# 3. Nav icons
Crop $img1 "nav_arzon.png" 135 134 30 30
Crop $img1 "nav_kuzgi.png" 373 134 29 30
Crop $img1 "nav_gozal.png" 571 134 24 30
Crop $img1 "nav_apple.png" 808 134 16 30

# 4. Banner (exact: 135 to 1685 = 1550px, Y: 188 to 703 = 515px)
Crop $img1 "banner.png" 135 188 1550 515

# 5. Category thumbnails (circular / rounded icons inside the 4 cards)
Crop $img1 "cat_elektronika.png" 149 732 60 60
Crop $img1 "cat_harkuni.png" 540 732 60 60
Crop $img1 "cat_moda.png" 931 732 60 60
Crop $img1 "cat_bolalar.png" 1322 732 60 60

# 6. Row 1 products (from img2)
Crop $img2 "prod_1.png" 89 90 290 387
Crop $img2 "prod_2.png" 404 90 290 387
Crop $img2 "prod_3.png" 719 90 290 387
Crop $img2 "prod_4.png" 1034 90 290 387
Crop $img2 "prod_5.png" 1349 90 290 387

# 7. Row 2 products (from img3)
Crop $img3 "prod_6.png" 44 50 290 387
Crop $img3 "prod_7.png" 359 50 290 387
Crop $img3 "prod_8.png" 674 50 290 387
Crop $img3 "prod_9.png" 989 50 290 387
Crop $img3 "prod_10.png" 1304 50 290 387
