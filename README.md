# Dots and configs
> Just another <a href="https://medium.com/@webprolific/getting-started-with-dotfiles-43c3602fd789">.files</a> and configurations repository, but these are my own.
>
> These .files aim to keep the **~** directory as clean as possible while having the different configuration files organized in a simple, maintainable and structured way.
<!-- > Furthermore, the `dot` command is included as a hub for the different scripts and utilities included in these .files. -->

<p><br><img src=".github/dot-demo.gif" width="90%">
<!--<br><sub>Simple, keyboard and terminal-based .files.</sub>-->
</p>

## Overview
This environment is intended to work in the [Arch Linux](https://archlinux.org/) distribution and uses [Qtile](http://www.qtile.org/) as its primary window manager. Nevertheless, configurations for the [bspwm](https://github.com/baskerville/bspwm) tiling window manager are also included.

In these .files, the <a href="bin/dot"><code>dot</code></a> command is provided to act as a hub for running the different scripts and utilities included, as well as for managing the .files themselves. It can be run as
```bash
dot <context> <script> [<args>...]
```
where a *context* is just a group of related scripts.
> **Tip.** A full list of the included scripts and their documentation is available by running <a href="bin/dot"><code>dot</code></a> without arguments or by the `Ctrl + F` keybind in your terminal of choice.

## Installation
> **Note.** It is strongly recommended to do the installation on a fresh Arch Linux installation. The installation of these .files in a Linux distro other than Arch on an already running system has not
> being tested and will more likely than not break some configurations, but in theory it should work. For this reason, it is encouraged to backup your stuff before either a manual or an automated
> installation in case something goes wrong.

Installing these .files is as simple as running
```bash
curl -s https://raw.githubusercontent.com/rixsilverith/dots/master/bootstrap.sh | bash
```

## Updating the .files
> **Note.** Updating the .files may break some configurations from time to time. It is recommended to check the latest commits in this repository before installing any update.

Use `dot self update` to check if a more recent version of the .files is available. If so, they will be updated to the latest version.

## Acknowledgements
- The `dot` command, as well as some scripts in these dotfiles, is pretty much based on the one [denisidoro](https://github.com/denisidoro/dotfiles) and [rgomezcasas](https://github.com/rgomezcasas/dotfiles) developed for their own dotfiles.

- The custom GTK theme and icons are the work of [Juicyexe](https://github.com/Juicyexe/arch-monochrome).

## License
The MIT License. See [License](LICENSE) for more information.
