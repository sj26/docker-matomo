MATOMO_VERSION=3.7.0

download: matomo

matomo:
	wget -c "https://builds.matomo.org/piwik-${MATOMO_VERSION}.tar.gz"
	tar -x -s "/^piwik/matomo/" -zf "piwik-${MATOMO_VERSION}.tar.gz" "piwik/*"
