*** Settings ***
Documentation     test suite
Force Tags       BID-REQ-002
Resource         ../../../Resources/common.robot
Variables        ../../../Data/Config/live.yml

*** Variables ***
${Authorization}    eyJhbGciOiJIUzI1NiJ9.eyJnb29nbGVJZCI6IjExMDc0NTY0OTQxOTg0NDU4NjM4MCIsInN1YiI6IjExMDc0NTY0OTQxOTg0NDU4NjM4MCIsImlzcyI6Imh0dHA6XC9cL2ludGVybmFsLWFwaS1hY2wtc3RhZ2luZy5qdW1pYS5zZXJ2aWNlcyIsIm5hbWUiOiJNYWhtb3VkIEVsIFRvaGFteSIsImV4cCI6MTcyODIyMTc1OSwidHlwZSI6IkxPR0lOIiwiZW1haWwiOiJtYWhtb3VkLmVsdG9oYW15QGp1bWlhLmNvbSIsInBpY3R1cmUiOiJodHRwczpcL1wvbGgzLmdvb2dsZXVzZXJjb250ZW50LmNvbVwvYVwvQUNnOG9jSi1RektIdWxkSmotYVk2SFkwenpZcURGS2RCeGVQWXhRVFJIN0xjWFZ5cGNLeXdiaz1zOTYtYyIsInNpZCI6IjNhZjQ1MWUwLTdhZjQtM2ZlNS1iZTZhLWRmNzZkZjdmYzVlNSIsInVzZXJuYW1lIjoibWFobW91ZC5lbHRvaGFteUBqdW1pYS5jb20ifQ.bt32L0Q4wmQ4An6fxejRDy8eZtvks-RQfv9WMfxYmYA
${VALID_X_SHOP_SID_LIST}    64ead0f7-e031-46b4-8d02-07954a0a8577

*** Test Cases ***
01. List Total Pending Orders in Last Seven Days - 
    [Tags]  valid    vcs    smoke    Positive
    ${resp}=    Api call   vcs.OrderDashboard.totalPendingLastSevenDaysUsingGET    Authorization=${Authorization}        X_SHOP_SID_LIST=${VALID_X_SHOP_SID_LIST}       
    Should Be Equal As Strings    200   ${resp.status_code}
    # Assert API response schema    vcs.OrderDashboard.totalPendingLastSevenDaysUsingGET       Pass     ${resp}
    # ${length}=  Get length  ${resp.json()}
    # # Should Be Equal As Strings    100   ${length}

