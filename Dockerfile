FROM nginx:1.17-alpine

RUN apk add --no-cache logrotate supervisor \
    && rm -rf /tmp/* /var/cache/apk/* \
    && touch /var/log/messages \
    && crontab -l | { cat; echo "0       0       *       *       *       /usr/sbin/logrotate -vf /opt/logrotate/nginx.conf"; } | crontab -
    
ADD supervisord.conf /etc/supervisord.conf
ADD logrotate-config/nginx.conf /opt/logrotate/nginx.conf

ENTRYPOINT ["supervisord"]
