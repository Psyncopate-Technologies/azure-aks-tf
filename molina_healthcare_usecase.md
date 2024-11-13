# Requirement
1. Spin up a Flink Cluster in Session mode using CP Flink Operator
2. Use Flink SQL APIs to build business logics.
3. The use case to be built is documented here - https://psyncopate.sharepoint.com/:x:/r/sites/FlinkWorkingGroup/_layouts/15/Doc.aspx?sourcedoc=%7B1C7435B4-29C5-4E0F-943F-02E30A0ADFA5%7D&file=Molina_Worksheet.xlsx&action=default&mobileredirect=true
4. Submit Flink SQL APIs through Interactive SQL CLI Shell

# Pre-requisites
1. You must clone this repo and the going forward the directory where it is cloned will be referenced as '<Cloned_Repo_Dir>'
1. You should have a jar built and pushed to Dockerhub - flink-sql-runner jar. Refer to this document to build one - https://github.com/Psyncopate-Technologies/FlinkRetailUseCase/blob/main/molina_demo_readme.md#pre-requisites
2. The updated Docker image should be referenced in the K8s manifest placed under <Cloned_Repo_Dir>/molina_deployments

# Flink Operator Setup
Follow this document to get the Flink Operator installed
https://docs.confluent.io/platform/current/flink/get-started.html#get-af-cp-long

# Additional K8s Roles for Service Account

You need to provide additional roles to the K8s service account with which the CLI shell is going to get started ('flink')

```bash
cd <Cloned_Repo_Dir>
kubectl apply -f ./molina_deployments/K8s_Role.yaml
kubectl get Roles
```

# Replcae Placeholder values
You need to replace certain placeholder values for the integrations to work

Filename | Path | Placeholder | Purpose
---------|------|-------------|--------
core-site.xml | <Cloned_Repo_Dir>/molina_deployments | {AZ STORAGE_ACCOUNT ACCESS KEY} | The Access Key for Azure Storage Accounts for ADLS Integration
flink_cluster_session_mode.yaml | <Cloned_Repo_Dir>/molina_deployments | {AZ STORAGE_ACCOUNT ACCESS KEY} | The Access Key for Azure Storage Accounts for ADLS Integration


# Provision Config Map to hold Hadoop Configs

This is required for ADLS intergration where the Checkpoints/Savepoints and Delta Tables are going to reside

```bash
cd <Cloned_Repo_Dir>
kubectl create configmap core-site-config --from-file=./molina_deployments/core-site.xml
```

# Launch Flink Cluster in Session mode

```bash
cd <Cloned_Repo_Dir>
kubectl apply -f ./molina_deployments/flink_cluster_session_mode.yaml
kubectl get pods
```

# Provision Ingress to access Flink Dashboard

```bash
cd <Cloned_Repo_Dir>
kubectl apply -f ./molina_deployments/flink_cluster_ingress.yaml
kubectl get ingress
```
This will provision an Ingress K8s resource which will be exposed over a public IP which can be access from your browser.
Validate the Flink dashboard by navigating to http://<Public_IP>/

# Launch Flink SQL CLI in Embedded mode

Launch the Flink SQL CLI shell - an interactive way of submitting the Jobs

```bash
kubeclt exec -it <jobmanager pod> bash
cd /opt/flink/bin
./sql-client.sh -j ../usrlib/sql-runner.jar -i ../usrlib/sql-scripts/initialize-data-ingestion-to-adls.sql
```

# Submit Flink Jobs

```bash
FLINK SQL > INSERT INTO raw_claim_diagnosis_delta_table SELECT claim_id, member_id, diagnosis_code, diagnosis_description, diagnosis_date, lab_results, event_time FROM input_claim_diagnosis;
```