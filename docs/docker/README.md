# Run `datavizclaus` in a docker container

---

## About the Docker Base Image

This repository’s Docker container is based on the [Rocker Project's versioned/binder image](https://rocker-project.org/images/versioned/binder.html).  

---

Follow these steps to set up and run the `datavizclaus` repository.

## 1. Clone the Repository

Open your terminal and run:

```bash
git clone https://github.com/Venustiano/datavizclaus.git
cd datavizclaus
```

## 2. Build the Docker Image

Make sure you have [Docker](https://docs.docker.com/get-docker/) installed.

To build the Docker image, run:

```bash
docker build -t datavizclaus .
```

## 3. Run the Docker Container

After the image is built, start the container:

```bash
docker run -p 8888:8888 datavizclaus
```

This will start the application and map port 8888 of your machine to the container.

## 4. Make Local Changes (Mount a Volume)

If you want your changes (such as editing code or saving output) to be saved outside the container, mount your local project directory as a volume:

```bash
docker run -p 8888:8888 -v $(pwd):/home/jovyan/local_datavisclaus datavizclaus
```
Now, any changes you make inside the container (in `/local_datavisclaus`) will appear in your local directory.

## 5. Access the Application

Open the url displayed in the terminal, something like:

```
...
http://127.0.0.1:8888/lab?token=4046c018cdcd0ceafb289cacf6016aa014dc211a968d78dc
...
```
---

## 6. Shut Down the Container

You can stop the running Docker container either via the command line (CLI) or using Docker Desktop (GUI):

### Using the Command Line (CLI)

1. List running containers and find the container ID or name:
    ```bash
    docker ps
    ```
2. Stop the container:
    ```bash
    docker stop <container_id_or_name>
    ```
   Replace `<container_id_or_name>` with the actual ID or name from the previous step.

### Using Docker Desktop (GUI)

1. Open **Docker Desktop**.
2. Go to the **Containers** or **Containers/Apps** section.
3. Find the `datavizclaus` container in the list.
4. Click **Stop** (usually a square or stop icon) next to the container.

---

> **Note:**  
> If your application uses a different port, working directory, or requires environment variables, check the documentation or Dockerfile for further customization.
