require('dap-python').setup()
require("core.utils").load_mappings("dap_python")
table.insert(require('dap').configurations.python, {
  type = "python",
  request = "launch",
  name = "Debug Pytest",
  module = "pytest",
  args = {"${file}"},
})
