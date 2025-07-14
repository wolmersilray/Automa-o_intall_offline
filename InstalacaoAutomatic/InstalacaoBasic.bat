@echo off
echo =====================================
echo Iniciando instalação dos programas...
echo =====================================

:: Atualizar o repositório winget
winget source update

:: Google Chrome
::winget install --id=Google.Chrome -e --silent

:: 7-Zip
winget install --id=7zip.7zip -e --silent

:: VLC Media Player
::winget install --id=VideoLAN.VLC -e --silent

:: Microsoft Teams
::winget install --id=Microsoft.Teams -e --silent

:: Adobe Acrobat Reader
winget install --id=Adobe.Acrobat.Reader.64-bit -e --silent

:: OBS: Adicione seus sistemas internos/manualmente se necessário

echo =====================================
echo Instalação finalizada.
echo =====================================
pause
