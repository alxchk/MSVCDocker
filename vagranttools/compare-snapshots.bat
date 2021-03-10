@echo on

set SNAPSHOT1=%1
set SNAPSHOT2=%2
set OUTPUT=%3

@echo "comparing %SNAPSHOT1% to %SNAPSHOT2% : %OUTPUT%"

mkdir %OUTPUT%

regdiff %SNAPSHOT1%\HKLM.reg %SNAPSHOT2%\HKLM.reg /DIFF %OUTPUT%\HKLM.reg
regdiff %SNAPSHOT1%\HKCU.reg %SNAPSHOT2%\HKCU.reg /DIFF %OUTPUT%\HKCU.reg
regdiff %SNAPSHOT1%\HKCR.reg %SNAPSHOT2%\HKCR.reg /DIFF %OUTPUT%\HKCR.reg
regdiff %SNAPSHOT1%\HKU.reg %SNAPSHOT2%\HKU.reg /DIFF %OUTPUT%\HKU.reg
regdiff %SNAPSHOT1%\HKCC.reg %SNAPSHOT2%\HKCC.reg /DIFF %OUTPUT%\HKCC.reg

diff --unchanged-group-format=  %SNAPSHOT1%\files-sorted.txt %SNAPSHOT2%\files-sorted.txt > %OUTPUT%\files.txt

rem Remove something we can't use

zip %OUTPUT%\files.zip ^
    -x "*.mzz" -x "*.pdb" -x "*.png" -x "*.jpg" -x "*.htm" -x "*.wer" ^
    -x "ProgramData/Package Cache/*" ^
    -x "Program Files (x86)/Microsoft Visual Studio/2017/BuildTools/Common7/IDE/CommonExtensions/Microsoft/TestWindow/*" ^
    -x "Program Files (x86)/Microsoft Visual Studio/2017/BuildTools/Common7/IDE/Extensions/TestPlatform/*" ^
    -x "Program Files (x86)/Microsoft Visual Studio/2017/BuildTools/MSBuild/*" ^
    -x "Program Files (x86)/Microsoft Visual Studio/2017/BuildTools/Team Tools/*" ^
    -x "Program Files (x86)/Microsoft Visual Studio/Installer/*" ^
    -x "Program Files (x86)/Windows Kits/10/App Certification Kit/*" ^
    -x "Program Files (x86)/Windows Kits/10/References/*" ^
    -x "Program Files (x86)/Windows Kits/10/Source/*" ^
    -x "Program Files (x86)/Windows Kits/10/Remote/*" ^
    -x "Program Files (x86)/Windows Kits/10/Redist/*" ^
    -x "Windows/Prefetch/*" ^
    -x "ProgramData/Microsoft/Windows/Start Menu/*" ^
    -x "ProgramData/chocolatey/*" ^
    -@ < %OUTPUT%\files.txt
