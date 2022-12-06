#Output from ChatGPT
#Prompt: 
#Please help me create a Docker file. 
#I would like it to accept SSH connections, and respond realistically, but log login information, commands ran, and files that were attempted to be downloaded

FROM ubuntu:20.04

# Install SSH server
RUN apt-get update && apt-get install -y openssh-server

# Set up SSH logging
RUN mkdir /var/log/ssh
RUN touch /var/log/ssh/ssh_login.log
RUN touch /var/log/ssh/ssh_commands.log
RUN touch /var/log/ssh/ssh_file_downloads.log

# Set up SSH server
RUN mkdir /var/run/sshd
RUN echo 'root:password' | chpasswd
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

# Set up logging script
COPY logging_script.sh /root/logging_script.sh
RUN chmod +x /root/logging_script.sh

# Run SSH server and logging script
CMD ["/usr/sbin/sshd", "-D"]
CMD ["/root/logging_script.sh"]
