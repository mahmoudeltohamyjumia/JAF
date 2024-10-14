# AFRSC-14281: Enhance Stock Visibility Test Plan

## Introduction

| What | Ease the way sellers check their stock levels |
|      | ensure the accuracy of DS available stock     |
|      | ensure sellers can easily reconcile their available stock regardless of the shipment type ( DS and FBJ) |
| Why  | Improve user experience |
| Who  | All sellers ( Priority to Local sellers as they have one shop with both JE and DS, while Global has a separate shop for FBJ and DS ) |


## Test Objectives

The objectives of this test plan are to:

* Ensure that the VC :: Enhance Stock Visibility feature is designed and implemented correctly according to the requirements and specifications
* Verify that the user interface is intuitive, easy to use, and provides a seamless experience for users
* Test the data visualization and analysis capabilities of the feature
* Confirm that customizable dashboards are available and can be used effectively by users
* Ensure that the feature integrates smoothly with external data sources, if applicable

## Scope (in/out)

- This test plan covers the following aspects of the VC :: Enhance Stock Visibility feature:

* User interface design and layout/Customizable dashboards
* Data migration (ETL)
* Integration with external data sources, if applicable

- Stories to be covered:

| Task ID | microservice | Description | Status | in/out Scope |
| --- | --- | --- | --- | --- |
|  AFRSC-14342  |  Consignment  	 |  Create a new endpoint to fetch detailed FBJ stock from WMT 									   |  Closed                |  🟢 |
|  AFRSC-14297  |  PIM   			 |  Remove Stock dependency from the Catalog products API 								    	   |  Closed                |  🟢 |
|  AFRSC-14294  |  Stock  			 |  Create archive mechanism for the table sales order item	                                       |  Backlog               |  ⚪ |
|  AFRSC-14290  |  Stock			 |  I want to be able to consume events from Sales Order Item connector	                           |  Closed                |  🛑 |
|  AFRSC-14291  |  Stock  			 |  I want to save on a table the last sale order items events	                                   |  Closed                |  🛑 |
|  AFRSC-14303  |  Stock  			 |  I want to update the table sales_order_item with the stock events	                           |  In QA                 |  🛑 |
|  AFRSC-14336  |  Stock  			 |  Update stock table with new values coming from the SalesOrdersItems	                           |  In Review             |  🛑 |
|  AFRSC-14295  |  Stock  			 |  Create Migration Endpoint	                                                                   |  Backlog               |  🟢 |
|  AFRSC-14337  |  Stock  		     |  Update get Stock endpoint whith new coloumns name	                                           |  Backlog               |  🟢 |
|  AFRSC-14298  |  VC-UI  			 |  Improve the stock display popup on the catalog products	                                       |  Closed                |     |
|  AFRSC-14311  |  VC-UI  			 |  Improve the manage Product list view to show the total available stock (FBJ + Dropshipping)    |  Closed                |     |
|  AFRSC-14340  |  VC-UI  			 |  Enhance the FBJ list page	                                                                   |  Closed                |     |
|  AFRSC-14341  |  VC-UI  			 |  Add to FBJ non sellable a popup with the oms stock information	                               |  In Progress           |     |
|  AFRSC-14338  |  VC-UI  			 |  Update stock popup to fetch the new values coming from the stock endpoint	                   |  Backlog               |  ⚪ |
|  AFRSC-14296  |  VC-UI  			 |  Improve the product catalog page to get the stock directly from the stock service	           |  Closed                |     |
|  AFRSC-14289  |  SC  		     	 |  Improve salers order item connector	                                                           |  Closed                |  🛑 |
|  AFRSC-14293  |  Kafka connector   |  Start new connectors sales Order item connector to Stock	                                   |  Closed                |     |
|  AFRSC-14405  |  Spike  			 |  Create archive mechanism for the table sales order item on Stock	                           |  Ready for Development |     |
|  AFRSC-14292  |  Enhance Stock     |  E2E Tests                                                                                      |  Backlog               |  ⚪ |






5. Test Data and Environment
6. Test Case Definitions and Execution Plan
7. Quality Metrics and Standards
10. Dependencies, Risks and Assumptions
    - need to know why staging is not stable and how to ensure the stability of this
    - need help to be able for test data management alone
    - access to kafka (OMS) and opensearch to get logs, and check messages
