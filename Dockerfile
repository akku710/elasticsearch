FROM ubuntu:20.04

# Install dependencies and Elasticsearch
RUN apt-get update && \
    apt-get install -y wget gnupg && \
    wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | apt-key add - && \
    apt-get install -y apt-transport-https && \
    echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | tee -a /etc/apt/sources.list.d/elastic-7.x.list && \
    apt-get update && \
    apt-get install -y elasticsearch

# Add configuration files
COPY elasticsearch.yml /usr/share/elasticsearch/config/
COPY logging.yml /usr/share/elasticsearch/config/

# Set environment variables and expose ports
ENV ES_HOME /usr/share/elasticsearch
ENV PATH $ES_HOME/bin:$PATH
RUN mkdir -p /usr/share/elasticsearch/data
VOLUME /usr/share/elasticsearch/data
EXPOSE 9200 9300

# Run Elasticsearch
CMD ["elasticsearch"]
