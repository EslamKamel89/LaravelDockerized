FROM nginx:stable-alpine

ADD ./nginx/default.conf /etc/nginx/conf.d/default.conf

# the step below is not necessary because i am binding a volume in the docker-compose file
# but still nice to have
RUN mkdir -p /var/www/html