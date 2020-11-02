# example-nodejs
Just simple nodejs application

# tree

```bash
.
├── Jenkinsfile
├── README.md
├── docker
│   ├── hello1
│   │   ├── Dockerfile
│   │   └── hello-1.js
│   ├── hello2
│   │   ├── Dockerfile
│   │   └── hello-2.js
│   └── nginx
│       ├── Dockerfile
│       └── nginx.conf
├── docker-compose.yml
└── k8s_deployment.sh
```

# SCM 
git clone https://github.com/pornpasok/example-nodejs.git

# Build Docker Image and Deploy to development ENV
cd example-nodejs/

docker-compose up --build -d

# Check Docker Status
docker ps -a

# Scale App to 2 Containers
docker-compose scale hello1=2 hello2=2

# Check Hello1 App
curl http://localhost/hello1

# Check Hello2 App
curl http://localhost/hello2

# Clean App
docker-compose down -v

# Bonus :)
# Deploy to k8s Cluster
chmod +x k8s_deployment.sh
./k8s_deployment.sh

