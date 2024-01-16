FROM debian:bookworm-slim

RUN apt-get update && \
    apt-get install -y curl git lsb-release python3 sudo && \
    apt-get clean

WORKDIR /workspace/

RUN git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git depot_tools

ENV PATH /workspace/depot_tools:$PATH

RUN fetch --nohooks chromium

RUN /workspace/depot_tools/src/build/install-build-deps.sh

WORKDIR /workspace/src/

RUN gclient runhooks

RUN gn gen out/Default

RUN autoninja -C out/Default chrome
