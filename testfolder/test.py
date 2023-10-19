import requests
import json
import sys

print (sys.argv[1:]);
acicvalue = sys.argv[1]
gsaqvalue = sys.argv[2]
title = sys.argv[3]
testvalue =sys.argv[4]

log_data = {
    "ddsource": "custom",
    "tags": ["acmpca-service-quota-limits"],
    "titlemessage": title,
    "presentquotaused": acicvalue,
    "message": "This is a test log message for getting acmpca service quota"


}
print("title",title)
print("Log data", log_data)
