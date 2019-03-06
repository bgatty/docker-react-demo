#Choose the base image and builder is the build phase
FROM node:alpine as builder

#Create a folder called app inside the container
WORKDIR '/app'

#Copy the package.json file as this file has dependencies needed for the project. The dot indicates the file will copied inside the app destination folder
COPY package.json .

#Install all the dependencies defined in package.json file
RUN npm install

#Now copy the rest of the project files from local system folder inside the container
COPY . .

#Finally run the npm run build command to generate production binaries
RUN npm run build


#This is defining the run phase
FROM nginx

#Copy files from the builder phase to this new nginx container and specifically to /usr/share/nginx folder
# As part of the image, the nginx will start automatically. So, no need to run the command 'RUN nginx' specifically
COPY --from=builder /app/build /usr/share/nginx/html