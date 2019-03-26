FROM contino/aws-cli

COPY lib/ams /opt/app/lib/
WORKDIR /opt/app/lib/ 
RUN ./AWSManagedServices_InstallCLI.sh
WORKDIR /opt/app

RUN pip3 install boto3

RUN apk add tzdata \
&& cp -r -f /usr/share/zoneinfo/Australia/NSW /etc/localtime

RUN apk add ansible



