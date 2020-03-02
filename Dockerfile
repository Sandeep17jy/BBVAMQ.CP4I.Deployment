FROM cp.icr.io/cp/icp4i/mq/ibm-mqadvanced-server-integration:9.1.3.0-r4-amd64
# Add the admin user as a member of the mqm group and set their password
USER root
RUN useradd admin -G mqm \
    && echo admin:passw0rd | chpasswd \
# Create the mqclient group
    && groupadd mqclient \
# Create the app user as a member of the mqclient group and set their password
    && useradd app -G mqclient \
    && echo app:passw0rd | chpasswd
# Copy the configuration script to /etc/mqm where it will be picked up automatically
USER mqm
COPY mqadvancedev.mqsc /etc/mqm/
ADD SampleTriggerRuleRequest.json /tmp/
ADD SampleTriggerRuleResponse.json /tmp/
ADD SampleXMLGenerationRuleRequest.json /tmp/
ADD SampleXMLGenerationRuleResponse.json /tmp/
