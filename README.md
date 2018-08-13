# HostsManager App

Managing your `/etc/hosts` file.

### Compile & install
```sh
meson build --prefix=/usr
cd build
ninja
sudo ninja install
```

### Features / ToDo
- [x] Show IP addresses and hostnames
- [x] Show inactive toggle button for comment out ones
- [x] Toggle button should add/remove line comment (#1)
- [ ] Add new entry (#2)
- [ ] Edit entry (#3)
- [ ] Remove entry
- [ ] Grouping / sections
- [ ] Edit IP address of multiple selected entries
- [ ] Automatically update IP addresses using `dig` (?)
