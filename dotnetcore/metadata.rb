name             'dotnetcore'
maintainer       'Andrew Cornies'
maintainer_email 'acornies@gmail.com'
license          'All rights reserved'
description      'Installs/Configures dotnetcore'
long_description 'Installs/Configures dotnetcore'
version          '1.1.0'

depends 'apt', '~> 2.9.2'

supports 'ubuntu', '= 14.04'
supports 'windows'

provides 'dotnetcore::default'

source_url 'https://github.com/acornies/dotnetcore-cookbook'
issues_url 'https://github.com/acornies/dotnetcore-cookbook/issues'

long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))