FROM centos:5.11
MAINTAINER John Kirkham <jakirkham@gmail.com>


RUN yum update -y && \
    yum install -y \
                   curl \
                   openssl && \
    curl -O http://people.centos.org/tru/devtools-2/devtools-2.repo && \
    openssl md5 devtools-2.repo | grep 2d0168b187443f0528a24f95f457a27f && \
    mv devtools-2.repo /etc/yum.repos.d/devtools-2.repo && \
    yum update -y && \
    yum install -y \
                    devtoolset-2 && \
    yum clean all -y

ENTRYPOINT ["scl", "enable", "devtoolset-2", "bash"]
