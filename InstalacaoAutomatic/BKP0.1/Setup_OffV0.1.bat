@echo off
setlocal enabledelayedexpansion

:: Caminho da pasta onde os instaladores estão
set INSTALL_DIR=CAMINHO DA PASTA

:: Caminho do arquivo de log
set LOGFILE=C:\StupOff\log_Stup.txt

:: Cria diretório de log, se não existir
if not exist "C:\StupOff" (
    mkdir "C:\StupOff"
)

:: Limpa ou cria novo log
echo LOG DE INSTALAÇÃO - %date% %time% > "%LOGFILE%"
echo ======================================= >> "%LOGFILE%"

echo ====================================
echo Iniciando instalação OFFLINE
echo ====================================

:: 7-Zip
echo Instalando 7-Zip...
start /wait "7-Zip" "%INSTALL_DIR%\7-Zip\7z1604-x64.exe" /S

:: VNC 1.3.8.1
echo Instalando UltraVNC...
start /wait "UltraVNC" "%INSTALL_DIR%\VNC 1.3.8.1\UltraVNC_1_3_81_X64_Setup.exe" /S
if %errorlevel%==0 (
	echo [%date% %time%] UltraVNC Instalado com sucesso. >> "%LOGFILE%"
) else(
	echo [%date% %time%] ERRO ao instalar UltraVNC. >> "%LOGFILE%"
)

:: Office 2016 Standard
::echo Instalando Office 2016...
::start /wait "Office 2016" "%INSTALL_DIR%\Office 2016 Standard\SW_DVD5_Office_2016_64Bit_Brazilian_MLF_X20-42468\setup.exe" /config "\\DPROFLSV04\Aplicativos\Office 2016 Standard\config.xml"

:: Microsoft Teams
echo Instalando Teams...
start /wait "Microsoft Teams" "%INSTALL_DIR%\Microsoft Teams\Teams_windows_x64.exe" /quiet
if %errorlevel%==0 (
	echo [%date% %time%] Microsoft Teams Instalado com sucesso. >> "%LOGFILE%"
) else(
	echo [%date% %time%] ERRO ao instalar Microsoft Teams. >> "%LOGFILE%"
)
:: WinRAR
echo Instalando WinRAR 3.8...
start /wait "WinRAR" "%INSTALL_DIR%\WinRAR\winrar-x64-611br.exe" /S
if %errorlevel%==0 (
	echo [%date% %time%] WinRAR Instalado com sucesso. >> "%LOGFILE%"
) else(
	echo [%date% %time%] ERRO ao instalar WinRAR. >> "%LOGFILE%"
)

:: PDFSAM
echo Instalando PDFSAM...
start /wait "PDFSAM" "%INSTALL_DIR%\PDFSAM\PDFsamBasic7Installer.exe" /silent
if %errorlevel%==0 (
	echo [%date% %time%] PDFSAM Instalado com sucesso. >> "%LOGFILE%"
) else(
	echo [%date% %time%] ERRO ao instalar PDFSAM. >> "%LOGFILE%"
)

:: MeshAgent
echo Instalando Mesh...
start /wait "MeshAgent" "%INSTALL_DIR%\MeshAgent\meshagent64-ComAgente.exe" /S
if %errorlevel%==0 (
	echo [%date% %time%] MeshAgent Instalado com sucesso. >> "%LOGFILE%"
) else(
	echo [%date% %time%] ERRO ao instalar MeshAgent. >> "%LOGFILE%"
)

::GLPI
echo Instalando GLPI...
start /wait "GLPI" "%INSTALL_DIR%\GLPI-Agent-1.4-x64.msi" /quiet
if %errorlevel%==0 (
	echo [%date% %time%] GLPI Instalado com sucesso. >> "%LOGFILE%"
) else(
	echo [%date% %time%] ERRO ao instalar GLPI. >> "%LOGFILE%"
)

:: Adobe Reader
echo Instalando Adobe Reader...
start /wait "AdobeReader" "%INSTALL_DIR%\readerdc_br_xa_crd_install.exe" /sAll
if %errorlevel%==0 (
	echo [%date% %time%] Adobe Reader Instalado com sucesso. >> "%LOGFILE%"
) else(
	echo [%date% %time%] ERRO ao instalar Adobe Reader. >> "%LOGFILE%"
)

::Safenet
echo Instalando Safenet
start /wait "Safenet" "%INSTALL_DIR%\SERPRO-CERTSIGN\token-SERPRO-driver\SafeNetAuthenticationClient-10.0_Windows_10(32-64bits)\SafeNetAuthenticationClient-10.0_Windows_10(64bits).msi" /quiet
if %errorlevel%==0 (
	echo [%date% %time%] Safenet Instalado com sucesso. >> "%LOGFILE%"
) else(
	echo [%date% %time%] ERRO ao instalar Safenet. >> "%LOGFILE%"
)

echo ====================================
echo Instalação concluída!
echo Veja o log em: %LOGFILE%
echo ====================================
pause
