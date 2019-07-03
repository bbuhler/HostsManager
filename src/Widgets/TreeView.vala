class HostsManager.TreeView : Gtk.TreeView
{
  public Gtk.CellRendererToggle toggle_cell;
  public signal void active_toggled(Gtk.CellRendererToggle toggle, Gtk.TreeIter iter, GLib.Value ipaddress, GLib.Value hostname);

  public Gtk.CellRendererText ipaddress_cell;
  public int ipaddress_column;
  public signal void ipaddress_added(Gtk.TreeIter iter, string ipaddress, string hostname);
  public signal void ipaddress_edited(Gtk.TreeIter iter, Value ipaddress, Value hostname, string new_ipaddress);

  public Gtk.CellRendererText hostname_cell;
  public int hostname_column;
  public signal void hostname_added(Gtk.TreeIter iter, string ipaddress, string hostname);
  public signal void hostname_edited(Gtk.TreeIter iter, Value ipaddress, Value hostname, string new_hostname);

  public enum Columns
  {
    COMPLETE,
    ENABLED,
    IPADDRESS,
    HOSTNAME,
    N_COLUMNS,
  }

  public TreeView(Gtk.ListStore model)
  {
    set_model(model);

    set_rubber_banding(true);
    set_enable_search(true);
    set_search_column(Columns.HOSTNAME);

    toggle_cell = new Gtk.CellRendererToggle();

    ipaddress_cell = new Gtk.CellRendererText();
    ipaddress_cell.editable = true;

    hostname_cell = new Gtk.CellRendererText();
    hostname_cell.editable = true;

    insert_column_with_attributes(-1, _("Active"), toggle_cell, "active", Columns.ENABLED, "sensitive", Columns.COMPLETE);
    ipaddress_column = insert_column_with_attributes(-1, _("IP Address"), ipaddress_cell, "text", Columns.IPADDRESS);
    hostname_column = insert_column_with_attributes(-1, _("Hostname"), hostname_cell, "text", Columns.HOSTNAME);

    toggle_cell.toggled.connect((toggle, path) =>
    {
      Gtk.TreeIter edited_iter;
      GLib.Value ipaddress;
      GLib.Value hostname;

      model.get_iter(out edited_iter, new Gtk.TreePath.from_string(path));
      model.get_value(edited_iter, Columns.IPADDRESS, out ipaddress);
      model.get_value(edited_iter, Columns.HOSTNAME, out hostname);

      active_toggled(toggle, edited_iter, ipaddress, hostname);
    });

    ipaddress_cell.edited.connect((path, new_ipaddress) =>
    {
      Gtk.TreeIter edited_iter;
      Value current_ipaddress;
      Value current_hostname;
      Value is_complete;

    	model.get_iter(out edited_iter, new Gtk.TreePath.from_string(path));
    	model.get_value(edited_iter, Columns.IPADDRESS, out current_ipaddress);
    	model.get_value(edited_iter, Columns.HOSTNAME, out current_hostname);
      model.get_value(edited_iter, Columns.COMPLETE, out is_complete);

      if ((string) current_ipaddress == new_ipaddress)
      {
        return;
      }

      if ((bool) is_complete == false)
      {
        ipaddress_added(edited_iter, new_ipaddress, (string) current_hostname);
      }
      else
      {
        ipaddress_edited(edited_iter, current_ipaddress, current_hostname, new_ipaddress);
      }
    });

    hostname_cell.edited.connect((path, new_hostname) =>
    {
      Gtk.TreeIter edited_iter;
      Value current_ipaddress;
      Value current_hostname;
      Value is_complete;

    	model.get_iter(out edited_iter, new Gtk.TreePath.from_string(path));
    	model.get_value(edited_iter, Columns.IPADDRESS, out current_ipaddress);
    	model.get_value(edited_iter, Columns.HOSTNAME, out current_hostname);
      model.get_value(edited_iter, Columns.COMPLETE, out is_complete);

      if ((string) current_hostname == new_hostname)
      {
        return;
      }

      if ((bool) is_complete == false)
      {
        hostname_added(edited_iter, (string) current_ipaddress, new_hostname);
      }
      else
      {
        hostname_edited(edited_iter, current_ipaddress, current_hostname, new_hostname);
      }
    });
  }

  public void focus_ipaddress(Gtk.TreeIter iter)
  {
    Gtk.TreeViewColumn column = get_column(ipaddress_column - 1);

    Timeout.add(1, () => // TODO find better solution to avoid _gtk_tree_view_remove_editable failed error
    {
      set_cursor_on_cell(model.get_path(iter), column, ipaddress_cell, true);
      return false;
    });
  }

  public void focus_hostname(Gtk.TreeIter iter)
  {
    Gtk.TreeViewColumn column = get_column(hostname_column - 1);

    Timeout.add(1, () => // TODO find better solution to avoid _gtk_tree_view_remove_editable failed error
    {
      set_cursor_on_cell(model.get_path(iter), column, hostname_cell, true);
      return false;
    });
  }
}