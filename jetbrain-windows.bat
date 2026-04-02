@echo off

REM === Cấu trúc cũ (trước 2024) ===
for %%I in ("WebStorm", "IntelliJ", "CLion", "Rider", "GoLand", "PhpStorm", "Resharper", "PyCharm") do (
    for /d %%a in ("%USERPROFILE%\.%%I*") do (
        rd /s /q "%%a\config\eval"
        del /q "%%a\config\options\other.xml"
    )
)

REM === Cấu trúc mới (2024+) — %APPDATA%\JetBrains\<IDE><version>\ ===
for /d %%a in ("%APPDATA%\JetBrains\*") do (
    REM Xoá file trial key
    del /q "%%a\idea.key"
    del /q "%%a\early-access-registry"
    del /q "%%a\splash-subscription-mode"

    REM Xoá eval folder nếu tồn tại (phòng trường hợp)
    rd /s /q "%%a\eval"

    REM Xoá other.xml trong options
    del /q "%%a\options\other.xml"
)

REM === Xoá registry ===
reg delete "HKEY_CURRENT_USER\Software\JavaSoft" /f

echo Done! Plugins duoc giu lai.
pause
