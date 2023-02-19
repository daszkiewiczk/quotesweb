# pull the official base image
FROM node:12.18-alpine
#FROM node:alpine

# set working direction
WORKDIR /app

# add `/app/node_modules/.bin` to $PATH
ENV PATH /app/node_modules/.bin:$PATH

# install application dependencies
COPY package.json ./
#COPY package-lock.json ./


RUN npm config rm proxy 
RUN npm config rm https-proxy --tried removing npm proxy 
RUN rm -rf node_modules
RUN npm cache clean --f
RUN npm install --unsafe-perm=true --allow-root

# add app
COPY . ./

# RUN chown -R 1000:1000 ./
RUN chown -R 1000:0 /app && chmod -R ug+rwx /app
USER 1000
# start app
CMD ["npm", "start"]
