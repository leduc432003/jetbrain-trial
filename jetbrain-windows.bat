REM Delete eval folder and license-related files only
for %%I in ("WebStorm", "IntelliJ", "CLion", "Rider", "GoLand", "PhpStorm", "Resharper", "PyCharm") do (
    for /d %%a in ("%USERPROFILE%\.%%I*") do (
        REM Xóa thư mục eval (chứa thông tin trial)
        rd /s /q "%%a\config\eval"

        REM Xóa chỉ các key liên quan đến trial trong other.xml thay vì xóa cả file
        REM (other.xml có thể chứa settings khác nên dùng PowerShell để xóa chọn lọc)
        powershell -Command "$f='%%a\config\options\other.xml'; if (Test-Path $f) { (Get-Content $f) -notmatch 'evlsprt|licenseKey|trialExpiration|evaluationKey' | Set-Content $f }"
    )
)

REM Xóa registry key liên quan đến license (JavaSoft)
reg delete "HKEY_CURRENT_USER\Software\JavaSoft" /f

REM Chỉ xóa file/folder liên quan đến license trong JetBrains, KHÔNG xóa toàn bộ
for %%I in ("WebStorm", "IntelliJ", "CLion", "Rider", "GoLand", "PhpStorm", "Resharper", "PyCharm") do (
    del /q "%APPDATA%\JetBrains\%%I*\eval\*" 2>nul
    for /d %%a in ("%APPDATA%\JetBrains\%%I*") do (
        rd /s /q "%%a\eval" 2>nul
        del /q "%%a\options\other.xml" 2>nul
    )
)
