# BUILD
FROM node:latest

# Create work directory for image, and change owner to "node" user
RUN mkdir -p /usr/app/src/node_modules && chown -R node:node /usr/app/src

WORKDIR /usr/app/src

# Copy package info
COPY --chown=node:node package*.json ./

# Change to "node" user and run npm install under this user
USER node

RUN npm install

COPY --chown=node:node . .

# Transpile Typescript
RUN npm run-script tsc

EXPOSE 8000

CMD ["npm", "start"]