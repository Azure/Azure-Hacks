# Module 6: Governance & Compliance
## Security Monitoring and Compliance with Microsoft Defender for Cloud

### Overview
Effective security governance requires continuous monitoring, threat detection, and compliance management. Microsoft Defender for Cloud provides comprehensive security posture management and threat protection across your Azure resources.

### Learning Objectives
By completing this module, you will:
- Configure Microsoft Defender for Cloud for comprehensive threat protection
- Analyze security recommendations and improve your Secure Score
- Understand different Defender plans and their capabilities
- Enable Attack Path Analysis for proactive threat detection
- Review governance policies and compliance standards

### Prerequisites
- Completion of previous security modules
- Azure resources deployed in earlier modules
- Permissions to configure security policies and Defender for Cloud

---

## Hands-On Tasks

### Task 1: Enable Microsoft Defender for Cloud
**Goal**: Activate comprehensive threat protection for your Azure resources

**What you'll do**: Set up Microsoft Defender for Cloud with Log Analytics workspace integration and enable enhanced security features across your subscription.

**Success Criteria**: 
- Log Analytics workspace created and configured
- Microsoft Defender for Cloud activated with enhanced security features
- All relevant Defender plans enabled for comprehensive protection
- Understanding of Defender for Cloud capabilities and pricing

 <details close>
<summary>💡 Hint: Defender for Cloud activation steps</summary>
<br>

1. Sign in to the [Azure portal](https://portal.azure.com/) with a user assigned the `Owner` or `Contributor` role in the Azure subscription required for this lab.

2. In the **Search resources, services, and docs** bar at the top, type **Microsoft Defender for Cloud** and press **Enter**.

3. In the left navigation panel, click **Getting started**. On the **Microsoft Defender for Cloud | Getting started** blade, navigate to the **Upgrade** tab.

    ![View1](./images/MSdefender1.png)
     
4. Select a Log Analytics workspace and enable Defender for Cloud on the workspaces. Follow these instructions to create a Log Analytics workspace:

   📘 **How-To:** [Create a Log Analytics workspace](https://learn.microsoft.com/en-us/azure/azure-monitor/logs/quick-create-workspace?tabs=azure-portal)

   ![View2](./images/MSdefender2.png)

5. On the **Upgrade** tab (under **Microsoft Defender for Cloud \| Getting started** blade) , scroll down to the **Select workspaces with enhanced security features** section. Turn on the **Microsoft Defender plan** by selecting your Log Analytics Workspace, then click the large blue **Upgrade** button.

    > **Note:** Review all features available as part of Microsoft Defender plans.



6. Navigate to **Microsoft Defender for Cloud** and, in the left navigation panel under the Management section, click **Environment Settings**.

7. On the **Microsoft Defender for Cloud \| Environment settings** blade, scroll down to the management group/subscription hierarchy. Expand the management groups until your subscription appears and click the relevant subscription.

8. On the **Settings | Defender plans** blade, select **Enable all plans** and click **Save**.

9. Navigate back to the **Microsoft Defender for Cloud \| Environment settings** blade, expand until your subscription appears, and click the entry representing the Log Analytics workspace you created in step 4. This would most likely to appear under your subscription on the hierachy.

10. Under the **Settings \| Defender plans** blade, ensure all options are "On". Click **Enable all plans** and then **Save** if needed.

11. Select **Data collection** from the **Settings | Defender plans** blade, click **All Events**, and **Save**.

    ![View3](./images/data_collection.png)


</details>

### Task 2: Analyze Security Recommendations and Secure Score
**Goal**: Review security posture and prioritize improvements

**What you'll do**: Examine security recommendations, understand risk levels, and identify the most critical security improvements needed for your resources.

**Success Criteria**: 
- Secure Score reviewed and understood
- Top 3 critical security recommendations identified
- Risk levels assessed for different recommendations
- Understanding of remediation options (manual, automated, exemptions)

### Task 3: Optimize Defender Plan Coverage  
**Goal**: Ensure appropriate Defender plans are enabled for your resources

**What you'll do**: Review different Defender plans (Servers, Storage, SQL, etc.) and optimize coverage based on your resource types and security requirements.

**Success Criteria**: 
- Current Defender plans reviewed and understood
- Appropriate plans enabled for resource types in use
- Understanding of different plan features and costs
- Plans adjusted based on security needs vs budget considerations

<details close>
<summary>💡 Hint: How to check security recommendations </summary>
<br>
 
1. Sign in to the Azure portal.

2. Navigate to **Defender for Cloud > Recommendations**.

3. Select a recommendation.

4. Perform the following actions in the recommendation:
   - Select **Open query** to view detailed information about the affected resources using an Azure Resource Graph Explorer query.

     ![view_open_query](./images/open_query.png)

   - Run the query and review the `riskLevel` associated with the recommendations.

     ![view_open_query](./images/run_query.png)

   - Return to **Defender for Cloud > Recommendations** tab.

   - Click on one of the critical recommendations.

     ![view_recommendations](./images/recommendations.png)

   - Select **View policy definition** to view the Azure Policy entry for the underlying recommendation.

     ![view_recommendations](./images/recommendation.png)


**Take action options:**

- **Remediate:** A description of the manual steps required to remediate the security issue on the affected resources. For recommendations with the Fix option, you can select View remediation logic before applying the suggested fix to your resources.

- **Assign owner and due date:** If you have a governance rule turned on for the recommendation, you can assign an owner and due date.

- **Exempt:** You can exempt resources from the recommendation, or disable specific findings using disable rules.

- **Workflow automation:** Set a logic app to trigger with this recommendation.

📘 **How-To Guide:** [Review security recommendations](https://learn.microsoft.com/en-us/azure/defender-for-cloud/review-security-recommendations)

</details>

<details close>
<summary>💡Hint: How to check security score</summary>
<br>
 
📘 **How-To Guide:** [**Track secure score**](https://learn.microsoft.com/en-us/azure/defender-for-cloud/secure-score-access-and-track)
</details>


### Task 3 - Determine which Defender Plans are Active
**Instructions:** Identify active Defender plans.  
**Success criteria:** Ensure the required plans are enabled and active.

<details close>
<summary>💡Hint: Check enabled plans and disable if not required</summary>
<br>
 
📘 **How-To Guide:** [Select a Defender for Servers plan](https://learn.microsoft.com/en-us/azure/defender-for-cloud/tutorial-enable-servers-plan)

When you enable the Defender for Servers plan, you're then given the option to select which plan to enable. There are two plans - Plan 1 or Plan 2 - you can choose from that offer different levels of protections for your resources.

Compare the **[available features](https://learn.microsoft.com/en-us/azure/defender-for-cloud/plan-defender-for-servers-select-plan#plan-features)** provided by each plan.

To select a proper Defender for Servers plan:

1. Sign in to the [Azure portal](https://portal.azure.com).

2. Search for and select **Microsoft Defender for Cloud**.

3. In the Defender for Cloud menu, select **Environment settings**.

4. Select the relevant Azure subscription, AWS account or GCP project.

5. Under **Change plans**, configure the Defender for Servers plan correctly by selecting **Plan 1** or **Plan 2**.

    ![image](./images/defender_for_servers.png)

6. Ensure that all unnecessary plans are disabled.
    
    ![image](./images/plans.png)

</details>

### Task 4: Enable Attack Path Analysis
**Goal**: Set up proactive threat detection using Attack Path Analysis

**What you'll do**: Enable and explore Attack Path Analysis to identify potential security vulnerabilities and attack vectors in your environment before they can be exploited.

**Success Criteria**: 
- Attack Path Analysis enabled and configured
- Attack paths identified and reviewed
- Understanding of how potential attackers could compromise resources
- Risk mitigation strategies identified for detected attack paths

### Task 5: Review Governance Policies and Compliance Standards
**Goal**: Understand governance framework and compliance posture

**What you'll do**: Examine current Azure Policy assignments, compliance standards, and governance rules applied to your resources.

**Success Criteria**: 
- Current policies and compliance standards reviewed
- Understanding of governance rule enforcement
- Compliance gaps identified and prioritized
- Knowledge of how policies support security and compliance objectives

---

## Learning Resources
- [Microsoft Defender for Cloud Documentation](https://learn.microsoft.com/en-us/azure/defender-for-cloud/)
- [Create a Log Analytics workspace](https://learn.microsoft.com/en-us/azure/azure-monitor/logs/quick-create-workspace)
- [Review security recommendations](https://learn.microsoft.com/en-us/azure/defender-for-cloud/review-security-recommendations)
- [Track secure score](https://learn.microsoft.com/en-us/azure/defender-for-cloud/secure-score-access-and-track)
- [Select a Defender for Servers plan](https://learn.microsoft.com/en-us/azure/defender-for-cloud/tutorial-enable-servers-plan)

    ![image](./images/attack_path_analysis1.png)

<details close>
<summary>💡Hint: To identify attack paths</summary>
<br>
 
1. Sign in to the Azure portal.

2. Navigate to **Microsoft Defender for Cloud > Attack path analysis**.

    ![image](./images/attack1.png)

3. Select an attack path.

4. Select a node.

    ![image](./images/attack2.png)

5. Select **Insight** to view the associated insights for that node.

    ![image](./images/attack3.png)

6. Select **Recommendations**.

    ![image](./images/attack4.png)

7. Review the recommendation.

</details>

### Task 5 - View Current Policies and Standards
**Instructions:** Review the current governance policies and standards in place.  
**Success criteria:** 
    1. Familiarity with the Microsoft cloud security benchmark.
    2. NIST Special Publication (SP) 800-53 Rev. 5 or CIS Microsoft Azure Foundations Benchmark v2.0.0 enabled.

💡 **[Regulatory compliance standards in Microsoft Defender for Cloud](https://learn.microsoft.com/en-us/azure/defender-for-cloud/concept-regulatory-compliance-standards)**

<details close>
<summary>💡Hint: To identify attack paths:</summary>
<br>
 
1. Sign in to the Azure portal.

2. Navigate to **Microsoft Defender for Cloud > Regulatory compliance**.

3. Check which **[Compliance Standards](https://learn.microsoft.com/en-us/azure/defender-for-cloud/concept-regulatory-compliance-standards)** are enabled.

    ![image](./images/security_standards.png)

4. Navigate to **Regulatory compliance > Environment Settings > Security Policies**.
- To do this, navigate to **Regulatory compliance** first and click **Manage compliance standards**.

    ![image](./images/regulatory_compliance.png)

    Navigation path: **Home > Microsoft Defender for Cloud > Regulatory compliance > Environment settings**

5. Scroll down and click on your subscription in the management hierarchy.

6. Navigate to the **Security policies** tab

![image](./images/security_policies.png)

Find the required **Security Policy** ``Security Policy NIST Special Publication (SP) 800-53 Rev. 5`` or ``CIS Microsoft Azure Foundations Benchmark v2.0.0`` and enable it.

**[Regulatory compliance standards in Microsoft Defender for Cloud](https://learn.microsoft.com/en-us/azure/defender-for-cloud/concept-regulatory-compliance-standards)**

</details>

## Success Criteria 🎉
- 🎊 **Congratulations!** You have successfully:
  - Deployed a Log Analytics workspace and activated Microsoft Defender for Cloud.
  - Analyzed and identified top security recommendations to improve your secure score.
  - Verified active Defender plans and ensured necessary plans are enabled.
  - Enabled attack path analysis and reviewed affected resources and active attack paths.
  - Reviewed and understood current governance policies and standards, including familiarity with Microsoft cloud security benchmark and NIST SP 800-53 or CIS Microsoft Azure Foundations Benchmark v2.0.0.
- ✅ **Security Hack**: Congratulations you have successfully completed the Security Hack! 🎉

## Navigation
**[< previous Module 5 - Securing Data in Use - Confidential Virtual Machines](../module-5/README.md) |**