class HostsManager.Services.HostsRegex : Regex
{
  public HostsRegex(Value ipaddress_arg = "", Value hostname_arg = "")
  {
    string ipaddress = (string) ipaddress_arg != "" ? Regex.escape_string((string) ipaddress_arg) : Config.ipaddress_regex_str;
    string hostname = (string) hostname_arg != "" ? Regex.escape_string((string) hostname_arg) : Config.hostname_regex_str;

    try
    {
      base("""(?P<enabled>#?)\s?(?P<row>(?P<ipaddress>""" + ipaddress + """)(?P<divider>\s+)(?P<hostname>""" + hostname + "))");
    }
    catch (Error e)
    {
      GLib.error("Regex failed: %s", e.message);
    }
  }
}