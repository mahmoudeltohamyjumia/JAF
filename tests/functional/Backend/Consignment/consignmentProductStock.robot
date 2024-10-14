*** Settings ***
Documentation     test suite
Force Tags       BID-REQ-002
Resource         ../../../../Resources/common.robot

*** Variables ***


*** Test Cases ***
01. Get Consignment Order Stocks - valid
    [Tags]  valid    vcs    smoke    Positive
    ${resp}=    Api call   ${CON_BASE_URL}     consignment.consignmentOrderRetrievalController.ConsignmentOrderStocksUsingGET    200    Authorization=${VALID_AUTH}
    ...    shopSid=${VALID_X_SHOP_SID_LIST}    businessClientCode=${VALID_BUSINESS_CLIENT_CODE}
    Log    ${resp.json()}
    Assert API response schema    consignment.consignmentOrderRetrievalController.ConsignmentOrderStocksUsingGET       Pass     ${resp}

02. Get Consignment Order Stocks - wrong businessClientCode
    [Tags]  valid    vcs    smoke    Positive
    ${resp}=    Api call   ${CON_BASE_URL}     consignment.consignmentOrderRetrievalController.ConsignmentOrderStocksUsingGET    422    Authorization=${VALID_AUTH}
    ...    shopSid=${VALID_X_SHOP_SID_LIST}    businessClientCode=${INVALID_BUSINESS_CLIENT_CODE}
    Should Be Equal As Strings    422   ${resp.status_code}
    Log    ${resp.json()}
    Assert API response schema    consignment.consignmentOrderRetrievalController.ConsignmentOrderStocksUsingGET       Failed     ${resp}
    Should Be Equal As Strings    2001    ${resp.json()["code"]}
    Should Be Equal As Strings    The business client mentioned does not correspond to a country where Jumia offers storage service. Please use an existing one    ${resp.json()["message"]}

03. Get Consignment Order Stocks - empty businessClientCode
    [Tags]  valid    vcs    smoke    Positive
    ${resp}=    Api call   ${CON_BASE_URL}     consignment.consignmentOrderRetrievalController.ConsignmentOrderStocksUsingGET    422    Authorization=${VALID_AUTH}
    ...    shopSid=${VALID_X_SHOP_SID_LIST}    businessClientCode=${EMPTY}
    Should Be Equal As Strings    422   ${resp.status_code}
    Log    ${resp.json()}
    Assert API response schema    consignment.consignmentOrderRetrievalController.ConsignmentOrderStocksUsingGET       Failed     ${resp}
    Should Be Equal As Strings    2001    ${resp.json()["code"]}
    Should Be Equal As Strings    The business client mentioned does not correspond to a country where Jumia offers storage service. Please use an existing one    ${resp.json()["message"]}

04. Get Consignment Order Stocks - empty auth
    [Tags]  valid    vcs    smoke    Positive
    ${resp}=    Api call   ${CON_BASE_URL}     consignment.consignmentOrderRetrievalController.ConsignmentOrderStocksUsingGET    401    Authorization=${EMPTY}
    ...    shopSid=${VALID_X_SHOP_SID_LIST}    businessClientCode=${VALID_BUSINESS_CLIENT_CODE}
    Should Be Equal As Strings    401   ${resp.status_code}
    Log    ${resp.json()}
    Assert API response schema    consignment.consignmentOrderRetrievalController.ConsignmentOrderStocksUsingGET       Failed     ${resp}
    Should Be Equal As Strings    2001    ${resp.json()["code"]}
    Should Be Equal As Strings    Authorization type is invalid    ${resp.json()["message"]}
