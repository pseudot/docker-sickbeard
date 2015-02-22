# Based on centos:6.5. 
FROM centos:centos6

MAINTAINER Pseudot <pseudot@outlook.com>

# Install RPM keys
RUN rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-6

# Install Git for updates
RUN yum -y install git wget gcc python-devel openssl-devel tar libffi-devel 

# Download files or copy files
COPY scripts/  /tmp/scripts
RUN chmod +x /tmp/scripts/*.sh
RUN cd /tmp/scripts; /tmp/scripts/get_files.sh

#COPY python/ez_setup.py /tmp/python/ez_setup.py
#ADD python/cheetah.tar.gz /tmp/python/cheetah.tar.gz
#ADD python/pyOpenSSL.tar.gz /tmp/python/pyOpenSSL.tar.gz
#COPY sickbeard/ /opt/sickbeard

# Install Supervisor to control processes

# Install easy_setup, python is already installed
RUN python /tmp/python/ez_setup.py

# Easy install supervisor, for running multiple procersses
RUN easy_install pip==1.5.6
RUN pip install supervisor==3.0

# Copy supervisord configuration.
RUN mkdir -p /usr/local/etc
COPY supervisor/supervisord.conf /usr/local/etc/supervisord.conf
COPY supervisor/supervisord_sickbeard.conf /usr/local/etc/supervisor.d/supervisord_sickbeard.conf

# Install cheetah
RUN cd /tmp/cheetah.tar.gz/Cheetah-*/; python setup.py install

# Install sickbeard
# Copy default configuration settings
COPY sickbeard_config/config.ini /opt/sickbeard/config.ini

# Copy SSL (self-signed) - Generate inside the container?
COPY ssl/sickbeard.pem /opt/sickbeard/ssl/sickbeard.pem
COPY ssl/sickbeard.key /opt/sickbeard/ssl/sickbeard.key
RUN chmod 0700 /opt/sickbeard/ssl/sickbeard.key
RUN chmod 0700 /opt/sickbeard/ssl/sickbeard.pem

# Install pyOpenSSL - required for https
RUN cd /tmp/pyOpenSSL.tar.gz/pyOpenSSL-*/; python setup.py install

# Remove temp files
RUN rm -rf /tmp/*

# Expose volumes
VOLUME [ "/var/log" ]

EXPOSE 8081 9091

# Run the supervisor
WORKDIR /usr/bin
CMD ["/usr/bin/supervisord","--configuration=/usr/local/etc/supervisord.conf"]