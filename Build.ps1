# if(Test-Path .\artifacts) { Remove-Item .\artifacts -Force -Recurse }

exec { & dotnet restore }

Invoke-MSBuild

$revision = @{ $true = $env:APPVEYOR_BUILD_NUMBER; $false = 1 }[$env:APPVEYOR_BUILD_NUMBER -ne $NULL];
$revision = "{0:D4}" -f [convert]::ToInt32($revision, 10)

exec { & dotnet pack .\ErrorReporter.Core -c Release -o .\artifacts --version-suffix=$revision }

# exec { & dotnet test .\test\YOUR_TEST_PROJECT_NAME -c Release }