return
{
    'Civitasv/cmake-tools.nvim',
    opts = {
        cmake_command = 'cmake',
        ctest_command = 'ctest',
        cmake_use_preset = true,
        cmake_regenerate_on_save = true,
        cmake_generate_options = {
            '-DCMAKE_BUILD_TYPE=Debug',
            '-GNinja',
            '-DCMAKE_EXPORT_COMPILE_COMMANDS=TRUE',
        },
        cmake_build_options = {
            '--parallel 6',
        },
        cmake_soft_link_compile_commands = false,
        cmake_build_directory = 'build',
        cmake_kits_path = '~/.local/share/CMakeTools/cmake-tools-kits.json',
    },
}
