# Getting Started

To build the docker image, run the following command:

```bash
docker build -t my-postgres-image .
```

To run the docker container, run the following command:

```bash
docker run -d --name my-postgres-container -p 5432:5432 my-postgres-image
docker run --name my-postgres-container -d my-postgres-image
```

To run the linux shell in the container, run the following command:

```bash
docker exec -it my-postgres-container bash
```

To connect to the postgres database, run the following command:

```bash
sudo -u postgres psql
```

To stop the container, run the following command:

```bash
docker stop my-postgres-container
```
