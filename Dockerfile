FROM node:12.6-stretch

ENV ANDROID_HOME /opt/android-sdk-linux

RUN apt-get update && apt-get install openjdk-8-jdk -y && \
    mkdir -p ${ANDROID_HOME} && \
    cd ${ANDROID_HOME} && \
    wget -q https://dl.google.com/android/repository/sdk-tools-linux-3859397.zip -O android_tools.zip && \
    unzip android_tools.zip && \
    rm android_tools.zip

ENV PATH ${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/tools/bin:${ANDROID_HOME}/platform-tools

RUN yes | sdkmanager --licenses && \
    sdkmanager \
        'build-tools;27.0.3' \
        'build-tools;28.0.3' \
        'emulator' \
        'extras;android;m2repository' \
        'extras;google;m2repository' \
        'extras;m2repository;com;android;support;constraint;constraint-layout-solver;1.0.2' \
        'extras;m2repository;com;android;support;constraint;constraint-layout;1.0.2' \
        'platform-tools' \
        'platforms;android-23' \
        'platforms;android-26' \
        'platforms;android-27' \
        'platforms;android-28' \
        'tools'

COPY ./files/build.sh /tmp/build.sh

USER node

CMD ["sh", "/tmp/build.sh"]
