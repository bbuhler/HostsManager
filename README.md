# HostsManager App

Managing your `/ets/hosts` file easily.

### Compile
```sh
$ valac --pkg gtk+-3.0 src/HostsManager.vala
```

### Run
```
sudo ./HostsManager
```

For the time of being we need to execute with `sudo` to save changes to `/etc/hosts`.

This will change with implementation of Polkit (#4).

### Features / ToDo
- [x] Show IP addresses and hostnames
- [x] Show inactive toggle button for comment out ones
- [x] Toggle button should add/remove line comment (#1)
- [ ] Add new entry (#2)
- [ ] Edit entry (#3)
- [ ] Remove entry
- [ ] Edit IP address of multiple selected entries
- [ ] Automatically update IP addresses using `dig`