# Data Warehouse and Analytics Project

Welcome to the **Engineering Stores KPI** repository! 🚀  
This project demonstrates a comprehensive data warehousing and analytics solution, from building a data warehouse to generating actionable insights. Designed as a portfolio project, it highlights industry best practices in data engineering and analytics.


## 🏗️ Data Architecture

The data architecture for this project follows Medallion Architecture **Bronze**, **Silver**, and **Gold** layers:

1. **Bronze Layer**: Stores raw data as-is from the source systems. Data is ingested from CSV Files into SQL Server Database.
2. **Silver Layer**: This layer includes data cleansing, standardization, and normalization processes to prepare data for analysis.
3. **Gold Layer**: Houses business-ready data modeled into a star schema required for reporting and analytics.


This project involves:

1. **Data Architecture**: Designing a Modern Data Warehouse Using Medallion Architecture **Bronze**, **Silver**, and **Gold** layers.
2. **ETL Pipelines**: Extracting, transforming, and loading data from source systems into the warehouse.
3. **Data Modeling**: Developing fact and dimension tables optimized for analytical queries.
4. **Analytics & Reporting**: Creating SQL-based reports and dashboards for actionable insights.


### Building the Data Warehouse (Data Engineering)

#### Objective
Develop a modern data warehouse using SQL Server to consolidate sales data, enabling analytical reporting and informed decision-making.

#### Specifications
- **Data Sources**: Import data from two source systems (ERP and CRM) provided as CSV files.
- **Data Quality**: Cleanse and resolve data quality issues prior to analysis.
- **Integration**: Combine both sources into a single, user-friendly data model designed for analytical queries.
- **Scope**: Focus on the latest dataset only; historization of data is not required.
- **Documentation**: Provide clear documentation of the data model to support both business stakeholders and analytics teams.# EngineeringStoresKPI_Dashboard
Managing engineering stores is more than just counting bolts; it is a strategic balancing act between financial health and operational readiness. 

### Engineering Stores KPI Dashboard: Turning Data into Strategy. 

I built an Engineering Stores KPI Dashboard—highlighted in the attachment — using SQL in MS SQL Server and Microsoft Power BI. It has fundamentally changed how the team views inventory, shifting from reactive counting to proactive management.  While the visuals in dashboard  provide the "what," the strategic objectives provide the "how" for our next phase of optimization.  

### The Snapshot:
📦Inventory Depth: 2,251 items are currently tracked across the store.  
⚠️📉Availability Gaps: 170 items are sitting at zero stock, while 53 have fallen below minimum levels.  
💰Capital Value: We are maintaining a Stock on Hand (SOH) value of R8M.  Pipeline: R787K in open orders across 140 order lines.  
🚀 Strategic Priorities Data without action is just a chart. Based on the analysis, we are focusing on:
🏭SOH Management: Evaluating our 8M target to accommodate necessary stock add-ons for new machinery.  
💰Critical Assets: Collaborating with the National Team on a plan for our highest-value item, a Transformer valued at 647K.  
🔴Reducing Waste: Reviewing 253K in obsolete stock for write-off within the F22 cycle.  
📋Supply Chain Agility: Addressing items outstanding for 18–30+ days by sourcing alternatives to prevent bottlenecks.  
⚠️Risk Mitigation: Managing 82 orders at zero stock by coordinating with maintenance teams to plan for spare unavailability.  

#### The Takeaway:
The SOH Value Movement chart in updated Dashboard tracks daily fluctuations, giving management a clear view of how purchasing impacts working capital. This project sharpened my skills in translating complex SQL queries into insights that Procurement, Finance, and Engineering can actually use.


