foreach binname : ['clang-format', 'uncrustify']
  configure_file(input: '@0@.in'.format(binname),
    output: binname,
    configuration: conf_data,
    install: true,
    install_dir: sdk_bindir,
    install_mode: 'rwxr-xr-x')
endforeach
