FROM cern/cc7-base
USER root
RUN yum update -y
RUN yum install -y tar git gcc-c++ make bzip2 nettle gcc-gfortran patch cmake openssl openssl-devel openssl-libs m4 libcurl libcurl-openssl libcurl-devel libSM libX11 libXext libXft libXpm vim
RUN git clone https://github.com/JuliaLang/julia.git /opt/julia
ADD Make.user /opt/julia/Make.user
RUN cd /opt/julia && git checkout 93ee8dd2e2eccb79871133f980b9cebc9166b260 && make
RUN cd /opt/julia && make binary-dist
RUN /opt/julia/julia -E 'Pkg.clone("https://github.com/jpata/Cxx.jl.git");Pkg.checkout("Cxx", "rtti");Pkg.build("Cxx");Pkg.test("Cxx")'

RUN curl -s https://root.cern.ch/download/root_v6.06.06.Linux-centos7-x86_64-gcc4.8.tar.gz > /opt/root.tar.gz
RUN cd /opt && tar xf root.tar.gz
ADD roottest.jl /root/roottest.jl 
#RUN source /opt/root/bin/thisroot.sh && /opt/julia/julia /root/roottest.jl
#RUN echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh && \
#    curl -s -L https://repo.continuum.io/archive/Anaconda2-2.5.0-Linux-x86_64.sh > Anaconda2-2.5.0-Linux-x86_64.sh && \
#    /bin/bash /Anaconda2-2.5.0-Linux-x86_64.sh -b -p /opt/conda && \
#    rm /Anaconda2-2.5.0-Linux-x86_64.sh
#COPY env.sh /root/env.sh
#COPY build-root.sh /root/build-root.sh
#RUN /root/build-root.sh
#
#COPY build-ijulia.sh /root/build-ijulia.sh
#RUN /root/build-ijulia.sh
#COPY notebook.sh /root/notebook.sh
#
#EXPOSE 8888
#CMD /bin/bash
