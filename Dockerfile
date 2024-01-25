# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements. See the NOTICE file distributed with this
# work for additional information regarding copyright ownership. The ASF
# licenses this file to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# <p>
# http://www.apache.org/licenses/LICENSE-2.0
# <p>
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
# License for the specific language governing permissions and limitations under
# the License.

FROM openjdk:8-jdk

WORKDIR /usr/local

# Default argument values
ARG RELEASE_VER=1.3.0
ARG RELEASE_MIRROR=https://downloads.apache.org
ARG KNOX_USER=knox
ARG KNOX_INTERNAL_PORT=8443

# Add the knox user
RUN useradd -m $KNOX_USER
ENV KNOX_PATH /usr/local/knox-$RELEASE_VER
ENV BIN_PATH $KNOX_PATH/bin

# Download and unpack the Knox release
RUN wget $RELEASE_MIRROR/knox/$RELEASE_VER/knox-$RELEASE_VER.zip
RUN unzip knox-$RELEASE_VER.zip
RUN chown -R knox $KNOX_PATH

# Create a startup script for the container command
RUN chmod a+rwx $BIN_PATH
RUN chmod a+rwx /usr/local
ENV KNOX_PATH /usr/local/knox-$RELEASE_VER
ENV BIN_PATH $KNOX_PATH/bin
COPY start-knox.sh /usr/local
#RUN echo '#!/bin/bash\n#\n\nrunuser -l knox -c "/usr/local/knox-'$RELEASE_VER'/bin/knoxcli.sh create-master --master knox"\nrunuser -l knox -c "/usr/local/knox-'$RELEASE_VER'/bin/ldap.sh start"\nrunuser -l knox -c "/usr/local/knox-'$RELEASE_VER'/bin/gateway.sh start"\nrunuser -l knox -c "/usr/local/knox-'$RELEASE_VER'/bin/knoxcli.sh create-alias sandbox.discovery.pwd --value maria_dev"\ntail -f /usr/local/knox-'$RELEASE_VER'/logs/gateway.log' > /usr/local/start-knox.sh

RUN chmod +x /usr/local/start-knox.sh

EXPOSE $KNOX_INTERNAL_PORT

#USER $KNOX_USER
#WORKDIR $BIN_PATH
CMD ["/bin/bash", "start-knox.sh"]
