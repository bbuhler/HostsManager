class HostsManager.Services.HostsRegex : Regex
{
  public HostsRegex(Value ipaddress_arg = "", Value hostname_arg = "")
  {
    string ipaddress = (string) ipaddress_arg != "" ? Regex.escape_string((string) ipaddress_arg) : """[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}""";
    string hostname = (string) hostname_arg != "" ? Regex.escape_string((string) hostname_arg) : "[a-z0-9.-]+";

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