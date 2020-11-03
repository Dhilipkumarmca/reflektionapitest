*** Settings ***
Library  ../api/rootlib.py
Library  ../api/validate.py
Library  Collections

*** Variables ***
${base_url}        https://jsonplaceholder.typicode.com

*** Test Cases ***
Gat All User And Validate
    ${status_code}  ${user_details}  get  ${base_url}/posts
    Should Be Equal   ${status_code}  ${200}
    ${length}  Get Length  ${user_details}
    should_be_greater_than_or_equal_to  ${length}  ${100}
    should_be_list  ${user_details}
    ${list_index}  Get From List  ${user_details}  ${0}
    should_be_dictionary  ${list_index}

Get Single User And Validate
    ${status_code}  ${user_details}  get  ${base_url}/posts/1
    Should Be Equal   ${status_code}  ${200}
    should_be_dictionary  ${user_details}
    ${val}  Get From Dictionary  ${user_details}  id
    Should Be Equal  ${val}  ${1}

Get Invalid URL And Validate
    ${status_code}  ${user_details}  get  ${base_url}/invalidposts
    Should Be Equal   ${status_code}  ${404}

Create New User And Validate
    ${user_dict}  Create Dictionary  title=foo  body=bar  userId=1
    ${status_code}  ${user_detail}  post  ${base_url}/posts  ${user_dict}
    Should Be Equal   ${status_code}  ${201}
    should_be_dictionary  ${user_detail}
    ${val}  Get From Dictionary  ${user_detail}  id
    ${status_code}  ${user_details}  get  ${base_url}/posts/${val}
    Should Be Equal   ${status_code}  ${200}  New User not created, User validation failed
    should_be_dictionary  ${user_detail}

Update User and Validate
    ${user_dict}  Create Dictionary  id=1  title=foo  body=bar  userId=1
    ${status_code}  ${user_detail}  put  ${base_url}/posts/1  ${user_dict}
    Should Be Equal   ${status_code}  ${200}
    should_be_dictionary  ${user_detail}
    ${status_code}  ${user_details}  get  ${base_url}/posts/1
    Should Be Equal   ${status_code}  ${200}
    should_be_dictionary  ${user_details}
    ${val_title}  Get From Dictionary  ${user_details}  title
    ${val_body}  Get From Dictionary  ${user_details}  body
    Should Be Equal  ${val_title}  foo  User not updated
    Should Be Equal  ${val_body}  body  User not updated

Delete User And Validate
    ${status_code}  ${user_detail}  delete  ${base_url}/posts/1
    Should Be Equal   ${status_code}  ${200}
    ${status_code}  ${user_details}  get  ${base_url}/posts/1
    Should Be Equal   ${status_code}  ${404}  User not deleted