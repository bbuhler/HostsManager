# HostsManager App

Managing your `/ets/hosts` file easily.

### Compile & install
```sh
mkdir build && cd build
cmake -DCMAKE_INSTALL_PREFIX=/usr ../
make
sudo make install
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