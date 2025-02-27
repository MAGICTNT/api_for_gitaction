FROM maven:3.8.1-openjdk-17 AS builder

WORKDIR /app

COPY pom.xml .

RUN mvn dependency:go-offline

COPY src ./src

RUN mvn clean package -DskipTests

FROM openjdk

COPY --from=builder /app/target/api_for_gitaction-0.0.1-SNAPSHOT.jar .

EXPOSE 8080

ENTRYPOINT ["java","-jar","api_for_gitaction-0.0.1-SNAPSHOT.jar"]

#FROM node
#
#WORKDIR /user/src/app
#
#COPY package*.json .
#
#RUN npm install
#
#COPY . .
#
#EXPOSE 3000
#
#ENTRYPOINT ["npm","start"]
#
