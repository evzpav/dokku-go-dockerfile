# Dokku Go Dockerfile

Example of Deployment of Golang project via Dokku with Dockerfile. Much faster and controlled deployment

## Dokku will identify and create container for it. Note that env var PORT (server port) is set by Dokku automatically.

### Run locally:
```bash
    docker build -t dokku-go-dockerfile .
    docker run -e PORT=4000 -d --rm --name dokku-go-dockerfile -p 9090:4000 dokku-go-dockerfile
    
    #To Test:
    curl localhost:9090 
    #Welcome!
```
