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
kubectl apply -f ./flink-healthcare-molina/files/K8s_Role.yaml
kubectl get Roles
```

# Replcae Placeholder values
You need to replace certain placeholder values for the integrations to work

Filename | Path | Placeholder | Purpose
---------|------|-------------|--------
core-site.xml | <Cloned_Repo_Dir>/flink-healthcare-molina/files, <Cloned_Repo_Dir>/delta-schema-evolution/files | {AZ STORAGE_ACCOUNT ACCESS KEY} | The Access Key for Azure Storage Accounts for ADLS Integration
values.yaml | <Cloned_Repo_Dir>/flink-healthcare-molina, <Cloned_Repo_Dir>/delta-schema-evolution | {azStorageAccountSecret} | The Access Key for Azure Storage Accounts for ADLS Integration

# Launch Flink Cluster
You have a Helm chart that needs to be installed that takes care of deploying the following resousrces
* Config Maps
* Flink Cluster Session mode deployment
* Ingress

```bash
cd <Cloned_Repo_Dir>
helm install <release-name> ./flink-healthcare-molina
```

# Flink SQL CLI in Embedded mode

## Create Catalogs, Tables and Static Tables(reference data) if any
To submit Flink SQL Jobs, you need to create Catalogs, Flink Tables and any static refrence data if your usecase demands them. For Molina, we need to create them upfront event before submitting Flink Jobs through interactive shell.

```bash
kubeclt exec -it <jobmanager pod> bash
cd /opt/flink/usrlib
sql-client.sh -j sql-runner.jar -f sql-scripts/molina_demo_initialize.sql
```
Wait for the execution to complete. This creates the required catalogs, tables and reference data and uploads the same into ADLS Gen2 Storage account.

## Launch Flink SQL CLI - Interactive shell 
Launch the Flink SQL CLI shell - an interactive way of submitting the Jobs

```bash
kubeclt exec -it <jobmanager pod> bash
cd /opt/flink/usrlib
sql-client.sh -j sql-runner.jar -i sql-scripts/molina_demo_ddl.sql
```
The initialization script passed here will just create the catalogs, tables and reference data with in the flink session so that you can submit the flink jobs interactively through Shell.

# Submit Flink Jobs

```bash
FLINK SQL > INSERT INTO raw_claim_diagnosis_delta_table SELECT claim_id, member_id, diagnosis_code, diagnosis_description, diagnosis_date, lab_results, event_time FROM input_claim_diagnosis;
```

# Schema Evolution Usecase - Launch Flink Cluster in Application mode with SchemaEvolution JAR
You have a Helm chart that needs to be installed that takes care of deploying the following resousrces
* Config Maps
* Flink Cluster in Application mode submitting the Job
* Ingress

```bash
cd <Cloned_Repo_Dir>
helm install <release-name> ./delta-schema-evolution
```
This jar takes care of reading the csv files from ADLS and converts it into Delta table and sinks the same into ADLS.
So, donot forget to place the CSV file(source) in ADLS Gen2 storage account.

## Validation
Once the above helm chart is deployed, the schema of the Gold table is expected to be added with a new Column. You can validate this by querying the table from Azure Databricks service.
