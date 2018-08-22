class HostsManager.Services.HostsFile
{
  private string hostsFileName = "/etc/hosts";
  private string hostsFileContent;

  public HostsFile()
  {
    readFile();
  }

  public MatchInfo getEntries()
  {
    MatchInfo entries;
    HostsRegex regex = new HostsRegex();
    regex.match(hostsFileContent, 0, out entries);
    return entries;
  }

  public void setEnabled(HostsRegex modRegex, bool active)
  {
    try
    {
      hostsFileContent = modRegex.replace(hostsFileContent, -1, 0, active ? """\n#\g<row>""" : """\g<row>""");
      saveFile();
    }
    catch (Error e)
    {
      GLib.error("Regex failed: %s", e.message);
    }
  }

  public void setIpAddress(HostsRegex modRegex, string ipaddress)
  {
    try
    {
      hostsFileContent = modRegex.replace(hostsFileContent, -1, 0, """\g<enabled>""" + ipaddress + """\g<divider>\g<hostname>""");
      saveFile();
    }
    catch (Error e)
    {
      GLib.error("Regex failed: %s", e.message);
    }
  }

  public void setHostname(HostsRegex modRegex, string hostname)
  {
    try
    {
      hostsFileContent = modRegex.replace(hostsFileContent, -1, 0, """\g<enabled>\g<ipaddress>\g<divider>""" + hostname);
      saveFile();
    }
    catch (Error e)
    {
      GLib.error("Regex failed: %s", e.message);
    }
  }

  private void readFile()
  {
    try
    {
      FileUtils.get_contents(hostsFileName, out hostsFileContent, null);
    }
    catch (Error e)
    {
      GLib.error("Unable to read file: %s", e.message);
    }
  }

  private void saveFile()
  {
    try
    {
      FileUtils.set_contents(hostsFileName, hostsFileContent, hostsFileContent.length);
    }
    catch (Error e)
    {
      GLib.error("Unable to save file: %s", e.message);
    }
  }
}