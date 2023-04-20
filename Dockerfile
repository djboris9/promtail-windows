FROM --platform=linux/amd64 curlimages/curl as bins

WORKDIR /promtail
RUN curl -Lo promtail.zip https://github.com/grafana/loki/releases/download/v2.8.0/promtail-windows-amd64.exe.zip
RUN unzip /promtail/promtail.zip

FROM mcr.microsoft.com/windows/servercore:ltsc2022

ENV PATH="C:\Program Files\PowerShell;C:\utils;C:\Windows\system32;C:\Windows;"

COPY --from=bins /promtail/promtail-windows-amd64.exe /

ENTRYPOINT ["PowerShell", "/c", "/promtail-windows-amd64.exe"]
