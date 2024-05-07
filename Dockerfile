FROM node:16-alpine
ARG DB_USER
ARG DB_PASSWORD
ARG DB_NAME
ARG HOST
ARG SECRET
ARG PORT

ENV NODE_ENV=production
ENV DB_USER=${DB_USER}
ENV DB_PASSWORD=${DB_PASSWORD}
ENV DB_NAME=${DB_NAME}
ENV HOST=${HOST}
ENV secret=${SECRET}
ENV PORT=${PORT}

WORKDIR /app

COPY ["package.json", "package-lock.json*", "./"]

# RUN RUN apt-get update && apt-get install python
RUN npm install

COPY . .

EXPOSE 8000

CMD ["npm", "start"]
