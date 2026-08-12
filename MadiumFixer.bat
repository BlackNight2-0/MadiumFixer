@echo off
setlocal enabledelayedexpansion
title MadiumFixer
color 04

:: ============================================
:: 1. Verifica permissoes de Administrador
:: ============================================
net session >nul 2>&1
if %errorLevel% NEQ 0 (
    echo.
    echo [!] Este script precisa ser executado como Administrador.
    echo [!] Solicitando elevacao de privilegios...
    echo.
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

:MENU
cls
echo ===============================================
echo  SELECIONE QUAL ROBLOX/BOOTSTRAPER VC ULTILIZA
echo ===============================================
echo.
echo  [1] Roblox
echo  [2] Bloxstrap
echo  [3] Fishstrap
echo  [4] Froststrap
echo  [5] Sair
echo.
set /p OPCAO="Escolha uma das 5 opcoes acima:"

if "%OPCAO%"=="1" goto CONFIRMAR_ROBLOX
if "%OPCAO%"=="2" goto CONFIRMAR_BLOXSTRAP
if "%OPCAO%"=="3" goto CONFIRMAR_FISHSTRAP
if "%OPCAO%"=="4" goto CONFIRMAR_FROSTSTRAP
if "%OPCAO%"=="5" exit
echo.
echo Opcao invalida! Tente novamente.
timeout /t 2 >nul
goto MENU

:: ============================================
:: CONFIRMACOES DE AVISO
:: ============================================
:CONFIRMAR_ROBLOX
cls
echo ====================================================================================
echo  Fique ciente que o seu Roblox/Bootstraper sera reinstalado para consertar o Madium
echo ====================================================================================
echo.
echo  [1] Desejo prosseguir
echo  [2] Sair
echo.
set /p CONF="Escolha uma opcao:"
if "%CONF%"=="1" goto ROBLOX
if "%CONF%"=="2" goto MENU
echo Opcao invalida!
timeout /t 2 >nul
goto CONFIRMAR_ROBLOX

:CONFIRMAR_BLOXSTRAP
cls
echo ====================================================================================
echo  Fique ciente que o seu Roblox/Bootstraper sera reinstalado para consertar o Madium
echo ====================================================================================
echo.
echo  [1] Desejo prosseguir
echo  [2] Sair
echo.
set /p CONF="Escolha uma opcao:"
if "%CONF%"=="1" goto BLOXSTRAP
if "%CONF%"=="2" goto MENU
echo Opcao invalida!
timeout /t 2 >nul
goto CONFIRMAR_BLOXSTRAP

:CONFIRMAR_FISHSTRAP
cls
echo ====================================================================================
echo  Fique ciente que o seu Roblox/Bootstraper sera reinstalado para consertar o Madium
echo ====================================================================================
echo.
echo  [1] Desejo prosseguir
echo  [2] Sair
echo.
set /p CONF="Escolha uma opcao:"
if "%CONF%"=="1" goto FISHSTRAP
if "%CONF%"=="2" goto MENU
echo Opcao invalida!
timeout /t 2 >nul
goto CONFIRMAR_FISHSTRAP

:CONFIRMAR_FROSTSTRAP
cls
echo ====================================================================================
echo  Fique ciente que o seu Roblox/Bootstraper sera reinstalado para consertar o Madium
echo ====================================================================================
echo.
echo  [1] Desejo prosseguir
echo  [2] Sair
echo.
set /p CONF="Escolha uma opcao:"
if "%CONF%"=="1" goto FROSTSTRAP
if "%CONF%"=="2" goto MENU
echo Opcao invalida!
timeout /t 2 >nul
goto CONFIRMAR_FROSTSTRAP

:: ============================================
:: OPCAO 1: ROBLOX
:: ============================================
:ROBLOX
cls
echo ==========================================
echo        REINSTALANDO ROBLOX...
echo ==========================================
echo.

echo [i] Desinstalando Roblox...

taskkill /f /im RobloxPlayerBeta.exe >nul 2>&1
powershell -Command "Stop-Process -Name 'RobloxPlayerBeta' -Force -ErrorAction SilentlyContinue" >nul 2>&1
taskkill /f /im "Roblox Account Manager.exe" >nul 2>&1
powershell -Command "Stop-Process -Name 'Roblox Account Manager' -Force -ErrorAction SilentlyContinue" >nul 2>&1
taskkill /f /im Madium.exe >nul 2>&1
powershell -Command "Stop-Process -Name 'Madium' -Force -ErrorAction SilentlyContinue" >nul 2>&1
taskkill /f /im RobloxStudioBeta.exe >nul 2>&1

set "PASTA_VAZIA=%TEMP%\_pasta_vazia_temp"
if not exist "%PASTA_VAZIA%" mkdir "%PASTA_VAZIA%" >nul 2>&1

for %%D in (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
    if exist "%%D:\" (
        for /d %%P in ("%%D:\Arquivos de Programas*" "%%D:\Program Files*") do (
            if exist "%%P\Roblox" (
                takeown /f "%%P\Roblox" /r /d y >nul 2>&1
                icacls "%%P\Roblox" /grant *S-1-1-0:F /t /c /q >nul 2>&1
                robocopy "%PASTA_VAZIA%" "%%P\Roblox" /MIR /NFL /NDL /NJH /NJS /NC /NS /NP >nul 2>&1
                rmdir /s /q "%%P\Roblox" >nul 2>&1
                if exist "%%P\Roblox" (
                    powershell -Command "Remove-Item -Path '%%P\Roblox' -Recurse -Force -ErrorAction SilentlyContinue" >nul 2>&1
                )
            )
        )
    )
)

if exist "%LOCALAPPDATA%\Roblox" (
    takeown /f "%LOCALAPPDATA%\Roblox" /r /d y >nul 2>&1
    icacls "%LOCALAPPDATA%\Roblox" /grant *S-1-1-0:F /t /c /q >nul 2>&1
    robocopy "%PASTA_VAZIA%" "%LOCALAPPDATA%\Roblox" /MIR /NFL /NDL /NJH /NJS /NC /NS /NP >nul 2>&1
    rmdir /s /q "%LOCALAPPDATA%\Roblox" >nul 2>&1
    if exist "%LOCALAPPDATA%\Roblox" (
        powershell -Command "Remove-Item -Path '$env:LOCALAPPDATA\Roblox' -Recurse -Force -ErrorAction SilentlyContinue" >nul 2>&1
    )
)

rmdir /s /q "%PASTA_VAZIA%" >nul 2>&1

for %%A in ("Roblox Player.lnk" "Roblox Studio.lnk") do (
    if exist "%USERPROFILE%\Desktop\%%~A" del /f /q /a "%USERPROFILE%\Desktop\%%~A" >nul 2>&1
    if exist "%PUBLIC%\Desktop\%%~A" del /f /q /a "%PUBLIC%\Desktop\%%~A" >nul 2>&1
    if exist "%USERPROFILE%\OneDrive\Desktop\%%~A" del /f /q /a "%USERPROFILE%\OneDrive\Desktop\%%~A" >nul 2>&1
)

echo [OK] Roblox desinstalado com sucesso
echo.

echo [i] Instalando Roblox...
set "URL_ROBLOX=https://www.roblox.com/download/client?os=win&renderingPlatform=nextjs"
set "INSTALADOR_TEMP=%TEMP%\RobloxPlayerInstaller.exe"

powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; (New-Object System.Net.WebClient).DownloadFile('%URL_ROBLOX%', '%INSTALADOR_TEMP%')" >nul 2>&1

if exist "%INSTALADOR_TEMP%" (
    start "" "%INSTALADOR_TEMP%"
    echo [OK] Roblox instalado com sucesso
) else (
    echo [Erro] Executavel do Roblox nao foi encontrado.
)

echo.
echo ==========================================
echo          PROCESSO CONCLUIDO!
echo ==========================================
echo.
pause
goto MENU

:: ============================================
:: OPCAO 2: BLOXSTRAP
:: ============================================
:BLOXSTRAP
cls
echo ==========================================
echo        REINSTALANDO BLOXSTRAP...
echo ==========================================
echo.

echo [i] Desinstalando Bloxstrap...

taskkill /f /im RobloxPlayerBeta.exe >nul 2>&1
powershell -Command "Stop-Process -Name 'RobloxPlayerBeta' -Force -ErrorAction SilentlyContinue" >nul 2>&1
taskkill /f /im "Roblox Account Manager.exe" >nul 2>&1
powershell -Command "Stop-Process -Name 'Roblox Account Manager' -Force -ErrorAction SilentlyContinue" >nul 2>&1
taskkill /f /im Madium.exe >nul 2>&1
powershell -Command "Stop-Process -Name 'Madium' -Force -ErrorAction SilentlyContinue" >nul 2>&1
taskkill /f /im Bloxstrap.exe >nul 2>&1
powershell -Command "Stop-Process -Name 'Bloxstrap' -Force -ErrorAction SilentlyContinue" >nul 2>&1
taskkill /f /im RobloxStudioBeta.exe >nul 2>&1

if exist "%LOCALAPPDATA%\Bloxstrap\Versions" (
    set "PASTA_VAZIA=%TEMP%\_pasta_vazia_temp"
    if not exist "!PASTA_VAZIA!" mkdir "!PASTA_VAZIA!" >nul 2>&1
    
    takeown /f "%LOCALAPPDATA%\Bloxstrap\Versions" /r /d y >nul 2>&1
    icacls "%LOCALAPPDATA%\Bloxstrap\Versions" /grant *S-1-1-0:F /t /c /q >nul 2>&1
    attrib -r -h -s "%LOCALAPPDATA%\Bloxstrap\Versions\*.*" /s /d >nul 2>&1
    
    robocopy "!PASTA_VAZIA!" "%LOCALAPPDATA%\Bloxstrap\Versions" /MIR /NFL /NDL /NJH /NJS /NC /NS /NP >nul 2>&1
    rmdir /s /q "!PASTA_VAZIA!" >nul 2>&1
)

echo [OK] Bloxstrap desinstalado com sucesso
echo.

echo [i] Instalando Bloxstrap...

if exist "%LOCALAPPDATA%\Bloxstrap\Bloxstrap.exe" (
    start "" "%LOCALAPPDATA%\Bloxstrap\Bloxstrap.exe"
    echo [OK] Bloxstrap instalado com sucesso
) else (
    echo [Erro] Executavel do Bloxstrap nao foi encontrado.
)

echo.
echo ==========================================
echo                  CONCLUIDO!
echo ==========================================
echo.
pause
goto MENU

:: ============================================
:: OPCAO 3: FISHSTRAP
:: ============================================
:FISHSTRAP
cls
echo ==========================================
echo        REINSTALANDO FISHSTRAP...
echo ==========================================
echo.

echo [i] Desinstalando Fishstrap...

taskkill /f /im RobloxPlayerBeta.exe >nul 2>&1
powershell -Command "Stop-Process -Name 'RobloxPlayerBeta' -Force -ErrorAction SilentlyContinue" >nul 2>&1
taskkill /f /im "Roblox Account Manager.exe" >nul 2>&1
powershell -Command "Stop-Process -Name 'Roblox Account Manager' -Force -ErrorAction SilentlyContinue" >nul 2>&1
taskkill /f /im Madium.exe >nul 2>&1
powershell -Command "Stop-Process -Name 'Madium' -Force -ErrorAction SilentlyContinue" >nul 2>&1
taskkill /f /im Fishstrap.exe >nul 2>&1
powershell -Command "Stop-Process -Name 'Fishstrap' -Force -ErrorAction SilentlyContinue" >nul 2>&1
taskkill /f /im RobloxStudioBeta.exe >nul 2>&1

if exist "%LOCALAPPDATA%\Fishstrap\Versions" (
    set "PASTA_VAZIA=%TEMP%\_pasta_vazia_temp"
    if not exist "!PASTA_VAZIA!" mkdir "!PASTA_VAZIA!" >nul 2>&1
    
    takeown /f "%LOCALAPPDATA%\Fishstrap\Versions" /r /d y >nul 2>&1
    icacls "%LOCALAPPDATA%\Fishstrap\Versions" /grant *S-1-1-0:F /t /c /q >nul 2>&1
    attrib -r -h -s "%LOCALAPPDATA%\Fishstrap\Versions\*.*" /s /d >nul 2>&1
    
    robocopy "!PASTA_VAZIA!" "%LOCALAPPDATA%\Fishstrap\Versions" /MIR /NFL /NDL /NJH /NJS /NC /NS /NP >nul 2>&1
    rmdir /s /q "!PASTA_VAZIA!" >nul 2>&1
)

echo [OK] Fishstrap desinstalado com sucesso
echo.

echo [i] Instalando Fishstrap...

if exist "%LOCALAPPDATA%\Fishstrap\Fishstrap.exe" (
    start "" "%LOCALAPPDATA%\Fishstrap\Fishstrap.exe"
    echo [OK] Fishstrap instalado com sucesso
) else (
    echo [Erro] Executavel do Fishstrap nao foi encontrado.
)

echo.
echo ==========================================
echo                  CONCLUIDO!
echo ==========================================
echo.
pause
goto MENU

:: ============================================
:: OPCAO 4: FROSTSTRAP
:: ============================================
:FROSTSTRAP
cls
echo ==========================================
echo        REINSTALANDO FROSTSTRAP...
echo ==========================================
echo.

echo [i] Desinstalando Froststrap...

taskkill /f /im RobloxPlayerBeta.exe >nul 2>&1
powershell -Command "Stop-Process -Name 'RobloxPlayerBeta' -Force -ErrorAction SilentlyContinue" >nul 2>&1
taskkill /f /im "Roblox Account Manager.exe" >nul 2>&1
powershell -Command "Stop-Process -Name 'Roblox Account Manager' -Force -ErrorAction SilentlyContinue" >nul 2>&1
taskkill /f /im Madium.exe >nul 2>&1
powershell -Command "Stop-Process -Name 'Madium' -Force -ErrorAction SilentlyContinue" >nul 2>&1
taskkill /f /im Froststrap-1.5.0.exe >nul 2>&1
powershell -Command "Stop-Process -Name 'Froststrap-1.5.0' -Force -ErrorAction SilentlyContinue" >nul 2>&1
taskkill /f /im RobloxStudioBeta.exe >nul 2>&1

if exist "%LOCALAPPDATA%\Froststrap\Versions" (
    set "PASTA_VAZIA=%TEMP%\_pasta_vazia_temp"
    if not exist "!PASTA_VAZIA!" mkdir "!PASTA_VAZIA!" >nul 2>&1
    
    takeown /f "%LOCALAPPDATA%\Froststrap\Versions" /r /d y >nul 2>&1
    icacls "%LOCALAPPDATA%\Froststrap\Versions" /grant *S-1-1-0:F /t /c /q >nul 2>&1
    attrib -r -h -s "%LOCALAPPDATA%\Froststrap\Versions\*.*" /s /d >nul 2>&1
    
    robocopy "!PASTA_VAZIA!" "%LOCALAPPDATA%\Froststrap\Versions" /MIR /NFL /NDL /NJH /NJS /NC /NS /NP >nul 2>&1
    rmdir /s /q "!PASTA_VAZIA!" >nul 2>&1
)

echo [OK] Froststrap desinstalado com sucesso
echo.

echo [i] Instalando Froststrap...

if exist "%LOCALAPPDATA%\Froststrap\Froststrap.exe" (
    start "" "%LOCALAPPDATA%\Froststrap\Froststrap.exe"
    echo [OK] Froststrap instalado com sucesso
) else (
    echo [Erro] Executavel do Froststrap nao foi encontrado.
)

echo.
echo ==========================================
echo                  CONCLUIDO!
echo ==========================================
echo.
pause
goto MENU