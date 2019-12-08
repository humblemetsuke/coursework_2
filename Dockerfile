# use a node base image
FROM node:latest

# set maintainer
LABEL maintainer "coursework2ForTonyNarloch"

# set a health check. checking the server status 
HEALTHCHECK --interval=5s \
            --timeout=5s \
            CMD curl -f http://127.0.0.1:80 || exit 1

# tell docker what port to expose
EXPOSE 80 443
