# Matomo on Docker

Run Matomo on Docker using Ubuntu 18.04 Bionic LTS with Apache 2.4 and PHP 7.2.

Apache runs with HTTP on port 80 and HTTPS on port 443 with a self-signed cert.
Use the HTTPS as a transport layer encryption only, you should probably be
reverse proxying from something else like an AWS ALB.

Permissions are locked down as much as possible, and apache is configured to
respect matomo's override files to avoid leaking the whole web directory.

## TODO

- S3 config sync
- S3 piwik.js sync
- Tracker proxy
