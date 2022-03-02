FROM node:8

COPY app /home/node/
WORKDIR /home/node/
RUN echo "mongodb://mongo:27017/posts" > mongoip
RUN apt-get update 
RUN npm install


EXPOSE 3000

CMD ["sh", "-c", "node seeds/seed.js; npm start"] 