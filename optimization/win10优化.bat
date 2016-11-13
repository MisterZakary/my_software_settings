@Echo Off
Title win10优化
::by 卡饭 我呀擦擦

set TempFile_Name=%SystemRoot%\System32\BatTestUACin_SysRt%Random%.batemp
( echo "BAT Test UAC in Temp" >%TempFile_Name% ) 1>nul 2>nul
if exist %TempFile_Name% (
del %TempFile_Name% 1>nul 2>nul
GOTO menu
) else (
GOTO admin
)

:menu
ECHO =============================================================================
ECHO                                 Windows 10 优化                           
ECHO  #+++++++++++++++++++++++++++++++++++++++#+++++++++++++++++++++++++++++++++++#
ECHO  #                            0、备份/还原注册表                             #
ECHO  #                                                                           #
ECHO  # 1、去除快捷方式小箭头                 # 2、去除快捷方式字样               #
ECHO  # 3、开机磁盘扫描等待时间               # 4、任务栏显示星期几               #
ECHO  # 5、去除休眠文件                       # 6、退出程序时自动清理内存中的DLL  #
ECHO  # 7、关闭DEP                            # 8、关闭UAC                        #
ECHO  # 9、迁移用户文档桌面                   # 10、设置虚拟内存                  #
ECHO  # 11、右键菜单添加显示后缀隐藏文件      # 12、右键菜单添加管理员取得所有权  #
ECHO  # 13、右键菜单添加用记事本打开          # 14、清空图标缓存                  #
ECHO  # 15、清除右键显卡菜单项                # 16、清除右键新建项目              #
ECHO  # 17、清除右键菜单还原以前的版本        # 18、清除任务栏历史图标            #
ECHO  #+++++++++++++++++++++++++++++++++++++++#+++++++++++++++++++++++++++++++++++#
ECHO =============================================================================

set /p a=                  请输入操作序号并回车：
if %a%==0 goto 备份/还原注册表
if %a%==1 goto 去除快捷方式小箭头
if %a%==2 goto 去除快捷方式字样
if %a%==3 goto 开机磁盘扫描等待时间
if %a%==4 goto 任务栏显示星期几
if %a%==5 goto 去除休眠文件
if %a%==6 goto 退出程序时自动清理内存中的DLL
if %a%==7 goto 关闭DEP
if %a%==8 goto 关闭UAC
if %a%==9 goto 迁移用户文档桌面
if %a%==10 goto 设置虚拟内存
if %a%==11 goto 右键菜单添加显示后缀隐藏文件
if %a%==12 goto 右键菜单添加管理员取得所有权
if %a%==13 goto 右键菜单添加用记事本打开
if %a%==14 goto 清空图标缓存
if %a%==15 goto 清除右键显卡菜单项
if %a%==16 goto 清除右键新建项目
if %a%==17 goto 清除右键菜单还原以前的版本
if %a%==18 goto 清除任务栏历史图标

:admin
CLS
ECHO 操作失败。
echo 请右键“以管理员身份运行”
ECHO 按任意键退出...
PAUSE >nul
exit

:备份/还原注册表
ECHO.
ECHO.
ECHO    **********************************
ECHO.
ECHO             备份/还原注册表
ECHO    (能还原大部分修改，备份路径在C盘)
ECHO.
ECHO                1.备份
ECHO.
ECHO                2.还原
ECHO.
ECHO    **********************************
ECHO.
ECHO.
Choice /C 12 /N /M 选择（1、2）：
If ErrorLevel 1 If Not ErrorLevel 2 Goto 备份注册表
If ErrorLevel 2 If Not ErrorLevel 3 Goto 还原注册表
:备份注册表
regedit /E c:/注册表备份.reg
@echo.操作已完成,按任意键返回主菜单
pause>nul
cls
GOTO menu
:还原注册表
regedit /s c:/注册表备份.reg
@echo.操作已完成,按任意键返回主菜单
pause>nul
cls
GOTO menu

:去除快捷方式小箭头
reg delete "HKCR\lnkfile" /v IsShortcut /f 
taskkill /f /im explorer.exe 
start explorer 
@echo.操作已完成,按任意键返回主菜单
pause>nul
cls
GOTO menu

:去除快捷方式字样
REG add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" /v link /t REG_BINARY /d 00000000 /f
@echo.操作已完成,按任意键返回主菜单
pause>nul
cls
GOTO menu

:去除休眠文件
powercfg -h off
@echo.操作已完成,按任意键返回主菜单
pause>nul
cls
GOTO menu

:右键菜单添加显示后缀隐藏文件
ECHO.
ECHO.
ECHO    **********************************
ECHO.
ECHO       右键菜单添加显示后缀隐藏文件
ECHO.
ECHO                1.添加
ECHO.
ECHO                2.删除
ECHO.
ECHO    **********************************
ECHO.
ECHO.
Choice /C 12 /N /M 选择（1、2）：
If ErrorLevel 1 If Not ErrorLevel 2 Goto 右键菜单添加显示后缀隐藏文件
If ErrorLevel 2 If Not ErrorLevel 3 Goto 右键菜单删除显示后缀隐藏文件
:右键菜单删除显示后缀隐藏文件
reg delete "HKCR\CLSID\{00000000-0000-0000-0000-000000000012}" /f >nul 2>nul
del /f /q "%windir%\SuperHidden.vbs" >nul 2>nul
echo.&echo 已删除显示/隐藏扩展名及文件
pause>nul
cls
GOTO menu
:右键菜单添加显示后缀隐藏文件
>"%windir%\SuperHidden.vbs" echo Dim WSHShell
>>"%windir%\SuperHidden.vbs" echo Set WSHShell = WScript.CreateObject("WScript.Shell")
>>"%windir%\SuperHidden.vbs" echo WSHShell.RegWrite "HKCR\CLSID\{00000000-0000-0000-0000-000000000012}\Instance\InitPropertyBag\CLSID", "{13709620-C279-11CE-A49E-444553540000}", "REG_SZ"
>>"%windir%\SuperHidden.vbs" echo WSHShell.RegWrite "HKCR\CLSID\{00000000-0000-0000-0000-000000000012}\Instance\InitPropertyBag\method", "ShellExecute", "REG_SZ"
>>"%windir%\SuperHidden.vbs" echo if WSHShell.RegRead("HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\HideFileExt") = 0 then
>>"%windir%\SuperHidden.vbs" echo WSHShell.RegWrite "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\ShowSuperHidden", "0", "REG_DWORD"
>>"%windir%\SuperHidden.vbs" echo WSHShell.RegWrite "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\Hidden", "2", "REG_DWORD"
>>"%windir%\SuperHidden.vbs" echo WSHShell.RegWrite "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\HideFileExt", "1", "REG_DWORD"
>>"%windir%\SuperHidden.vbs" echo WSHShell.RegWrite "HKCR\CLSID\{00000000-0000-0000-0000-000000000012}\Instance\InitPropertyBag\command", "显示扩展名及文件", "REG_SZ"
>>"%windir%\SuperHidden.vbs" echo WSHShell.SendKeys "{F5}e"
>>"%windir%\SuperHidden.vbs" echo else
>>"%windir%\SuperHidden.vbs" echo WSHShell.RegWrite "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\ShowSuperHidden", "1", "REG_DWORD"
>>"%windir%\SuperHidden.vbs" echo WSHShell.RegWrite "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\Hidden", "1", "REG_DWORD"
>>"%windir%\SuperHidden.vbs" echo WSHShell.RegWrite "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\HideFileExt", "0", "REG_DWORD"
>>"%windir%\SuperHidden.vbs" echo WSHShell.RegWrite "HKCR\CLSID\{00000000-0000-0000-0000-000000000012}\Instance\InitPropertyBag\command", "隐藏扩展名及文件", "REG_SZ"
>>"%windir%\SuperHidden.vbs" echo WSHShell.SendKeys "{F5}e"
>>"%windir%\SuperHidden.vbs" echo end if
>>"%windir%\SuperHidden.vbs" echo Set WSHShell = Nothing
>>"%windir%\SuperHidden.vbs" echo WScript.Quit(0)
reg export "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "%temp%\__.reg" >nul
for /f "tokens=2 delims==" %%. in ('find/i "HideFileExt" "%temp%\__.reg"') do set v=%%~.
del "%temp%\__.reg"
set v=%v:~-1%
if %v% equ 0 set vv=隐藏扩展名及文件
if %v% equ 1 set vv=显示扩展名及文件
>"%temp%\_.reg" echo REGEDIT4
>>"%temp%\_.reg" echo [HKEY_CLASSES_ROOT\Directory\Background\shellex\ContextMenuHandlers\SuperHidden]
>>"%temp%\_.reg" echo @="{00000000-0000-0000-0000-000000000012}"
>>"%temp%\_.reg" echo [HKEY_CLASSES_ROOT\CLSID\{00000000-0000-0000-0000-000000000012}\InProcServer32]
>>"%temp%\_.reg" echo @=hex(2):25,53,79,73,74,65,6d,52,6f,6f,74,25,5c,73,79,73,74,65,6d,33,32,5c,73,\
>>"%temp%\_.reg" echo   68,64,6f,63,76,77,2e,64,6c,6c,00
>>"%temp%\_.reg" echo "ThreadingModel"="Apartment"
>>"%temp%\_.reg" echo [HKEY_CLASSES_ROOT\CLSID\{00000000-0000-0000-0000-000000000012}\Instance]
>>"%temp%\_.reg" echo "CLSID"="{3f454f0e-42ae-4d7c-8ea3-328250d6e272}"
>>"%temp%\_.reg" echo [HKEY_CLASSES_ROOT\CLSID\{00000000-0000-0000-0000-000000000012}\Instance\InitPropertyBag]
>>"%temp%\_.reg" echo "method"="ShellExecute"
>>"%temp%\_.reg" echo "Param1"="SuperHidden.vbs"
>>"%temp%\_.reg" echo "CLSID"="{13709620-C279-11CE-A49E-444553540000}"
>>"%temp%\_.reg" echo "command"="%vv%"
regedit /s "%temp%\_.reg"
del /f /q "%temp%\_.reg"
echo.&echo 已添加右键 %vv%
pause>nul
cls
GOTO menu

:退出程序时自动清理内存中的DLL
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v AlwaysUnloadDll /t REG_DWORD /d 00000001 /f
@echo.操作已完成,按任意键返回主菜单
pause>nul
cls
GOTO menu


:关闭UAC
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v EnableLUA /t REG_DWORD /d 00000000 /f
@echo.操作已完成,按任意键返回主菜单
pause>nul
cls
GOTO menu

:清除右键新建项目
reg delete "HKCR\.bmp\ShellNew" /f
reg delete "HKCR\.rar\ShellNew" /f
reg delete "HKCR\.zip\ShellNew" /f
reg delete "HKCR\Briefcase\ShellNew" /f
reg delete "HKCR\.xdp\AcroExch.XDPDoc\ShellNew" /f
reg delete "HKCR\.jnt\jntfile\ShellNew" /f
reg delete "HKCR\.contact\ShellNew" /f
reg delete "HKCR\.rtf\ShellNew" /f
reg delete "HKCR\.zip\CompressedFolder\ShellNew" /f
@echo.操作已完成,按任意键返回主菜单
pause>nul
cls
GOTO menu


:清除右键显卡菜单项
regsvr32 /u igfxpph.dll /s
regsvr32 /u atiacmxx.dll /s
regsvr32 /u nvcpl.dll /s
@echo.操作已完成,按任意键返回主菜单
pause>nul
cls
GOTO menu

:迁移用户文档桌面
set /p weizhi=请输入迁移目标分区盘符(如D:\administrator):
echo.
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" /v Personal /t REG_EXPAND_SZ /d "%weizhi%" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" /v Desktop /t REG_EXPAND_SZ /d "%weizhi%\Desktop" /f
@echo.操作已完成,按任意键返回主菜单
pause>nul
cls
GOTO menu

:设置虚拟内存
set /p disk=请输入虚拟内存转移到的目标分区盘符(如d)：
echo.
echo 自动管理虚拟内存初始大小和最大值请输入0
echo.
echo 按任意键指定虚拟内存大小
pause>nul
set /p min=请输入虚拟内存初始大小(M,如1024)：
set /p max=请输入虚拟内存最大值(M,如4096)：
reg add "HKLM\SYSTEM\ControlSet001\Control\Session Manager\Memory Management" /v "PagingFiles" /d "%disk%:\pagefile.sys %min% %max%" /t REG_MULTI_SZ /f
ECHO “重启电脑生效”，按任意键返回主菜单
pause>nul
cls
GOTO menu

:任务栏显示星期几
reg add "HKCU\Control Panel\International" /v "sLongDate" /d "yyyy'年'M'月'd'日', dddd" /t REG_SZ /f
reg add "HKCU\Control Panel\International" /v "sShortDate" /d "yyyy/M/d/ddd" /t REG_SZ /f
taskkill /f /im explorer.exe
start %systemroot%\explorer
@echo.操作已完成,按任意键返回主菜单
pause>nul
cls
GOTO menu

:右键菜单添加用记事本打开
ECHO.
ECHO.
ECHO    **********************************
ECHO.
ECHO         右键菜单添加用记事本打开
ECHO.
ECHO                1.添加
ECHO.
ECHO                2.删除
ECHO.
ECHO    **********************************
ECHO.
ECHO.
Choice /C 12 /N /M 选择（1、2）：
If ErrorLevel 1 If Not ErrorLevel 2 Goto 右键菜单添加用记事本打开
If ErrorLevel 2 If Not ErrorLevel 3 Goto 右键菜单删除用记事本打开
:右键菜单添加用记事本打开
reg add "HKCR\*\shell\Noteped" /ve /d 使用记事本打开 /f
reg add "HKCR\*\shell\Noteped\command" /ve /d "notepad.exe %1" /f
@echo.操作已完成,按任意键返回主菜单
pause>nul
cls
GOTO menu
:右键菜单删除用记事本打开
reg delete "HKCR\*\shell\Noteped" /f
@echo.操作已完成,按任意键返回主菜单
pause>nul
cls
GOTO menu

:右键菜单添加管理员取得所有权
ECHO.
ECHO.
ECHO    **********************************
ECHO.
ECHO       右键菜单添加管理员取得所有权
ECHO.
ECHO                1.添加
ECHO.
ECHO                2.删除
ECHO.
ECHO    **********************************
ECHO.
ECHO.
Choice /C 12 /N /M 选择（1、2）：
If ErrorLevel 1 If Not ErrorLevel 2 Goto 右键菜单添加管理员取得所有权
If ErrorLevel 2 If Not ErrorLevel 3 Goto 右键菜单删除管理员取得所有权
:右键菜单添加管理员取得所有权
>"%temp%\_.reg" echo Windows Registry Editor Version 5.00
>>"%temp%\_.reg" echo [HKEY_CLASSES_ROOT\*\shell\runas]
>>"%temp%\_.reg" echo @="管理员取得所有权"
>>"%temp%\_.reg" echo "NoWorkingDirectory"=""
>>"%temp%\_.reg" echo [HKEY_CLASSES_ROOT\*\shell\runas\command]
>>"%temp%\_.reg" echo @="cmd.exe /c takeown /f \"%%1\" && icacls \"%%1\" /grant administrators:F"
>>"%temp%\_.reg" echo "IsolatedCommand"="cmd.exe /c takeown /f \"%%1\" && icacls \"%%1\" /grant administrators:F"
>>"%temp%\_.reg" echo [HKEY_CLASSES_ROOT\exefile\shell\runas2]
>>"%temp%\_.reg" echo @="管理员取得所有权"
>>"%temp%\_.reg" echo "NoWorkingDirectory"=""
>>"%temp%\_.reg" echo [HKEY_CLASSES_ROOT\exefile\shell\runas2\command]
>>"%temp%\_.reg" echo @="cmd.exe /c takeown /f \"%%1\" && icacls \"%%1\" /grant administrators:F"
>>"%temp%\_.reg" echo "IsolatedCommand"="cmd.exe /c takeown /f \"%%1\" && icacls \"%%1\" /grant administrators:F"
>>"%temp%\_.reg" echo [HKEY_CLASSES_ROOT\Directory\shell\runas]
>>"%temp%\_.reg" echo @="管理员取得所有权"
>>"%temp%\_.reg" echo "NoWorkingDirectory"=""
>>"%temp%\_.reg" echo [HKEY_CLASSES_ROOT\Directory\shell\runas\command]
>>"%temp%\_.reg" echo @="cmd.exe /c takeown /f \"%%1\" /r /d y && icacls \"%%1\" /grant administrators:F /t"
>>"%temp%\_.reg" echo "IsolatedCommand"="cmd.exe /c takeown /f \"%%1\" /r /d y && icacls \"%%1\" /grant administrators:F /t"
regedit /s "%temp%\_.reg"
del /f /q "%temp%\_.reg"
@echo.操作已完成,按任意键返回主菜单
pause>nul
cls
GOTO menu
:右键菜单删除管理员取得所有权
reg delete "HKCR\*\shell\runas" /f
reg delete "HKCR\exefile\shell\runas2" /f
reg delete "HKCR\Directory\shell\runas" /f
@echo.操作已完成,按任意键返回主菜单
pause>nul
cls
GOTO menu

:开机磁盘扫描等待时间
set /p shijian=请设置开机磁盘扫描时间(建议设为2秒)：
chkntfs /t:%shijian%
@echo.操作已完成,按任意键返回主菜单
pause>nul
cls
GOTO menu

:关闭DEP
bcdedit /set nx alwaysoff
@echo.操作已完成,按任意键返回主菜单
pause>nul
cls
GOTO menu

:清除任务栏历史图标
taskkill /f /im explorer.exe
reg delete "HKCU\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\TrayNotify" /v IconStreams /f
reg delete "HKCU\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\TrayNotify" /v PastIconsStream /f
start explorer
@echo.操作已完成,按任意键返回主菜单
pause>nul
cls
GOTO menu

:清空图标缓存
taskkill /f /im explorer.exe
attrib -h -s -r "%userprofile%\AppData\Local\IconCache.db"
del /f "%userprofile%\AppData\Local\IconCache.db"
start explorer
@echo.操作已完成,按任意键返回主菜单
pause>nul
cls
GOTO menu

:清除右键菜单还原以前的版本
reg delete "HKEY_CLASSES_ROOT\AllFilesystemObjects\shellex\PropertySheetHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /f
reg delete "HKEY_CLASSES_ROOT\AllFilesystemObjects\shellex\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}" /f
@echo.操作已完成,按任意键返回主菜单
pause>nul
cls
GOTO menu
