FROM debian:buster

RUN apt update; apt -y install qemu-utils unzip sshpass curl vim locales

RUN curl -o /mnt/packer.zip https://releases.hashicorp.com/packer/1.6.6/packer_1.6.6_linux_amd64.zip; unzip /mnt/packer.zip -d /bin/

RUN localedef -f UTF-8 -i en_US en_US.UTF-8

COPY VMware-ovftool-4.4.1-16812187-lin.x86_64.bundle /mnt/

RUN bash /mnt/VMware-ovftool-4.4.1-16812187-lin.x86_64.bundle --eulas-agreed

WORKDIR /mnt


COPY build.sh /mnt/
COPY provision.sh /mnt/
COPY export.sh /mnt/
COPY template.json /mnt/
COPY vmx.template /mnt/
# COPY .user_variables /mnt/


CMD ["/mnt/build.sh"] 
