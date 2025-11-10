# Step 1: Use a base image
FROM python:3.9

# Step 2: Set working directory inside the container
WORKDIR /app

# Step 3: Copy your app files to the container
COPY . /app

# Step 4: Install dependencies
RUN pip install flask

# Step 5: Expose port 5000 to the outside world
EXPOSE 5000

# Step 6: Run the application
CMD ["python", "app.py"]
