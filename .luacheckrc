std = "luajit"
max_line_length = 80

exclude_files = {
    ".luarocks/",
}

globals = {
    "vim",
}

files["spec/"] = {
    std = "+busted",
}
