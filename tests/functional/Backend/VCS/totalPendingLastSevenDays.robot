*** Settings ***
Documentation     test suite
Force Tags       BID-REQ-002
Resource         ../../../../Resources/common.robot

*** Variables ***
${Authorization}    eyJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvYXBpLWFjbC12ZW5kb3Itc3RhZ2luZy5qdW1pYS5jb20iLCJuYW1lIjoicGFvcGFvIiwiZXhwIjoxNzI4ODM1MzcwLCJ0eXBlIjoiTE9HSU4iLCJlbWFpbCI6InBhb3Bhb0BtYWlsaW5hdG9yLmNvbSIsInNpZCI6ImEzN2NjOWQ2LTBlZjUtMzZkMi1iZTMyLWQ0NDVjNzVkMDdjNSIsInVzZXJuYW1lIjoicGFvcGFvQG1haWxpbmF0b3IuY29tIn0.cWelUUCiGhejWFT4fbXPuJxHiPO9O5rUf4HGX0teYEw
${VALID_X_SHOP_SID_LIST}    64ead0f7-e031-46b4-8d02-07954a0a8577

*** Test Cases ***
01. List Total Pending Orders in Last Seven Days - 
    [Tags]  valid    vcs    smoke    Positive
    ${resp}=    Api call   vcs.OrderDashboard.totalPendingLastSevenDaysUsingGET    Authorization=${Authorization}        X_SHOP_SID_LIST=${VALID_X_SHOP_SID_LIST}       
    Should Be Equal As Strings    200   ${resp.status_code}
    # Assert API response schema    vcs.OrderDashboard.totalPendingLastSevenDaysUsingGET       Pass     ${resp}
    # ${length}=  Get length  ${resp.json()}
    # # Should Be Equal As Strings    100   ${length}

