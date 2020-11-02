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

# Bundle app source
#COPY . .
COPY ./hello-2.js ./server.js

EXPOSE 8000
CMD [ "node", "server.js" ]