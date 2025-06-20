FROM ubuntu:24.04

#set up basics
RUN apt-get update && apt-get install -y \
    curl sudo git jq unzip \
    && apt-get clean

RUN useradd -m runner && echo "runner ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER runner
WORKDIR /home/runner

# Download GitHub Actions runner
RUN curl -O -L https://github.com/actions/runner/releases/latest/download/actions-runner-linux-x64-2.316.0.tar.gz \
  && tar xzf actions-runner-linux-x64-2.316.0.tar.gz \
  && rm actions-runner-linux-x64-2.316.0.tar.gz

COPY entrypoint.sh .

ENTRYPOINT ["./entrypoint.sh"]

