local g = vim.g

g["ale_echo_msg_format"] = "[%severity%][%linter%] %s"
g["ale_fix_on_save"] = 1
g["ale_fixers"] = { ["*"] = { "remove_trailing_lines", "trim_whitespace" } }
g["ale_lint_on_text_changed"] = "normal"
g["ale_linters_explicit"] = 1
g["ale_sign_error"] = "✘"
g["ale_sign_warning"] = "⚠"
