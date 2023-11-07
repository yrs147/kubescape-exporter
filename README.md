# Kubescape Exporter

### Overview

The Kubescape Exporter plays a crucial role in the Kubernetes security landscape. It gathers information about image vulnerabilities and compliance with security controls by scanning various resources in your Kubernetes cluster. The exporter aggregates this information and makes it accessible to Prometheus. By doing this, it enables you to monitor and visualize the security posture of your Kubernetes cluster over time.

### Architecture
![Exporter](https://github.com/yrs147/kubescape-exporter/assets/98258627/c77076cf-a29c-481e-96d6-b50353a44498)


### How It Works

1. **Data Collection**: The exporter uses the client-go library to interact with the Kubernetes API server. It reads objects and Custom Resource Definitions (CRDs) related to security scans and vulnerabilities.

2. **Metrics Aggregation**: After collecting the necessary data, the exporter processes and aggregates it into a format suitable for Prometheus. This includes information about image vulnerabilities and  control scans.

3. **Prometheus Integration**: The exporter exposes these aggregated metrics to Prometheus, allowing it to scrape the data at regular intervals. You can configure Prometheus to pull the data from the exporter.

4. **Visualization with Grafana**: Once the data is available in Prometheus, you can create and customize dashboards in Grafana to visualize the security metrics. This allows you to monitor the security posture of your Kubernetes cluster, detect anomalies, and set up alerting rules as needed.

### Getting Started

To get started with the Kubescape Exporter, follow these steps:

1. **Prerequisites**: Ensure that you have a running Kubernetes cluster. You can set up a local cluster using tools like Minikube or use a production cluster. Make sure your `kubectl` is configured to interact with the desired cluster.

2. **Helm Chart Installation**: Install the Kubescape Helm chart by running the following command. Replace `<my_account_ID>` with your account ID and ensure the `clusterName` is set correctly.
```
helm upgrade --install kubescape kubescape/kubescape-operator -n kubescape --create-namespace --set account=<my_account_ID> --set capabilities.continuousScan=enable --set clusterName=`kubectl config current-context`
```
This command deploys the Kubescape operator to your cluster, which is responsible for running scans and generating security metrics.

3. Clone the Repository: Clone the Kubescape Exporter repository from GitHub to your local environment.
```
git clone https://github.com/yrs147/kubescape-exporter.git
```
4. Navigate to the Project Directory: Change your working directory to the cloned repository.
```
cd kubescape-exporter
```  

5. Run the Exporter: Execute the Kubescape Exporter by running the following command:
```
go run main.go
```
The exporter will start collecting security metrics from the Kubernetes cluster and exposing them for Prometheus to scrape.

6. Accessing Metrics:

To access the exported metrics directly from the exporter, open your web browser and go to: `http://localhost:8080/metrics`

To visualize the metrics in Prometheus, ensure that you have Prometheus configured to scrape metrics from the Kubescape Exporter. You can access Prometheus's web interface, usually available at http://localhost:9090.

7. Make sure grafana is installed and running. You can access Grafana's web interface, usually available at http://localhost:3000. You can also check the status of the Grafana by running the following command:
```
sudo systemctl status grafana
```
If it is not running, you can start it by running the following command:
```
sudo systemctl start grafana
```
8. Initially, you will need to log in to Grafana using the default credentials. The default username is `admin`, and the default password is `admin`. You will be prompted to change the password after logging in for the first time.

9. Create a data source in Grafana. To do this, follow these steps:
- In the Main Menu on the left, under Connections, Click Data sources.
- Click Add data source on the top right.
- Select Prometheus as the data source.
- In the URL field, enter the URL of the Prometheus server. Usually, this is http://localhost:9090.
- Click Save & Test.

10. Create a dashboard in Grafana using the following steps:
- On the top-right, click on Build Dashboard.
- Click on Add Visualization.
- Select the data source you created in the previous step.
- Select the metrics you want to visualize. For e.g., You can just type `critical` to get all the critical controls and vulnerabilities in both cluster and namespace scope.
- You can also view the metrics using the `Label filters` option. For e.g. Apply the label filter `namespace=kubescape` to get all the vulnerabilities in the kubescape namespace.
- Click on Save & Apply.

11. Monitoring and Alerting: Customize Grafana to set up monitoring and alerting rules based on security metrics. This will help you keep track of the security posture of your Kubernetes cluster and receive alerts for any anomalies.

Please note that you should ensure that your Kubernetes cluster is up and running before running the Kubescape Exporter. Also, keep the exporter running in the background to collect and serve security metrics continually.

If you encounter issues during setup or have questions, please refer to the project's documentation or open an issue on the project's GitHub repository for assistance.

