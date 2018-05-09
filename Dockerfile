FROM opensuse:42.3

EXPOSE 80 443 22 24
COPY baseline /baseline
RUN /baseline/setup.sh
COPY preflight /preflight
RUN /preflight/setup.sh
RUN mkdir -p /files /repos && chown -R git:wwwgrp-phabricator /files /hostkeys/ /repos/
WORKDIR /srv/phabricator/phabricator/src/extensions
RUN zypper --non-interactive install wget && wget https://raw.githubusercontent.com/arielyang/phabricator_zh_Hans/master/dist/PhabricatorSimplifiedChineseTranslation.php
CMD ["/bin/bash", "/app/init.sh"]
