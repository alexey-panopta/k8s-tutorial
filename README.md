# Running Jenkins in local k3s - single node kubernetes cluster

1. Install Vagrant and VirtualBox.
2. Start VM:
    ```bash
    vagrant up
    ```
    This command will read the [Vagrantfile](Vagrantfile) and do the following:
    - download Ubuntu image
    - create VM with 1 vCPU and 3GB RAM
    - mount [jenkins](jenkins/) directory
    - run scripts:
        - [docker.sh](scripts/docker.sh) - install docker
        - [k3s.sh](scripts/k3s.sh) - install k3s
        - [jenkins.sh](scripts/jenkins.sh):
            - install helm
            - add official jenkins chart repo
            - deploy jenkins using the [values](jenkins/values.yaml) config file
            - add [ingress](jenkins/ingress.yaml) to expose Jenkins
3. Login into VM and acquire the Jenkins password:
    ```bash
    vagrant ssh
    kubectl exec --namespace jenkins -it svc/jenkins -c jenkins -- /bin/cat /run/secrets/chart-admin-password && echo
    ```
4. Login to Jenkins http://192.168.10.50 with above password.
5. Create pipeline job using sample [pipeline-python.groovy](jenkins/pipeline-python.groovy)

# Running Jenkins in private Google Kubernetes Engine (GKE) cluster

Prerequisites:
- gcloud - https://cloud.google.com/sdk/docs/install
- helm - https://helm.sh/docs/intro/install/

You can follow [official documentation](https://cloud.google.com/kubernetes-engine/docs/how-to/private-clusters) on how to deploy private Google Kubernetes Engine cluster. Bellow is the rough summary:

1. Create and set project:
    ```bash
    gcloud projects create jenkins-k8s-practice
    gcloud config set project jenkins-k8s-practice
    ```
2. Enable container API:
    ```bash
    gcloud services enable container.googleapis.com
    ```
3. Create 2 node cluster:
    ```bash
    gcloud container clusters create jenkins-cd \
    --num-nodes 2 \
    --machine-type n1-standard-2 \
    --scopes "https://www.googleapis.com/auth/projecthosting,https://www.googleapis.com/auth/devstorage.full_control,https://www.googleapis.com/auth/monitoring,https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/compute,https://www.googleapis.com/auth/cloud-platform"
    ```

4. Once cluster is created you can deploy Jenkins on it via helm by following steps from [jenkins.sh](scripts/jenkins.sh) script. Additional details can be found in [official documentation](https://cloud.google.com/solutions/jenkins-on-kubernetes-engine-tutorial), although some steps may be outdated and can differ slightly.
