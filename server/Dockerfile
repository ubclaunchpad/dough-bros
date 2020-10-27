# BUILD
FROM node:12

# Create app directory
WORKDIR /usr/app/src

# Install app dependencies
COPY package*.json ./

RUN npm install

# Bundle app source
COPY . .

RUN npm run build

# RUN
EXPOSE 8000

CMD [ "npm", "start" ]