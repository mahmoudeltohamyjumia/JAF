*** Settings ***
Documentation     List All clients
Resource    ../../../Resources/common.robot
Variables        ../../../Data/Config/live.yml

*** Variables ***
# ${error_schema}                 response_error.schema.json
# ${valid_offset}       0
# ${min_offset}         -1
# ${max_offset}         300000000000000000000000
# ${invalid_offset}     sssssssssssssssssssssssss
# ${below_min_limit}    0
# ${valid_limit}        1
# ${max_limit}          100
# ${above_max_limit}    101
# ${invalid_limit}      sssssssssssssssssssssssss
${Authorization}    eyJhbGciOiJIUzI1NiJ9.eyJnb29nbGVJZCI6IjExMDc0NTY0OTQxOTg0NDU4NjM4MCIsInN1YiI6IjExMDc0NTY0OTQxOTg0NDU4NjM4MCIsImlzcyI6Imh0dHA6XC9cL2ludGVybmFsLWFwaS1hY2wtc3RhZ2luZy5qdW1pYS5zZXJ2aWNlcyIsIm5hbWUiOiJNYWhtb3VkIEVsIFRvaGFteSIsImV4cCI6MTcyODEyMTAzNiwidHlwZSI6IkxPR0lOIiwiZW1haWwiOiJtYWhtb3VkLmVsdG9oYW15QGp1bWlhLmNvbSIsInBpY3R1cmUiOiJodHRwczpcL1wvbGgzLmdvb2dsZXVzZXJjb250ZW50LmNvbVwvYVwvQUNnOG9jSi1RektIdWxkSmotYVk2SFkwenpZcURGS2RCeGVQWXhRVFJIN0xjWFZ5cGNLeXdiaz1zOTYtYyIsInNpZCI6IjNhZjQ1MWUwLTdhZjQtM2ZlNS1iZTZhLWRmNzZkZjdmYzVlNSIsInVzZXJuYW1lIjoibWFobW91ZC5lbHRvaGFteUBqdW1pYS5jb20ifQ.Aj43Zh8xuzLEyqUalCHVghEBGtkuERMPcEfd6-IaHbQ
${VALID_X_SHOP_SID_LIST}    64ead0f7-e031-46b4-8d02-07954a0a8577

*** Test Cases ***
01. List Total Pending Orders in Last Seven Days - 
    [Tags]  valid    admin-private    client    smoke    Positive
    ${resp}=    Api call   OrderDashboard.totalPendingLastSevenDaysUsingGET    Authorization=${Authorization}        X_SHOP_SID_LIST=${VALID_X_SHOP_SID_LIST}       
    Should Be Equal As Strings    200   ${resp.status_code}
    # Assert API response schema    OrderDashboard.totalPendingLastSevenDaysUsingGET       Pass     ${resp}
    # ${length}=  Get length  ${resp.json()}
    # # Should Be Equal As Strings    100   ${length}

