local U = require'snippets.utils'

return {
  date = [[${=os.date("%Y-%m-%d")}]];
  license = U.force_comment [[
SPDX-FileCopyrightText: ${=os.date("%Y")} Tobias Frilling
SPDX-License-Identifier: ]];
}
