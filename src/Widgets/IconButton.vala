class IconButton : Gtk.Button
{
  public IconButton(string icon_name, string tooltip)
  {
    set_tooltip_text(tooltip);
    set_relief(Gtk.ReliefStyle.NONE);

    var image = new Gtk.Image.from_icon_name(icon_name, Gtk.IconSize.BUTTON);
    image.margin = 3;
    add(image);
  }
}