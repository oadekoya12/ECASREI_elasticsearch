FROM elasticsearch:7.12.1

ADD ./config/elasticsearch.yml /usr/share/elasticsearch/config/elasticsearch.yml
ADD ./config/role_mapping.yml /usr/share/elasticsearch/config/role_mapping.yml
ADD ./config/roles.yml /usr/share/elasticsearch/config/roles.yml
ADD ./config/users /usr/share/elasticsearch/config/users
ADD ./config/users_roles /usr/share/elasticsearch/config/users_roles

RUN yum update -y && yum install -y dos2unix
RUN mkdir -p ~/tmp && curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C ~/tmp &&\
 mv ~/tmp/eksctl /usr/local/bin && rm -rvf ~/tmp
WORKDIR /

EXPOSE 9200 9300

COPY ./system/local/script.sh /script.sh
RUN dos2unix /script.sh
ENTRYPOINT  ["sh","/script.sh"]