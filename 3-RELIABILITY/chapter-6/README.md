# Chapter 6 - Simulate Failures with Azure Chaos Studio

You can use a chaos experiment to verify that your application is resilient to failures by causing those failures in a controlled environment.

## Task 1: Simulate CosmosDB Failover to a Secondary Region

### Step-by-Step Guide

1. **Open Azure Chaos Studio**
   - Navigate to ``Azure Chaos Studio`` and enable it on your Azure Cosmos DB account.

2. **Set Up Your Target**
   - Select on ``Targets`` your CosmosDB account.

Afterwards, create an experiment to simulate CosmosDB failover. The experiment designer allows you to build your experiment by adding steps, branches, and faults.

3. **Create the Experiment to simulate CosmosDB failover**
   - Use the experiment designer to build your experiment by adding steps, branches, and faults.
   - Give a friendly name to your ``Step`` and ``Branch``.
   - Select **Add action** > **Add fault** > select **CosmosDB Failover**.

4. **Assign Permissions**
   - When you create a chaos experiment, Chaos Studio generates a system-assigned managed identity to execute faults against your target resources.
   - This identity must have the appropriate permissions to run the experiment successfully.
     - Go to your Azure Cosmos DB account and select **Access control (IAM)** > **Add** > **Add role assignment**.
     - You can now add your experiment to the role ``Cosmos DB Operator`` by assigning.

5. **Run the Experiment**
   - Run your experiment and open/keep open a second window to monitor your CosmosDB Account in the **Replicate data globally** tab.
   - Refresh the page periodically to observe the region change during the experiment.

### Additional Tips

- **Monitoring the Failover**: Keeping a second window open to observe the failover in real-time helps you understand the impact and timing of the failover process.
- **Permissions**: Ensure that the managed identity has the correct permissions before running the experiment to avoid interruptions.

By completing this task, you will have verified your Azure Cosmos DB's resilience to regional failovers, enhancing your system's robustness and reliability.

<details close>
<summary>💡 Hint: Detailed instructions</summary>
<br>

For more details on how to set up Chaos Studio, check the link [Chaos Studio tutorial Service Direct](https://learn.microsoft.com/en-us/azure/chaos-studio/chaos-studio-tutorial-service-direct-portal).
</details>

## Task 2: Simulate High CPU Utilization in VM1

### Step-by-Step Guide

Use Azure Chaos Studio to simulate a high % of CPU utilization event on a Linux virtual machine (vm1) by using a chaos experiment. You can use these same steps to set up and run an experiment for any agent-based fault. An agent-based fault requires setup and installation of the chaos agent.

First Step is to create a **managed identity**:

### 1. Create a Managed Identity

- Follow the steps here to [create a Managed Identity](https://learn.microsoft.com/en-us/entra/identity/managed-identities-azure-resources/how-manage-user-assigned-managed-identities?pivots=identity-mi-methods-azp)

### 2. Enable Chaos Target

Just like for CosmosDB, you will need to enable the Chaos target. 
- Add both virtual machines to the target list.
- Use the managed identity you created just above. 
- This action will install the chaos agent as an extension on the VMs.
- After deployment, check the **Extensions** tab on your virtual machine to confirm that the chaos agent is installed.

### 3. Create the Experiment

Now you need to create your experiment.

Create an experiment to simulate high CPU utilization:
- Use the experiment designer to build your experiment - test of high % of CPU.
- For this task, use **CPUPressure** as the Action in your branch.
- Leave **virtualMachineScaleSetInstances** empty; you will select the target VM when clicking next. That's all you need to create the experiment to test your vms.
- Complete the experiment setup to test your VMs.

### 4. Assign the Role

Next step is to create a ``role assigment`` so the experiment has the write access to your vm.

Assign the necessary roles to your experiment:
- Go to the **IAM settings** of the VM.
- Choose ``Create a role assignment``.
- Assign the reader role to the managed identity associated with your experiment.

### 5. Run the Experiment
Now you can run your experiment.

Run your experiment and monitor its progress:
- Open the **Azure Monitor Metrics chart**.
- Select **CPU pressure** as the metric to observe.
- Check/monitor the performance and CPU utilization of VM1 to ensure the experiment is running correctly.

### Additional Tips

- **Monitoring**: Keep the Azure Monitor Metrics chart open to observe real-time changes in CPU utilization during the experiment.
- **Permissions**: Double-check role assignments to ensure the experiment has the necessary permissions.

By completing this task, you will have tested the resilience of your virtual machine against high CPU utilization scenarios, enhancing your system's robustness and operational readiness.

<details close>
<summary>💡 Hint: Detailed instructions</summary>
<br>

For more details on how to set up Chaos Studio, check the link  [Chaos Studio tutorial Agent Based](https://learn.microsoft.com/en-us/azure/chaos-studio/chaos-studio-tutorial-agent-based-portal).
</details>

## Success Criteria 🎉

- 🎊 **Congratulations!** You successfully learned how to use Azure Chaos Studio to simulate failover scenarios and high CPU utilization events.
- ✅ **Reliability Mastery**: You have effectively tested the reliability of your system and completed the Reliability Hackathon Challenge!

**[< Previous Chapter 5 - Implement Overall Monitoring and Logging](../chapter-5/README.md)**

For an additional advanced challenge, dive into the following task to exercise Well-Architected Reliability best practices:
**[Next - (Optional) Chapter Advanced - Deploy Azure Mission-Critical Reference Implementation >](../chapter-advanced/README.md)**