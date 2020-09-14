## Demo-API-Server

It is the experimental API server for my research demonstration.

### How to use

To clone this repository:
```
$ git clone https://github.com/wkwkgg/Demo-API-Server.git
```

To build image:
```
$ make init-docker
```

To show more details:
```
$ make
run-server                     Run API Server
run-test                       Run test script
run-lint                       Run linter (black)
help                           Display help message
init-docker                    Initialize docker image
profile-docker                 Show profile of this project
create-container               create docker container
clean-docker                   Remove docker environment
clean-container                Remove docker container
clean-image                    Remove docker image
```

