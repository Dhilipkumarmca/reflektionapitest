import requests
import json

def get(endpoint):
    headers = {'content-type': 'application/json','charset':'UTF-8'}
    response=requests.get(endpoint,headers=headers)
    return response.status_code,response.json()

def post(endpoint,request_payloads):
    headers = {'content-type': 'application/json','charset':'UTF-8'}
    response = requests.post(endpoint,data=json.dumps(request_payloads),headers=headers)
    return response.status_code, response.json()

def put(endpoint,request_payloads):
    headers = {'content-type': 'application/json','charset':'UTF-8'}
    response = requests.put(endpoint, data=json.dumps(request_payloads),headers=headers)
    return response.status_code, response.json()

def delete(endpoint):
    headers = {'content-type': 'application/json','charset':'UTF-8'}
    response = requests.delete(endpoint,headers=headers)
    return response.status_code, response.json()