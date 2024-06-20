# Create Jenkins network
sudo docker network create jenkins

# Build Jenkins image
sudo docker build -t myjenkins-blueocean:2.452.1 .

# Run Jenkins
sudo docker compose -f ./jenkins.compose.yml up -d