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

RUN R -e "install.packages(c('shiny', 'shinydashboard', 'tidyverse', 'learnr', 'rmarkdown', 'lubridate', 'stringr', 'forcats', 'wesanderson', 'ggrepel', 'viridis', 'leaflet', 'sf'), repos='http://cran.rstudio.com/')"


RUN mkdir -p /srv/shiny-server/chapter-1
COPY /chapter-1/index.Rmd /srv/shiny-server/chapter-1
COPY /chapter-1/index.html /srv/shiny-server/chapter-1
COPY /chapter-1/_navbar.html /srv/shiny-server/chapter-1



RUN mkdir -p /srv/shiny-server/chapter-2
COPY /chapter-2/index.Rmd /srv/shiny-server/chapter-2
COPY /chapter-2/index.html /srv/shiny-server/chapter-2
COPY /chapter-2/_navbar.html /srv/shiny-server/chapter-2


RUN mkdir -p /srv/shiny-server/chapter-3
COPY /chapter-3/index.Rmd /srv/shiny-server/chapter-3
COPY /chapter-3/index.html /srv/shiny-server/chapter-3
COPY /chapter-3/bw.rds /srv/shiny-server/chapter-3
COPY /chapter-3/_navbar.html /srv/shiny-server/chapter-3


RUN mkdir -p /srv/shiny-server/chapter-4
COPY /chapter-4/index.Rmd /srv/shiny-server/chapter-4
COPY /chapter-4/index.html /srv/shiny-server/chapter-4
COPY /chapter-4/_navbar.html /srv/shiny-server/chapter-4
COPY /chapter-4/movies.rds /srv/shiny-server/chapter-4


RUN mkdir -p /srv/shiny-server/chapter-5
COPY /chapter-5/index.Rmd /srv/shiny-server/chapter-5
COPY /chapter-5/index.html /srv/shiny-server/chapter-5
COPY /chapter-5/_navbar.html /srv/shiny-server/chapter-5
COPY /chapter-5/boston_black.rds /srv/shiny-server/chapter-5
COPY /chapter-5/homicide-data.csv /srv/shiny-server/chapter-5
COPY /chapter-5/race-and-or-ethnicity.csv /srv/shiny-server/chapter-5

RUN mkdir -p /srv/shiny-server/chapter-5/Boston_Neighborhoods
COPY /chapter-5/Boston_Neighborhoods/Boston_Neighborhoods.shp /srv/shiny-server/chapter-5/Boston_Neighborhoods
COPY /chapter-5/Boston_Neighborhoods/Boston_Neighborhoods.cpg /srv/shiny-server/chapter-5/Boston_Neighborhoods
COPY /chapter-5/Boston_Neighborhoods/Boston_Neighborhoods.prj /srv/shiny-server/chapter-5/Boston_Neighborhoods
COPY /chapter-5/Boston_Neighborhoods/Boston_Neighborhoods.shx /srv/shiny-server/chapter-5/Boston_Neighborhoods
COPY /chapter-5/Boston_Neighborhoods/Boston_Neighborhoods.dbf /srv/shiny-server/chapter-5/Boston_Neighborhoods

RUN mkdir -p /srv/shiny-server/chapter-6
COPY /chapter-6/index.Rmd /srv/shiny-server/chapter-6
COPY /chapter-6/index.html /srv/shiny-server/chapter-6
COPY /chapter-6/_navbar.html /srv/shiny-server/chapter-6


RUN mkdir -p /srv/shiny-server/chapter-7
COPY /chapter-7/index.Rmd /srv/shiny-server/chapter-7
COPY /chapter-7/index.html /srv/shiny-server/chapter-7
COPY /chapter-7/_navbar.html /srv/shiny-server/chapter-7


# COPY shiny-server.conf /etc/shiny-server/shiny-server.conf
#COPY first_toot /srv/shiny-server/



EXPOSE 3838

# COPY shiny-server.sh /usr/bin/shiny-server.sh
# CMD ["/usr/bin/shiny-server.sh"]

# docker-compose down && docker-compose rm && docker-compose up --force-recreate --build
