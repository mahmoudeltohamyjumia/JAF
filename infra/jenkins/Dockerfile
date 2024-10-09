FROM jenkins/jenkins:latest
ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false
RUN jenkins-plugin-cli --verbose --plugins "configuration-as-code:1850.va_a_8c31d3158b_ job-dsl:1.89 blueocean:1.27.16 workflow-job:1441.vb_2d416905b_35 workflow-cps:3969.vdc9d3a_efcc6a_ matrix-auth:3.2.2 robot:4.0.0 json-path-api:2.9.0-58.v62e3e85b_a_655"
COPY seedjob.groovy /usr/local/seedjob.groovy
COPY jenkins-casc.yaml /usr/local/jenkins-casc.yaml
ENV CASC_JENKINS_CONFIG /usr/local/jenkins-casc.yaml
