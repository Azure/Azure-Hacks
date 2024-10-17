# Chapter 5 - Implement overall monitoring and logging

In order to work towards the reliability of systems in production, we first have to have a decent understanding of those systems and how they're functioning in production. Since here we just deployed our system, we won't have time to do a proper baseline to what shshould be "normal" behaviour.

## SLOs (Service Level Objectives)

In [chapter-0](../chapter-0/README.md) we talked about SLAs which is a contractual commitment for application availability, now we want to discuss the availability target in form of SLO. This is a percentage figure which represents the amount of time in a month when the application is available.

The basic recipe for creating an SLO consists of these ingredients:

- The “thing” you’re going to measure: Number of requests, storage checks, operations; what you’re measuring.
- The desired proportion: For example, "successful 50% of the time," "can read 99.9% of the time," "return in 10ms 90% of the time."
- The time horizon What's the time period we're going to consider for the objective: the last 10 minutes, during the last quarter, over a rolling 30-day window? SLOs are more often than not specified using a rolling window versus a calendar unit like "a month" to allow us to compare data from different periods.

Putting these components together and including the important where information, a sample SLO might look like this:

90% of HTTP requests as reported by the client returned in <20ms in the last 30-day window.

## Task 1: Check the logging for the App Service in the dashboards

When you deployed the Todo app, it already came with a logging system architected to observe the system and trace faults. Go to your resource group and look for the dashboard. What kind of information do you get? Can you see any failure? Does this impact the user?

Explore the realibility tab. If there is a failure, can you trace to where it came from?

Now go back to your resource group and look for the log analytics workspace. Check out the logs tab. How can you query the log data? Which resources are sending data to this workspace? Explore the data with some KQL queries.

## Task 2: Start collecting the logging data from the VMs in the Log Analytics Workspace

We are still missing to collect log information from our VMs and Load Balancer. First, we need to decide what data we want to collect by creating a Data Collection Rule (DCR). DCRs are delivered to any machines they are associated with where Azure Monitor Agent processes them. You can use your existing **Log Analytics Workspace** as destination.

Can you see the log data in your **Log Analytics Workspace**? You can find some KQL queries examples [here](https://learn.microsoft.com/en-us/azure/azure-monitor/reference/queries-by-table).

Experiment shutting down one vm and see how does that affect the **heartbeat**. You can also check in the **extensions** tab of your VM. Is there an agent installed?

## Task 3: Using Insights to Monitor the Load Balancer

In your Load Balancer, look for the tab Insights (part of Monitoring). What can you see there? What are the dependencies? Can you check the metrics? How available has been your backend?

Go to the Diagnostic Settings and add your logs to the Log Analytics Workspace.

## Task 4: Create alerts to get informed of health change of your resources

Let's start with the Load Balancer. Go to the Alerts tab and add new alert. You can choose what will you be monitoring, e.g. health probe. What will be the action when the value monitored falls outside the determined range?

Now check on one of your VMs how/what kind of alert can you add.

What about your app service? And your Database?

💡 **Learning Resources**:
- [Monitoring and Alerting Strategy](https://learn.microsoft.com/en-us/azure/well-architected/reliability/monitoring-alerting-strategy)
- [DCRs Best Practices](https://learn.microsoft.com/en-us/azure/azure-monitor/essentials/data-collection-rule-best-practices)
- [Azure Monitor Documentation](https://learn.microsoft.com/en-us/azure/azure-monitor/)
- [Load Balancer Insights](https://learn.microsoft.com/en-us/azure/load-balancer/load-balancer-insights)
- [Load Balancer Standard Diagnostics](https://learn.microsoft.com/en-us/azure/load-balancer/load-balancer-standard-diagnostics)

## Success Criteria 🎉

- 🎊 **Congratulations!** You added all your resources monitoring data to the Log Analytics Workspace.
- ✅ **Monitoring & Alerting** You learned how you can add monitoring data to a dashboard, how you can get an alert when monitor values fall outside your predetermined value.

**| [next Chapter 6 - Simulate Failures with Azure Chaos Studio >](../chapter-6/README.md)** | 
 **[< previous Chapter 4 - Failover and Restore](../chapter-4/README.md)**