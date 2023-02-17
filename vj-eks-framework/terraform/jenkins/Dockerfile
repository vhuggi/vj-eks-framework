# Use the official Python image as a parent image
FROM python:3.8

# Set the working directory to /app
WORKDIR /app

# Copy the requirements file into the container at /app
COPY requirements.txt /app

# Install the required packages
RUN pip install -r requirements.txt

# Copy the rest of the application code into the container at /app
COPY . /app

# Expose port 5000 for the application to listen on
EXPOSE 5000

# Run the command to start the application
CMD ["python", "app.py"]


## This Dockerfile starts with the official Python 3.8 image as the base image, sets the working directory to /app, copies the requirements.txt file into the container 
#and installs the required packages. It then copies the rest of the application code into the container and exposes port 5000. Finally, it runs the CMD to start the application.

#You can customize this Dockerfile as per your application's requirements.