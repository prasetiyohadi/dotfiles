local b = vim.b

b["ale_fixers"] = { "prettier" }
b["ale_linters"] = { "jq" }
b["ale_javascript_prettier_options"] = { "--trailing-comma none" }
