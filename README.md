## [Will Paginate][wp] link renderer styles for [Twitter Bootstrap 4][bs]

Rails Engine that extends [will_paginate][wp] stylings to match the pagination styling conventions
in Twitter's [Bootstrap][bs] 4 toolkit.

### Installation

Add to your Gemfile:  

    gem 'will_paginate-bootstrap4'

### Usage

Just like you would in the regular [will_paginate][wp].  If you've got a need to use the default will_paginate stylings,
pass an option like so:

    <%= will_paginate @collection, :renderer => WillPaginate::ActionView::BootstrapLinkRenderer %>


Copyright (c) 2016 [Ivan Palamarchuk](https://github.com/delef) released under the MIT license  

[wp]: http://github.com/mislav/will_paginate
[bs]: http://v4-alpha.getbootstrap.com/
