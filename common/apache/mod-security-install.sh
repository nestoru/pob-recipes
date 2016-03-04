#!/bin/bash -e
# common/packages/mod-security-install.sh

# install
apt-get update -y
apt-get install -y libapache2-mod-security2
# grep should make the script fail if the module is not installed
apachectl -M | grep security2_module
# version should come up and based on it download needed files
apt-cache policy libapache2-mod-security2
curl -o /etc/modsecurity/modsecurity.conf https://raw.githubusercontent.com/SpiderLabs/ModSecurity/v2.7.7/modsecurity.conf-recommended
curl -o /etc/modsecurity/unicode.mapping https://raw.githubusercontent.com/SpiderLabs/ModSecurity/v2.7.7/unicode.mapping
# activate core rules, sql and command injection
cp /usr/share/modsecurity-crs/modsecurity_crs_10_setup.conf /etc/modsecurity/
cp /usr/share/modsecurity-crs/base_rules/modsecurity_crs_41_sql_injection_attacks.conf /etc/modsecurity/
cp /usr/share/modsecurity-crs/base_rules/modsecurity_crs_40_generic_attacks.conf /etc/modsecurity/
cp /usr/share/modsecurity-crs/base_rules/modsecurity_40_generic_attacks.data /etc/modsecurity/
# enable protection and avoid logging just because a status code != 200
sed -i  's/^SecRuleEngine.*/SecRuleEngine On/' /etc/modsecurity/modsecurity.conf
sed -i  's/^SecAuditLogRelevantStatus.*/SecAuditLogRelevantStatus \"\^\$\"/' /etc/modsecurity/modsecurity.conf
service apache2 reload
