rockspec_format = "3.0"
package = "simple-zoom.nvim"
version = "scm-1"
source = {
    url = "git+https://github.com/fasterius/simple-zoom.nvim",
}
dependencies = {}
test_dependencies = {
    "nlua",
}
build = {
    type = "builtin",
    copy_directories = {
        "plugin",
    },
}
