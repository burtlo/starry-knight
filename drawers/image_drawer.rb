class ImageDrawer < Metro::SceneView::Drawer

  draws 'image'

  def draw(view)
    Gosu::Image.new(window,asset_path(view["path"])).draw(view["x"],view["y"],1)
  end

end