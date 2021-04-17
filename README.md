# Deploying Spark on Kubernetes

## Want to use this project?

### Minikube Setup

Install and run [Minikube](https://minikube.sigs.k8s.io/docs/start/):

1. Install a  [Hypervisor](https://kubernetes.io/docs/tasks/tools/install-minikube/#install-a-hypervisor) (like [VirtualBox](https://www.virtualbox.org/wiki/Downloads) or [HyperKit](https://github.com/moby/hyperkit) or [Docker](https://docs.docker.com/engine/install/)) to manage virtual machines
1. Install and Set Up [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) to deploy and manage apps on Kubernetes
1. Install [Minikube](https://github.com/kubernetes/minikube/releases)

Start the cluster:

```sh
$ minikube start --memory 8192 --cpus 4
$ minikube dashboard
```
    # If execute other machine access dashboard, enable proxy and execute background
    ```sh
    $ kubectl proxy --address='0.0.0.0' --disable-filter=true &
    ```
    Access:
    ```sh
    http://<EXTERNAL IP>:8001/api/v1/namespaces/kubernetes-dashboard/services/http:kubernetes-dashboard:/proxy/
    ```

# Configure Docker expecific
Build the Docker image:

Point local Docker daemon to the minikube internal Docker registry and create image
```sh
$ eval $(minikube docker-env)
$ docker build -t data-stone:ricardo -f ./docker/Dockerfile ./docker
```

Create the deployments and services:

```sh
$ kubectl create -f ./kubernetes/spark-master-deployment.yaml
$ kubectl create -f ./kubernetes/spark-master-service.yaml
$ kubectl create -f ./kubernetes/spark-worker-deployment.yaml
$ minikube addons enable ingress
$ kubectl apply -f ./kubernetes/minikube-ingress.yaml
```

Add an entry to /etc/hosts locally:

```sh
$ echo "$(minikube ip) spark-kubernetes" | sudo tee -a /etc/hosts
```

Test it out in the browser at [http://spark-kubernetes/](http://spark-kubernetes/).
