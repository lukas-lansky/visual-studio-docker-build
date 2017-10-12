FROM microsoft/windowsservercore:10.0.14393.1715
SHELL ["powershell"]

RUN Invoke-WebRequest "https://aka.ms/vs/15/release/vs_community.exe" -OutFile "$env:TEMP\vs_community.exe" -UseBasicParsing
RUN & "$env:TEMP\vs_community.exe" --add Microsoft.VisualStudio.Workload.NetWeb --quiet --wait --norestart --noUpdateInstaller | Out-Default

# msbuild
RUN & 'C:/Program Files (x86)/Microsoft Visual Studio/2017/Community/MSBuild/15.0/Bin/MSBuild.exe' /version

# choco
RUN iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))

# 7zip
RUN choco install -y 7zip.install

# git
RUN choco install -y git
RUN git --version --build-options

# nuget
RUN choco install -y nuget.commandline
RUN nuget help

CMD ["powershell"]