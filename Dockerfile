FROM alpine:3.11
LABEL maintainer="Werner Stein <werner.stein@gmail.com>"
RUN apk --update add --no-cache openssh \
  && sed -ir -e 's/#PermitRootLogin.*/PermitRootLogin\ yes/ /etc/ssh/sshd_config' \
  && echo "root:root" | chpasswd \
  && rm -rf /var/cache/apk/* \
  && sed -ir -e 's/#Port 22/Port 22/g' /etc/ssh/sshd_config \
  && sed -ir -e 's/#HostKey \/etc\/ssh\/ssh_host_key/HostKey \/etc\/ssh\/ssh_host_key/g' /etc/ssh/sshd_config \
  && sed -ir -e 's/#HostKey \/etc\/ssh\/ssh_host_rsa_key/HostKey \/etc\/ssh\/ssh_host_rsa_key/g' /etc/ssh/sshd_config \
  && sed -ir -e 's/#HostKey \/etc\/ssh\/ssh_host_dsa_key/HostKey \/etc\/ssh\/ssh_host_dsa_key/g' /etc/ssh/sshd_config \
  && sed -ir -e 's/#HostKey \/etc\/ssh\/ssh_host_ecdsa_key/HostKey \/etc\/ssh\/ssh_host_ecdsa_key/g' /etc/ssh/sshd_config \
  && sed -ir -e 's/#HostKey \/etc\/ssh\/ssh_host_ed25519_key/HostKey \/etc\/ssh\/ssh_host_ed25519_key/g' /etc/ssh/sshd_config \
  && /usr/bin/ssh-keygen -A \
  && ssh-keygen -t rsa -b 4096 -f  /etc/ssh/ssh_host_key
EXPOSE 22
CMD ["/usr/sbin/sshd","-D"]
