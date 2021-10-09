local b = vim.b

b["ale_linters"] = { "tflint", "terraform" }
b["ale_fixers"] = { "terraform" }
b["terraform_fmt_on_save"] = 1
