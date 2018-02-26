public class MyApp : Gtk.Application {

    public MyApp () {
        Object (
            application_id: "com.github.bbuhler.hosts-app",
            flags: ApplicationFlags.FLAGS_NONE
        );
    }

    private enum Columns {
        ENABLED,
        IPADDRESS,
        HOSTNAME,
        N_COLUMNS
    }

    protected override void activate () {
		var hosts_text = this.readFile("/etc/hosts");
        
        var list_store = new Gtk.ListStore (Columns.N_COLUMNS, typeof (bool), typeof (string), typeof (string));
        var iter = Gtk.TreeIter ();
        		
        try {
            for (GLib.MatchInfo mi = parseHosts (hosts_text) ; mi.matches () ; mi.next ()) {
//                GLib.message ("%s, %s, %s", mi.fetch (2), mi.fetch(3), mi.fetch(4));
		        list_store.append (out iter);
		        list_store.set (iter, 
		            Columns.ENABLED,    mi.fetch (2) != "#", 
		            Columns.IPADDRESS,  mi.fetch (3), 
		            Columns.HOSTNAME,   mi.fetch (4)
	            );
            }
        } catch (GLib.Error e) {
            GLib.error ("Regex failed: %s", e.message);
        }
		
        var tree_view = new Gtk.TreeView.with_model (list_store);
        tree_view.rubber_banding = true;
        tree_view.headers_clickable = true;
        tree_view.enable_search = true;
        tree_view.search_column = Columns.HOSTNAME;

        var toggle = new Gtk.CellRendererToggle ();
		var cell = new Gtk.CellRendererText ();
		tree_view.insert_column_with_attributes (-1, "Active", toggle, "active", Columns.ENABLED);
		tree_view.insert_column_with_attributes (-1, "IP Address", cell, "text", Columns.IPADDRESS);
		tree_view.insert_column_with_attributes (-1, "Hostname", cell, "text", Columns.HOSTNAME);
        
        var main_window = new Gtk.ApplicationWindow (this);
        main_window.default_height = 400;
        main_window.default_width = 600;
        main_window.title = "/etc/hosts";
        main_window.add (tree_view);
        main_window.show_all ();
    }

    public static int main (string[] args) {
        var app = new MyApp ();
        return app.run (args);
    }
    
    private string readFile (string file_name) {
        var file_contents = "";
        
        try {
            GLib.FileUtils.get_contents (file_name, out file_contents, null);
        } catch (GLib.Error e) {
            GLib.error ("Unable to read file: %s", e.message);
        }
        
        return file_contents;
    }
    
    private GLib.MatchInfo parseHosts (string hosts_text) {
		var exp = /((#?)\s?([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3})\s+([a-z0-9.-]+))/;
		
        GLib.MatchInfo mi;
        exp.match (hosts_text, 0, out mi);
        return mi;
    }
}
