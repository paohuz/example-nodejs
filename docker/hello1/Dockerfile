FROM node:12

# Create app directory
WORKDIR /usr/src/app

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
# COPY ../../app/hello-1.js ./server.js

# RUN npm install
# If you are building your code for production
# RUN npm ci --only=production

RUN npm install express

RUN npm install redis

# Bundle app source
#COPY . .
COPY ./hello-1.js ./server.js

EXPOSE 8000
CMD [ "node", "server.js" ]