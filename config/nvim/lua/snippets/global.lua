local U = require'snippets.utils'

return {
  date = [[${=os.date("%Y-%m-%d")}]];
  license_boost = U.force_comment [[
Copyright ${=os.date("%Y")} Tobias Frilling
Distributed under the Boost Software License, Version 1.0.
See accompanying file LICENSE or copy at https://www.boost.org/LICENSE_1_0.txt
]];
  license_mpl = U.force_comment [[
Copyright ${=os.date("%Y")} Tobias Frilling
This Source Code Form is subject to the terms of the Mozilla Public
License, v. 2.0. If a copy of the MPL was not distributed with this
file, You can obtain one at http://mozilla.org/MPL/2.0/.
]];
}
