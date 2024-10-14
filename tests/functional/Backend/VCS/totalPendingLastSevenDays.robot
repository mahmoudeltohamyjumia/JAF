*** Settings ***
Documentation     test suite
Force Tags       BID-REQ-002
Resource         ../../../../Resources/common.robot
*** Variables ***

*** Test Cases ***
01. List Total Pending Orders in Last Seven Days
    [Tags]  valid    vcs    smoke    Positive
    ${resp}=    Api call   ${VCS_BASE_URL}     vcs.OrderDashboard.totalPendingLastSevenDaysUsingGET    200
    ...    Authorization=${VALID_AUTH}        X_SHOP_SID_LIST=${VALID_X_SHOP_SID_LIST}
    Log    ${resp.json()}
    Assert API response schema    vcs.OrderDashboard.totalPendingLastSevenDaysUsingGET       Pass     ${resp}
