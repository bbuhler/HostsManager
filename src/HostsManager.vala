public class HostsManager.Main : Gtk.Application
{
  public Main()
  {
    Object
    (
      application_id: "com.github.bbuhler.hostsmanager",
      flags: ApplicationFlags.FLAGS_NONE
    );
  }

  public static int main(string[] args)
  {
    var app = new HostsManager.Main();
    return app.run(args);
  }

  private enum Columns
  {
    ENABLED,
    IPADDRESS,
    HOSTNAME,
    N_COLUMNS
  }

  protected override void activate()
  {
    var hostsFile = new Services.HostsFile();

    var list_store = new Gtk.ListStore(Columns.N_COLUMNS, typeof(bool), typeof(string), typeof(string));
    var iter = Gtk.TreeIter();

    try
    {
      for (MatchInfo mi = hostsFile.getEntries(); mi.matches(); mi.next())
      {
        list_store.append(out iter);
        list_store.set(iter,
          Columns.ENABLED,    mi.fetch_named("enabled") != "#",
          Columns.IPADDRESS,  mi.fetch_named("ipaddress"),
          Columns.HOSTNAME,   mi.fetch_named("hostname")
        );
      }
    }
    catch (Error e)
    {
      GLib.error("Regex failed: %s", e.message);
    }

    var tree_view = new Gtk.TreeView.with_model(list_store);
    tree_view.rubber_banding = true;
    tree_view.headers_clickable = true;
    tree_view.enable_search = true;
    tree_view.search_column = Columns.HOSTNAME;

    var tree_view_selection = tree_view.get_selection();
    tree_view_selection.set_mode(Gtk.SelectionMode.MULTIPLE);

    var toggle = new Gtk.CellRendererToggle();
    toggle.toggled.connect((toggle, path) =>
    {
      Gtk.TreeIter edited_iter;
      GLib.Value ipaddress;
      GLib.Value hostname;

      list_store.get_iter(out edited_iter, new Gtk.TreePath.from_string(path));
      list_store.get_value(edited_iter, Columns.IPADDRESS, out ipaddress);
      list_store.get_value(edited_iter, Columns.HOSTNAME, out hostname);

      Services.HostsRegex regex = new Services.HostsRegex(ipaddress, hostname);
      hostsFile.setEnabled(regex, toggle.active);

      list_store.set(edited_iter, Columns.ENABLED, !toggle.active);
    });

    var ip_cell = new Gtk.CellRendererText();
    ip_cell.editable = true;
    ip_cell.edited.connect((path, new_ipaddress) =>
    {
      Gtk.TreeIter edited_iter;
      Value current_ipaddress;
      Value current_hostname;

    	list_store.get_iter(out edited_iter, new Gtk.TreePath.from_string(path));
    	list_store.get_value(edited_iter, Columns.IPADDRESS, out current_ipaddress);
    	list_store.get_value(edited_iter, Columns.HOSTNAME, out current_hostname);

      if (current_ipaddress == new_ipaddress)
      {
        return;
      }

      try
      {
        Services.HostsRegex regex = new Services.HostsRegex(current_ipaddress, current_hostname);
        hostsFile.setIpAddress(regex, new_ipaddress);

        list_store.set(edited_iter, Columns.IPADDRESS, new_ipaddress);
      }
      catch(InvalidArgument err)
      {
        print("InvalidArgument: %s", err.message);
      }
    });

    var host_cell = new Gtk.CellRendererText();
    host_cell.editable = true;
    host_cell.edited.connect((path, new_hostname) =>
    {
      Gtk.TreeIter edited_iter;
      Value current_ipaddress;
      Value current_hostname;

    	list_store.get_iter(out edited_iter, new Gtk.TreePath.from_string(path));
    	list_store.get_value(edited_iter, Columns.IPADDRESS, out current_ipaddress);
    	list_store.get_value(edited_iter, Columns.HOSTNAME, out current_hostname);

      if (current_hostname == new_hostname)
      {
        return;
      }

      try
      {
        Services.HostsRegex regex = new Services.HostsRegex(current_ipaddress, current_hostname);
        hostsFile.setHostname(regex, new_hostname);

        list_store.set(edited_iter, Columns.HOSTNAME, new_hostname);
      }
      catch(InvalidArgument err)
      {
        print("InvalidArgument: %s", err.message);
      }
    });

    tree_view.insert_column_with_attributes(-1, _("Active"), toggle, "active", Columns.ENABLED);
    tree_view.insert_column_with_attributes(-1, _("IP Address"), ip_cell, "text", Columns.IPADDRESS);
    tree_view.insert_column_with_attributes(-1, _("Hostname"), host_cell, "text", Columns.HOSTNAME);

    var scroll = new Gtk.ScrolledWindow(null, null);
    scroll.set_policy(Gtk.PolicyType.AUTOMATIC, Gtk.PolicyType.AUTOMATIC);
    scroll.add(tree_view);

    var header_bar = new Gtk.HeaderBar();
    header_bar.set_title(Config.hostfile_path());
    header_bar.set_subtitle("HostsManager");
    header_bar.set_show_close_button(true);

    var main_window = new Gtk.ApplicationWindow(this);
    main_window.default_height = 600;
    main_window.default_width = 600;
    main_window.set_titlebar(header_bar);
    main_window.add(scroll);
    main_window.show_all();
  }
}
