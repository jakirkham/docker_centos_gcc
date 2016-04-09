FROM centos:5.11
MAINTAINER John Kirkham <jakirkham@gmail.com>


RUN echo "" > /etc/yum.repos.d/devtools32.repo && \
    echo "[devtools-32]" >> /etc/yum.repos.d/devtools32.repo && \
    echo "name=CentOS 5 devtools 32bit" >> /etc/yum.repos.d/devtools32.repo && \
    echo "baseurl=http://people.centos.org/tru/devtools-2/5/i386/RPMS" >> /etc/yum.repos.d/devtools32.repo && \
    echo "gpgcheck=0" >> /etc/yum.repos.d/devtools32.repo && \
    \
    echo "" > /etc/yum.repos.d/devtools64.repo && \
    echo "[devtools-64]" >> /etc/yum.repos.d/devtools64.repo && \
    echo "name=CentOS 5 devtools 64bit" >> /etc/yum.repos.d/devtools64.repo && \
    echo "baseurl=http://people.centos.org/tru/devtools-2/5/x86_64/RPMS" >> /etc/yum.repos.d/devtools64.repo && \
    echo "gpgcheck=0" >> /etc/yum.repos.d/devtools64.repo

RUN yum update -y && \
    yum install -y devtoolset-2-{gcc,gcc-c++,gcc-gfortran,binutils} \
                   glibc-devel.i386 \
                   glibc-devel.x86_64 \
                   glibc-headers.i386 \
                   glibc-headers.x86_64 \
                   libgfortran.i386 \
                   libgfortran.x86_64 \
                   libgfortran44.i386 \
                   libgfortran44.x86_64 \
                   devtoolset-2-libstdc++-devel.i386 \
                   devtoolset-2-libstdc++-devel.x86_64 \
                   libgomp.i386 \
                   libgomp.x86_64 \
                   devtoolset-2-libquadmath-devel.i386 \
                   devtoolset-2-libquadmath-devel.x86_64 && \
    yum update -y && \
    yum clean all -y

RUN yum update -y && \
    yum install -y curl \
                   file \
                   openssl && \
    export HELLO_TESTS_VERSION="0.0.1" && \
    curl -L "https://github.com/jakirkham/hello_tests/archive/v${HELLO_TESTS_VERSION}.tar.gz" > hello_tests.tar.gz && \
    openssl md5 hello_tests.tar.gz | grep c18d2a7b29dbc685ad6413feebc82c06 && \
    tar -zxf hello_tests.tar.gz && \
    rm hello_tests.tar.gz && \
    mv "hello_tests-${HELLO_TESTS_VERSION}" hello_tests && \
    cd hello_tests && \
    scl enable devtoolset-2 "bash hellos_run.sh" && \
    cd .. && \
    rm -rf hello_tests && \
    yum clean all -y

ENTRYPOINT ["scl", "enable", "devtoolset-2", "bash"]
