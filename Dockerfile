FROM contino/aws-cli


RUN pwd
RUN ls

COPY lib/ams /opt/app/lib/
WORKDIR /opt/app/lib/ 
RUN ./AWSManagedServices_InstallCLI.sh
WORKDIR /opt/app

RUN apk add ansible



