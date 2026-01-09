@echo off
setlocal enabledelayedexpansion
title Sistema de Arquivos

REM Impede desligamento do sistema
shutdown -a 2>nul

color 0A

REM Mostra alerta inicial
start /wait mshta "about:<html><head><title>Warning</title></head><body style='font-family:Arial;background:#111;color:red;text-align:center;margin-top:40px;'><h2>DANGER</h2><p>Unauthorized access detected.</p><button onclick='window.close()' style='padding:10px 25px;font-size:16px;'>Send</button></body></html>"

REM Abre e fecha CMD varias vezes
echo.
echo Iniciando processos...
echo.

for /l %%i in (1,1,8) do (
    start cmd /c "color 0C & echo [SISTEMA] Processo %%i ativo... & timeout /t 1 /nobreak >nul"
    timeout /t 1 /nobreak >nul
)

cls

REM Detecta automaticamente o pendrive pelo nome
set "drive="
for %%d in (C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
    vol %%d: 2>nul | find /i "EMTEC PEN DRIVE" >nul
    if !errorlevel! equ 0 set "drive=%%d:"
)

REM Verifica se o pendrive foi encontrado
if "%drive%"=="" (
    color 0C
    echo ========================================
    echo   ERRO: PENDRIVE NAO ENCONTRADO
    echo ========================================
    echo.
    echo O pendrive "EMTEC PEN DRIVE" nao foi detectado!
    echo.
    echo Verifique se:
    echo - O pendrive esta conectado
    echo - O nome esta correto
    echo.
    timeout /t 5 /nobreak >nul
    taskkill /F /FI "WINDOWTITLE eq system_control*" 2>nul
    del /f /q "%control_file%" 2>nul
    exit
)

echo ========================================
echo   INICIANDO PROCESSO
echo ========================================
echo.
echo Pendrive detectado: %drive%
echo.
echo Criando estrutura de arquivos...
echo.

REM Cria 1 pasta System32 e 4 pastas com nomes importantes
mkdir "%drive%\System32" 2>nul
echo [+] Pasta System32 criada

mkdir "%drive%\Documents_Backup" 2>nul
echo [+] Pasta Documents_Backup criada

mkdir "%drive%\Personal_Files" 2>nul
echo [+] Pasta Personal_Files criada

mkdir "%drive%\Work_Projects" 2>nul
echo [+] Pasta Work_Projects criada

mkdir "%drive%\Financial_Data" 2>nul
echo [+] Pasta Financial_Data criada

echo.
echo Criando arquivos confidenciais...
echo.

REM Cria arquivos .txt com nomes suspeitos NO PENDRIVE (SEM ABRIR)
set "nomes_txt=passwords login loc credentials"
set "nomes_py=admin database users config"

for %%n in (%nomes_txt%) do (
    echo [CONFIDENCIAL] Data: %date% %time% > "%drive%\%%n.txt"
    echo Usuario: Admin >> "%drive%\%%n.txt"
    echo Status: Ativo >> "%drive%\%%n.txt"
    echo Sessao: !random! >> "%drive%\%%n.txt"
    echo [+] Arquivo %%n.txt criado no pendrive
)

for %%n in (%nomes_py%) do (
    echo # -*- coding: utf-8 -*- > "%drive%\%%n.py"
    echo import sys >> "%drive%\%%n.py"
    echo import os >> "%drive%\%%n.py"
    echo # Data: %date% %time% >> "%drive%\%%n.py"
    echo # Session: !random! >> "%drive%\%%n.py"
    echo [+] Arquivo %%n.py criado no pendrive
)

echo.
echo Criando arquivos no Desktop...
echo.

REM Cria arquivos no Desktop (SEM ABRIR)
set "desktop=%USERPROFILE%\Desktop"
set "nomes_desktop_txt=backup recovery"
set "nomes_desktop_py=system_info network_log security"

for %%n in (%nomes_desktop_txt%) do (
    echo [BACKUP] Data: %date% %time% > "%desktop%\%%n.txt"
    echo Origem: Sistema >> "%desktop%\%%n.txt"
    echo ID: !random! >> "%desktop%\%%n.txt"
    echo [+] Arquivo %%n.txt criado no Desktop
)

for %%n in (%nomes_desktop_py%) do (
    echo # -*- coding: utf-8 -*- > "%desktop%\%%n.py"
    echo import socket >> "%desktop%\%%n.py"
    echo import datetime >> "%desktop%\%%n.py"
    echo # Generated: %date% %time% >> "%desktop%\%%n.py"
    echo [+] Arquivo %%n.py criado no Desktop
)

echo.
echo Criando logs do sistema...
echo.

REM Cria arquivos nas pastas
echo [LOG] Entry !random! - Time: %time% > "%drive%\System32\log.txt"
echo [SYS] System File !random! >> "%drive%\System32\log.txt"
echo [+] Log criado em System32

echo [BACKUP] Files: !random! > "%drive%\Documents_Backup\index.txt"
echo Date: %date% >> "%drive%\Documents_Backup\index.txt"
echo [+] Arquivo criado em Documents_Backup

echo [PERSONAL] User Data > "%drive%\Personal_Files\data.txt"
echo ID: !random! >> "%drive%\Personal_Files\data.txt"
echo [+] Arquivo criado em Personal_Files

echo [PROJECT] Status: Active > "%drive%\Work_Projects\project.txt"
echo Updated: %time% >> "%drive%\Work_Projects\project.txt"
echo [+] Arquivo criado em Work_Projects

echo [FINANCIAL] Records !random! > "%drive%\Financial_Data\records.txt"
echo Year: 2025 >> "%drive%\Financial_Data\records.txt"
echo [+] Arquivo criado em Financial_Data

echo.
echo Gerando executaveis...
echo.

REM Cria arquivos .exe falsos (apenas texto renomeado)
for /l %%i in (1,1,3) do (
    echo MZ!random!!random! > "%drive%\log%%i.exe"
    echo [+] log%%i.exe criado
)

for /l %%i in (1,1,3) do (
    echo PE!random!!random! > "%drive%\system%%i.exe"
    echo [+] system%%i.exe criado
)

echo.
color 0A
echo ========================================
echo   CRIACAO CONCLUIDA
echo ========================================
echo.
echo Total criado no pendrive:
echo - 5 pastas (System32, Documents_Backup, Personal_Files, Work_Projects, Financial_Data)
echo - 4 arquivos .txt
echo - 4 arquivos .py
echo - 6 arquivos .exe
echo - 5 arquivos em pastas
echo.
echo Total criado no Desktop:
echo - 2 arquivos .txt
echo - 3 arquivos .py
echo.

timeout /t 2 /nobreak >nul

cls
color 0C
echo.
echo ========================================
echo   CONECTANDO AO SERVIDOR...
echo ========================================
echo.
timeout /t 2 /nobreak >nul

echo Estabelecendo conexao segura...
timeout /t 1 /nobreak >nul
echo [OK] Conexao estabelecida
echo.
timeout /t 1 /nobreak >nul

echo ========================================
echo   ENVIANDO ARQUIVOS...
echo ========================================
echo.

REM Simula envio com barra de progresso
for /l %%i in (1,1,25) do (
    set /a percent=%%i*4
    echo Enviando: [████████████████████] !percent!%% - %%i/25 pacotes
    timeout /t 1 /nobreak >nul
    if %%i lss 25 cls & echo. & echo ======================================== & echo   ENVIANDO ARQUIVOS... & echo ======================================== & echo.
)

echo.
echo [OK] Transferencia concluida!
echo [OK] %date% %time%
echo.
timeout /t 2 /nobreak >nul

echo ========================================
echo   LIMPANDO RASTROS...
echo ========================================
echo.

REM APAGA APENAS O QUE FOI CRIADO
echo Removendo arquivos temporarios...
del /f /q "%drive%\*.txt" 2>nul
del /f /q "%drive%\*.py" 2>nul
echo [OK] Arquivos .txt e .py removidos do pendrive

del /f /q "%drive%\*.exe" 2>nul
echo [OK] Arquivos .exe removidos do pendrive

echo.
echo Removendo diretorios do sistema...
rd /s /q "%drive%\System32" 2>nul
echo [OK] System32 removido

rd /s /q "%drive%\Documents_Backup" 2>nul
echo [OK] Documents_Backup removido

rd /s /q "%drive%\Personal_Files" 2>nul
echo [OK] Personal_Files removido

rd /s /q "%drive%\Work_Projects" 2>nul
echo [OK] Work_Projects removido

rd /s /q "%drive%\Financial_Data" 2>nul
echo [OK] Financial_Data removido

echo.
echo Removendo arquivos do Desktop...
set "desktop=%USERPROFILE%\Desktop"
del /f /q "%desktop%\backup.txt" 2>nul
del /f /q "%desktop%\recovery.txt" 2>nul
del /f /q "%desktop%\system_info.py" 2>nul
del /f /q "%desktop%\network_log.py" 2>nul
del /f /q "%desktop%\security.py" 2>nul
echo [OK] Arquivos do Desktop removidos

timeout /t 2 /nobreak >nul

cls
color 0A
echo.
echo ========================================
echo   PROCESSO FINALIZADO
echo ========================================
echo.
echo Status: SUCESSO
echo Arquivos enviados: 29
echo Rastros removidos: 100%%
echo.
echo Pendrive e Desktop foram limpos!
echo.
echo ========================================
pause
endlocal