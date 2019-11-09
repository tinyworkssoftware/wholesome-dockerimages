FROM google/cloud-sdk:270.0.0-alpine
RUN apk add --update nodejs npm
RUN apk add --update wget
RUN npm i newman -g
