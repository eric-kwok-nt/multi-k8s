FROM node:alpine as builder
USER node
RUN mkdir -p /home/node/app
WORKDIR '/home/node/app'
COPY --chown=node:node ./package.json ./
RUN npm install 
COPY --chown=node:node ./ ./
RUN npm run build

# Any single block or phase can only have a single FROM statement
# Any subsequent FROM statement is kind of terminating each successive block
FROM nginx 
EXPOSE 3000
# Usually this command does nothing, except for letting the developers know that this ports needs to be mapped
# For elastic beanstalk, it will use this port for mapping of incoming traffic.
COPY ./nginx/default.conf /etc/nginx/conf.d/default.conf
COPY --from=builder /home/node/app/build /usr/share/nginx/html
# Default command for nginx image is to start the nginx for us. Hence, no start command is needed