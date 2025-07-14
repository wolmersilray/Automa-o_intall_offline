@echo off
:: ---------------- BLOCO DE ELEVAÇÃO ----------------
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Solicitando permissões de administrador...
    powershell -Command "Start-Process cmd -ArgumentList '/k \"\"%~f0\" -Elevado\"' -Verb RunAs"
    exit /b
)
if "%1"=="-Elevado" shift
:: -------------- FIM ELEVAÇÃO -----------------------

setlocal enabledelayedexpansion

:: Caminho base dos instaladores
set "INSTALL_DIR=\\DPROFLSV04\Aplicativos"

:: Log principal
set "LOGDIR=C:\InstaladoresOffline"
set "LOGFILE=%LOGDIR%\log_instalacao.txt"
if not exist "%LOGDIR%" mkdir "%LOGDIR%"
echo LOG DE INSTALACAO - %date% %time% > "%LOGFILE%"
echo ======================================= >> "%LOGFILE%"

echo ====================================
echo Iniciando instalacao OFFLINE
echo ====================================

:: ------- CHAMADAS DE INSTALAÇÃO (DESCOMENTE O QUE QUISER) ------
:: call :instalar "7‑Zip"           "%INSTALL_DIR%\7-Zip\7z1604-x64.exe"                               /S
:: call :instalar "UltraVNC"        "%INSTALL_DIR%\VNC 1.3.8.1\UltraVNC_1_3_81_X64_Setup.exe"         /verysilent /norestart
:: call :instalar "Microsoft Teams" "%INSTALL_DIR%\Microsoft Teams\Teams_windows_x64.exe"             /quiet /norestart
:: call :instalar "WinRAR"          "%INSTALL_DIR%\WinRAR\winrar-x64-611br.exe"                       /S
:: call :instalar "PDFsam Basic"    "%INSTALL_DIR%\PDFSAM\PDFsamBasic7Installer.exe"                  /S
:: call :instalar "Mesh Agent"      "%INSTALL_DIR%\MeshAgent\meshagent64-ComAgente.exe"               /S
:: call :instalar "GLPI Agent"      msiexec /i "%INSTALL_DIR%\GLPI-Agent-1.4-x64.msi"                 /quiet /norestart
:: call :instalar "Adobe Reader"    "%INSTALL_DIR%\readerdc_br_xa_crd_install.exe"                    /sAll /norestart
:: call :instalar "SafeNet Client"  msiexec /i "%INSTALL_DIR%\SERPRO-CERTSIGN\token-SERPRO-driver\SafeNetAuthenticationClient-10.0_Windows_10(64bits).msi" /quiet /norestart
:: call :instalar "Mozilla Firefox" "%INSTALL_DIR%\Navegadores\Firefox Setup 48.0x86.exe"             -ms
:: call :instalar "Google Chrome"   "%INSTALL_DIR%\Navegadores\ChromeSetup.exe"                       /silent /install
:: ----------------------------------------------------------------

echo ====================================
echo Instalacao concluida!
echo Veja o log em: %LOGFILE%
echo ====================================
pause
exit /b

:: ---------- FUNÇÃO :instalar ------------
:instalar
echo.
echo Instalando %~1 ...
start /wait "" "%~2" %~3 %~4 %~5
if !errorlevel! == 0 (
    echo [%date% %time%] %~1 instalado com sucesso. >> "%LOGFILE%"
) else (
    echo [%date% %time%] ERRO ao instalar %~1. Codigo: !errorlevel! >> "%LOGFILE%"
)
goto :eof
