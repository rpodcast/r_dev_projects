FROM rocker/rstudio

ARG USERNAME="eric"

# create .ssh directory in user area
#RUN mkdir -p /home/$USERNAME/.ssh \
#  && chmod -R 600 /home/$USERNAME/.ssh \
#  && chown -R $USERNAME:$USERNAME /home/$USERNAME/.ssh

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    libxml2-dev libssl-dev procps rrdtool libclang-dev libcurl4-openssl-dev libfreetype6-dev openssh-client \
  && wget --no-check-certificate \
    https://s3.amazonaws.com/rstudio-ide-build/server/bionic/amd64/rstudio-server-1.3.958-amd64.deb

RUN dpkg -i rstudio-server-1.3.958-amd64.deb \
  && rm rstudio-server-*-amd64.deb \
  && ln -s -f /usr/lib/rstudio-server/bin/pandoc/pandoc /usr/local/bin \
  && ln -s -f /usr/lib/rstudio-server/bin/pandoc/pandoc-citeproc /usr/local/bin \
  && apt-get clean