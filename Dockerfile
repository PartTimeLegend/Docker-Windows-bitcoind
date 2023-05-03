FROM mcr.microsoft.com/windows/servercore:2009
LABEL maintainer="hi@antonybailey.net"
RUN powershell.exe -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "[System.Net.ServicePointManager]::SecurityProtocol = 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
RUN choco.exe install bitcoin --fail-on-unfound --yes --no-progress --limit-output --timeout 2700 --force
RUN choco list --local-only
RUN ["powershell", "New-Item", "-Path \"C:\"", "-ItemType \"directory\"", "-Name \"temp\""]
WORKDIR C:/temp
COPY bitcoinconf.ps1 C:/temp/
RUN powershell.exe -ExecutionPolicy Bypass c:\temp\bitcoinconf.ps1
EXPOSE 8332 8333
