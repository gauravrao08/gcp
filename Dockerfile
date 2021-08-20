FROM node:6
RUN apt-get update && apt-get install -y curl && apt-get install -y gnupg 

RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list \
  && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg add - \
  && apt-get update && apt-get install -y google-cloud-sdk
  
##this to add gcp SKD to container

RUN gcloud auth activate-service-account test@test.iam.gserviceaccount.com --key-file test-45455b1a.json --project gaurav-test
CMD node rest_api.js
