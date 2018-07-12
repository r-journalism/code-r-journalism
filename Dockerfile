FROM rocker/shiny

RUN apt-get -y update \
    && apt-get install -y --no-install-recommends apt-utils \
    && apt-get -y install git \
    && sudo apt-get -y install libssl-dev libxml2-dev libudunits2-dev libgdal-dev libproj-dev libgeos-dev git default-jre default-jdk \
    && DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install default-jre-headless\
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install OpenJDK-8
RUN apt-get update && \
    apt-get install -y openjdk-8-jdk && \
    apt-get install -y ant && \
    apt-get clean;

# Fix certificate issues
RUN apt-get update && \
    apt-get install ca-certificates-java && \
    apt-get clean && \
    update-ca-certificates -f;

# Setup JAVA_HOME -- useful for docker commandline
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/
RUN export JAVA_HOME

# WORKDIR /srv/shiny-server    
# COPY depends.r /srv/shiny-server/
# RUN Rscript depends.r
# COPY start.sh /srv/shiny-server/

RUN R -e "install.packages(c('shiny', 'shinydashboard', 'tidyverse', 'learnr', 'rmarkdown'), repos='http://cran.rstudio.com/')"


RUN mkdir -p /srv/shiny-server/first_toot
COPY /first_toot/index.Rmd /srv/shiny-server/first_toot
COPY /first_toot/index.html /srv/shiny-server/first_toot


# COPY shiny-server.conf /etc/shiny-server/shiny-server.conf
#COPY first_toot /srv/shiny-server/



# EXPOSE 3838

# COPY shiny-server.sh /usr/bin/shiny-server.sh
# CMD ["/usr/bin/shiny-server.sh"]

# docker-compose down && docker-compose rm && docker-compose up --force-recreate --build
