@echo off
::Verificar se estar sendo executado como administrador
rem --------------- BLOCO DE ELEVAÇÃO ---------------
:: 1) Verifica se já é administrador
net session >nul 2>&1
if %errorlevel%==0 goto :Elevado

:: 2) Se NÃO for admin, relança com UAC
echo Solicitando permissões de administrador...
powershell -Command "Start-Process '%~f0' -ArgumentList '-Elevado' -Verb RunAs -Wait"
exit /b

:Elevado
:: 3) Se chegou aqui, já está elevado (seja porque
::    passou pelo UAC ou porque o usuário já era admin).
::    Remova o argumento “-Elevado” da pilha (se existir)
if "%1"=="-Elevado" shift
rem --------------- FIM DO BLOCO DE ELEVAÇÃO ---------------

setlocal enabledelayedexpansion

:: Caminho onde os instaladores estão
set INSTALL_DIR=\\DPROFLSV04\Aplicativos

:: Caminho do arquivo de log
set LOGFILE=C:\InstaladoresOffline\log_instalacao.txt

:: Cria a pasta de log se não existir
if not exist "C:\InstaladoresOffline" (
    mkdir "C:\InstaladoresOffline"
)

:: Inicia o log
echo LOG DE INSTALAÇÃO - %date% %time% > "%LOGFILE%"
echo ======================================= >> "%LOGFILE%"

echo ====================================
echo Iniciando instalação OFFLINE
echo ====================================

:: --- Função de instalação com log ---
:: %1 = Nome para exibir
:: %2 = Caminho do instalador
:: %3 = Parâmetros adicionais

call :instalar "7-Zip" "%INSTALL_DIR%\7-Zip\7z1604-x64.exe" /S
call :instalar "UltraVNC" "%INSTALL_DIR%\VNC 1.3.8.1\UltraVNC_1_3_81_X64_Setup.exe" /verysilent /norestart
::call :instalar "Office 2016" "%INSTALL_DIR%\Office 2016 Standard\SW_DVD5_Office_2016_64Bit_Brazilian_MLF_X20-42468\setup.exe" /config "D:\InstalacaoAutomatic\Office\2016\Config.xml"
call :instalar "Office 2010" "%INSTALL_DIR%\OFFICE 2010 PROFESSIONAL\Office Professional 2010\x64\setup.exe" /Config  "D:\InstalacaoAutomatic\Office\2010\Config.xml"
call :instalar "Microsoft Teams" "%INSTALL_DIR%\Microsoft Teams\Teams_windows_x64.exe" /quiet /norestart
call :instalar "WinRAR" "%INSTALL_DIR%\WinRAR\winrar-x64-611br.exe" /quiet
call :instalar "PDFSAM" "%INSTALL_DIR%\PDFSAM\PDFsamBasic7Installer.exe" /S
call :instalar "MeshAgent" "%INSTALL_DIR%\MeshAgent\meshagent64-ComAgente.exe" /S
call :instalar "GLPI" "%INSTALL_DIR%\GLPI-Agent-1.4-x64.msi" /quiet /norestart
call :instalar "Adobe Reader" "%INSTALL_DIR%\readerdc_br_xa_crd_install.exe" /sAll /norestart
call :instalar "SafeNet" "%INSTALL_DIR%\SERPRO-CERTSIGN\token-SERPRO-driver\SafeNetAuthenticationClient-10.0_Windows_10(32-64bits)\SafeNetAuthenticationClient-10.0_Windows_10(64bits).msi" /quiet
call :instalar "Mozilla Firefox" "%INSTALL_DIR%\Navegadores\Firefox Setup 48.0x86.exe" -ms
call :instalar "Google Chrome" "%INSTALL_DIR%\Navegadores\ChromeSetup.exe" /silent /install

goto :fim

:: Função de instalação com log
:instalar
echo Instalando %~1...
start /wait "" "%~2" %~3 %~4 %~5
if !errorlevel! == 0 (
    echo [%date% %time%] %~1 instalado com sucesso. >> "%LOGFILE%"
) else (
    echo [%date% %time%] ERRO ao instalar %~1. Código: !errorlevel! >> "%LOGFILE%"
)
goto :eof

:fim
echo ====================================
echo Instalação concluída!
echo Veja o log em: %LOGFILE%
echo ====================================
pause
