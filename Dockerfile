FROM cern/cc7-base:latest
RUN yum install -y tar
RUN yum install -y git
RUN yum install -y gcc-c++
RUN yum install -y make
RUN yum install -y bzip2
RUN yum install -y nettle
RUN mkdir -p /opt/julia && \
    curl -s -L https://julialang.s3.amazonaws.com/bin/linux/x64/0.4/julia-0.4.3-linux-x86_64.tar.gz | tar -C /opt/julia -x -z --strip-components=1 -f -
RUN mkdir -p /opt/root && \
    curl -s -L https://root.cern.ch/download/root_v6.06.02.Linux-centos7-x86_64-gcc4.8.tar.gz | tar -C /opt/root -x -z --strip-components=1 -f -
RUN echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh && \
    curl -s -L https://repo.continuum.io/archive/Anaconda2-2.5.0-Linux-x86_64.sh > Anaconda2-2.5.0-Linux-x86_64.sh && \
    /bin/bash /Anaconda2-2.5.0-Linux-x86_64.sh -b -p /opt/conda && \
    rm /Anaconda2-2.5.0-Linux-x86_64.sh
COPY env.sh /root/env.sh
COPY build-root.sh /root/build-root.sh
RUN /root/build-root.sh

COPY build-ijulia.sh /root/build-ijulia.sh
RUN /root/build-ijulia.sh
COPY notebook.sh /root/notebook.sh

EXPOSE 8888
CMD /bin/bash
