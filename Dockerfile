FROM ubuntu:latest
RUN apt update && \
    apt install -y libffi6 libgmp10 cabal-install && \
    apt clean && \
    cabal update && \
    cabal install ShellCheck && \
    mv /root/.cabal/bin/shellcheck /bin && \
    rm -rf /root/.ghc /root/.cabal /var/lib/apt/lists/* && \
    apt remove --purge -y cabal-install && \
    apt autoremove -y
