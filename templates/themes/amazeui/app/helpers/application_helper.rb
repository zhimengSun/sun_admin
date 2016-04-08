module ApplicationHelper
  include SharedHelper if defined?(SharedHelper)
  def page_header(title)
    str = content_tag(:strong, title, class: "am-text-primary am-text-lg")
    div = content_tag(:div, str, class: "am-fl am-cf")
    content_tag(:div, div, class: "am-padding am-cf")
  end

  def table_class(style = "bordered")
    "am-table am-table-#{style} am-text-nowrap"
  end

  def button_class(opts = {})
    "am-btn am-btn-#{opts[:style] || "default"} am-btn-xs am-text-#{opts[:text_style] || "secondary"}"
  end

  def edit_with_delete(obj, opts = {})
    edit_btn = link_to(am_btn(" "), "/" + controller_name + "/#{obj.id}/edit", class: button_class)
    destroy_btn = link_to(am_btn(" ", icon: "trash"), obj, data: {confirm: "确定删除么?"}, method: :delete, class: button_class(text_style: "danger"))
    return edit_btn if opts[:hide_destory]
    content_tag(:div, edit_btn + destroy_btn, class: "am-btn-group am-btn-group-xs")
  end

  def submit_btn(title = t(:save), opts = {})
    submit_tag title, class: button_class(style: opts[:style] || 'success mr10'), data: {disable_with: "#{opts[:disable_with] || title}中..."}
  end

  def save_and_return(f) 
    sub_btn = submit_btn 
    td = content_tag(:td, sub_btn + link_to_back(url: "/#{controller_name}"), colspan: "10", align: "center")
    content_tag(:tr, td, style: 'text-align: center')
  end

  def am_btn(title, opts = {})
    span_class = "am-icon-#{opts[:icon] || "pencil-square"}-o"
    span = content_tag(:span, nil, class: span_class)
    span + title
  end

  def link_to_back(opts = {}, html_opts = {})
    link_to_btn title: t(:back), btn_style: 'primary', url: opts[:url]
  end

  def link_to_btn(opts = {}, html_opts = {})
    title = opts[:title] || 'title'
    size = opts[:size] || 'am-btn-big'
    btn_style = opts[:btn_style] || 'primary'
    style = {class: "am-btn am-btn-xs am-btn-#{btn_style} ml10 " + size}.merge(html_opts)
    return link_to title, opts[:url], style if opts[:url]
    link_to(title, '#', style.merge(onclick: "history.go(-1); return false;"))
  end

  def permission_collections(model_name, name, collection)
    collection_check_boxes model_name, name, collection, :id, :name do |b|
      b.label(class: "am-checkbox am-success") do
        b.check_box("data-am-ucheck" => "") + b.object.name
      end
    end
  end

  def back_button
    link_to_back
  end

  def top_menus
    menu = []
    login_menu = [{"login" => ""}]
    menus = [
      {'admin' => %w(users roles resources)}
    ]
    return login_menu unless current_user
    return menus if current_user.is_admin?
    menu
  end
end
