FROM contino/aws-cli


RUN pwd
RUN ls

COPY lib/ams /opt/app/lib/
WORKDIR /opt/app/lib/ 
RUN ./AWSManagedServices_InstallCLI.sh
WORKDIR /opt/app

RUN apk update && apk add tzdata \
&& cp -r -f /usr/share/zoneinfo/Australia/NSW /etc/localtime

RUN apk add ansible



